//
//  SyncDownload.m
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ServerToDeviceSync.h"
#import "Constants.h"
#import "DataController.h"
#import "Difficulties.h"
#import "Users.h"
#import <AFNetworking.h>

@implementation ServerToDeviceSync {
    DataController *dataController;
}

const int AMOUNT = 2;

- (id)init {
    if (self = [super init]) {
        dataController = [[DataController alloc] init];
        return self;
    }
    return nil;
}

- (void)AllData {
    [self difficulties];
    [self energies];
    [self hotSpotActivities];
    [self hotSpotActivitiesDefault];
    [self hotSpotCategories];
    [self hotSpotCategoriesDefault];
    [self hotSpots];
    [self hotSpotsDefault];
    [self locations];
    [self periodTypes];
    [self priorities];
    [self qualities];
    [self rates];
    [self references];
    [self results];
    [self resultsLinks];
    [self resultsReferences];
    [self socialNetworks];
    [self tags];
    [self tagsResults];
    [self users];
    [self usersSocialNetworks];
    [self weekLimits];
}

#pragma mark Difficulties

- (void)difficulties {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Difficulties" inManagedObjectContext:dataController.managedObjectContext];
    [request setEntity:entity];
    //[request setFetchLimit:1];
    NSArray *sortDecriptors = [self getSortDescriptors:@"difficulty_level" UpdatedKey:@"difficulty_updated"];
    [request setSortDescriptors:sortDecriptors];
    NSError *error = nil;
    NSArray *results = [dataController.managedObjectContext executeFetchRequest:request error:&error];
    
    NSString *lastUpdatedDateString = @"0000-00-00 00:00:00";
    int lastId = 0;
    if (results.count > 0) {
        Difficulties *lastDifficulty = [results firstObject];
        NSDate *lastUpdatedDate = [NSDate dateWithTimeIntervalSinceReferenceDate:lastDifficulty.difficulty_updated];
        lastUpdatedDateString = [API dateToMySqlString:lastUpdatedDate];
        lastId = lastDifficulty.difficulty_level;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"Difficulties", @"table_name",
                             lastUpdatedDateString, @"last_updated",
         [NSString stringWithFormat:@"%d", lastId], @"last_id", nil];
    [self downloadDataFromServer:params Method:@selector(difficulties:)];
}

- (void)difficulties:(id)serverData {
    
    void ( ^ setItem )( id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Difficulties class]]) return;
        Difficulties *localDifficulty = localItem;
        localDifficulty.difficulty_level = [[serverItem valueForKey:@"difficulty_level"] intValue];
        localDifficulty.difficulty_name = [serverItem valueForKey:@"difficulty_name"];
        NSDate *difficulty_updated = [API mySqlStringToDate:[serverItem valueForKey:@"difficulty_updated"]];
        localDifficulty.difficulty_updated = [difficulty_updated timeIntervalSinceReferenceDate];
        localDifficulty.difficulty_deleted = [[serverItem valueForKey:@"difficulty_deleted"] boolValue];
    };
    
    NSString *tableNameKey = @"Difficulties";
    NSString *deletedKey = @"difficulty_deleted";
    NSString *idKey = @"difficulty_level";
    NSString *id2Key = nil;
    SEL nextBlockOfItems = @selector(difficulties);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems TableName:tableNameKey IdKey:idKey Id2Key:id2Key DeletedKey:deletedKey];
    }

- (void)handleServerData:(id)serverData SetItemMethod:(void (^)( id, NSArray *))setItem NextBlockOfItemsMethod:(SEL)nextBlockOfItems TableName:(NSString *)tableNameKey IdKey:(NSString *)idKey Id2Key:(NSString *)id2Key DeletedKey:(NSString *)deletedKey {
    if (![serverData isKindOfClass:[NSArray class]]) return;
    
    for (NSArray *serverItem in serverData) {
        BOOL deleted = [[serverItem valueForKey:deletedKey] boolValue];
        BOOL exists = NO;
        id localItem = nil;
        
        id (^getLocalItem)(void) = ^{
            id result = nil;
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:tableNameKey
                                                      inManagedObjectContext:dataController.managedObjectContext];
            [request setEntity:entity];
            
            NSNumber *itemId = [NSNumber numberWithInteger:[[serverItem valueForKey:idKey] integerValue]];
            NSNumber *itemId2 = id2Key ? [NSNumber numberWithInteger:[[serverItem valueForKey:id2Key] integerValue]] : nil;
            NSPredicate *predicate;
            if (!id2Key)
                predicate = [NSPredicate predicateWithFormat:@"%K = %@", idKey, itemId];
            else
                predicate = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@", idKey, itemId, id2Key, itemId2];
            [request setPredicate:predicate];
            NSError *error;
            NSArray *itemArray = [dataController.managedObjectContext executeFetchRequest:request error:&error];
            if (itemArray.count > 0)
                result = [itemArray firstObject];
            return result;
        };
        
        localItem = getLocalItem();
        if (localItem) {
            exists = YES;
        }
        
        if (!deleted && !exists) {
            // добавление
            localItem = [NSEntityDescription insertNewObjectForEntityForName:tableNameKey inManagedObjectContext:dataController.managedObjectContext];
            setItem(localItem, serverItem);
            NSLog(@"Added item: %@", localItem);
        } else if (!deleted && exists) {
            // обновление
            setItem(localItem, serverItem);
            NSLog(@"Updated item: %@", localItem);
        } else if (deleted && exists) {
            // удаление
            [dataController.managedObjectContext deleteObject:localItem];
            NSLog(@"Deleted item: %@", localItem);
        }
    }
    
    NSError *error = nil;
    if (![dataController.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    if ([serverData count] == AMOUNT && [self respondsToSelector:nextBlockOfItems])
        [self performSelector:nextBlockOfItems];
}

- (void)energies {
    
}

- (void)hotSpotActivities {
    
}

- (void)hotSpotActivitiesDefault {
    
}

- (void)hotSpotCategories {
    
}

- (void)hotSpotCategoriesDefault {
    
}

- (void)hotSpots {
    
}

- (void)hotSpotsDefault {
    
}

- (void)locations {
    
}

- (void)periodTypes {
    
}

- (void)priorities {
    
}

- (void)qualities {
    
}

- (void)rates {
    
}

- (void)references {
    
}

- (void)results {
    
}

- (void)resultsLinks {
    
}

- (void)resultsReferences {
    
}

- (void)socialNetworks {
    
}

- (void)tags {
    
}

- (void)tagsResults {
    
}

- (void)users {
    
}

- (void)usersSocialNetworks {
    
}

- (void)weekLimits {
    
}

- (void)downloadDataFromServer:(NSMutableDictionary *)params Method:(SEL)method {
    long user_id = [dataController getUserId];
    [params setValuesForKeysWithDictionary:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                            @"API", @"className",
                                 @"serverToDevice", @"methodName",
       [NSString stringWithFormat:@"%ld", user_id], @"user_id",
         [NSString stringWithFormat:@"%i", AMOUNT], @"amount", nil]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiURL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([self respondsToSelector:method])
            [self performSelector:method withObject:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog([NSString stringWithFormat:@"Error: %@", error]);
    }];
}

#pragma mark - Additional Functions

- (NSArray *)getSortDescriptors:(NSString *)idKey UpdatedKey:(NSString *)updatedKey {
    NSSortDescriptor *idSortDescriptor = [[NSSortDescriptor alloc] initWithKey:idKey ascending:NO];
    NSSortDescriptor *updatedSortDescriptor = [[NSSortDescriptor alloc] initWithKey:updatedKey ascending:NO];
    NSArray *result = [NSArray arrayWithObjects:idSortDescriptor, updatedSortDescriptor, nil];
    return result;
}

- (NSArray *)getSortDescriptors:(NSString *)idKey Id2Key:(NSString *)id2Key UpdatedKey:(NSString *)updatedKey {
    NSSortDescriptor *id2SortDescriptor = [[NSSortDescriptor alloc] initWithKey:id2Key ascending:NO];
    NSMutableArray *result = [self getSortDescriptors:idKey UpdatedKey:updatedKey];
    [result insertObject:id2SortDescriptor atIndex:1];
    return result;
}

@end
