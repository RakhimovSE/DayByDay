//
//  ServerToDeviceSync.m
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ServerToDeviceSync.h"
#import <AFNetworking.h>
#import "Constants.h"
#import "DataController.h"
// Переделать БД
#import "Difficulties.h"
#import "Energies.h"
#import "HotSpotActivities.h"
#import "HotSpotActivitiesDefault.h"
#import "HotSpotCategories.h"
#import "HotSpotCategoriesDefault.h"
#import "HotSpots.h"
#import "Users.h"
#import "Variables.h"

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

- (void)syncAllData:(NSDate *)lastSync {
    [self difficulties:lastSync];
    [self energies:lastSync];
    [self hotSpotActivities:lastSync];
    [self hotSpotActivitiesDefault:lastSync];
    [self hotSpotCategories:lastSync];
    [self hotSpotCategoriesDefault:lastSync];
    [self hotSpots:lastSync];
    [self hotSpotsDefault:lastSync];
    [self locations:lastSync];
    [self periodTypes:lastSync];
    [self priorities:lastSync];
    [self qualities:lastSync];
    [self rates:lastSync];
    [self references:lastSync];
    [self results:lastSync];
    [self resultsLinks:lastSync];
    [self resultsReferences:lastSync];
    [self socialNetworks:lastSync];
    [self tags:lastSync];
    [self tagsResults:lastSync];
    [self users:lastSync];
    [self usersSocialNetworks:lastSync];
    [self weekLimits:lastSync];
}

#pragma mark Difficulties
- (void)difficulties:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                    @"Difficulties", @"entityName",
                                                @"difficulty_level", @"entityId",
                                                                @"", @"entityId2",
                                              @"difficulty_updated", @"entityUpdated",
                                              @"difficulty_deleted", @"entityDeleted", nil];
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames
                                       LastUpdatedDate:lastUpdatedDate
                                       ResponseHandler:@selector(difficultiesHandler:EntityAttributeNames:)];
}
- (void)difficultiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Difficulties class]]) return;
        Difficulties *localDifficulty = localItem;
        localDifficulty.difficulty_level = [[serverItem valueForKey:@"difficulty_level"] intValue];
        localDifficulty.difficulty_name = [serverItem valueForKey:@"difficulty_name"];
        NSDate *difficulty_updated = [API mySqlStringToDate:[serverItem valueForKey:@"difficulty_updated"]];
        localDifficulty.difficulty_updated = [difficulty_updated timeIntervalSinceReferenceDate];
        localDifficulty.difficulty_deleted = [[serverItem valueForKey:@"difficulty_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(difficulties:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Energies
- (void)energies:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"Energies", @"entityName",
                                            @"energy_level", @"entityId",
                                                        @"", @"entityId2",
                                          @"energy_updated", @"entityUpdated",
                                          @"energy_deleted", @"entityDeleted", nil];
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames
                                       LastUpdatedDate:lastUpdatedDate
                                       ResponseHandler:@selector(difficultiesHandler:EntityAttributeNames:)];
}
- (void)energiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Energies class]]) return;
        Energies *localEnergy = localItem;
//        localEnergy.energy_level = [[serverItem valueForKey:entityAttributeNames[@"entityId"]] intValue];
//        localDifficulty.difficulty_name = [serverItem valueForKey:@"difficulty_name"];
//        NSDate *difficulty_updated = [API mySqlStringToDate:[serverItem valueForKey:@"difficulty_updated"]];
//        localDifficulty.difficulty_updated = [difficulty_updated timeIntervalSinceReferenceDate];
//        localDifficulty.difficulty_deleted = [[serverItem valueForKey:@"difficulty_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(difficulties:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotActivities
- (void)hotSpotActivities:(NSDate *)lastUpdatedDate {
    
}
- (void)hotSpotActivitiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark HotSpotActivitiesDefault
- (void)hotSpotActivitiesDefault:(NSDate *)lastUpdatedDate {
    
}
- (void)hotSpotActivitiesDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark HotSpotCategories
- (void)hotSpotCategories:(NSDate *)lastUpdatedDate {
    
}
- (void)hotSpotCategoriesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark HotSpotCategoriesDefault
- (void)hotSpotCategoriesDefault:(NSDate *)lastUpdatedDate {
    
}
- (void)hotSpotCategoriesDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark HotSpots
- (void)hotSpots:(NSDate *)lastUpdatedDate {
    
}
- (void)hotSpotsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark HotSpotsDefault
- (void)hotSpotsDefault:(NSDate *)lastUpdatedDate {
    
}
- (void)hotSpotsDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Locations
- (void)locations:(NSDate *)lastUpdatedDate {
    
}
- (void)locationsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {

}

#pragma mark PeriodTypes
- (void)periodTypes:(NSDate *)lastUpdatedDate {
    
}
- (void)periodTypesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Priorities
- (void)priorities:(NSDate *)lastUpdatedDate {
    
}
- (void)prioritiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Qualities
- (void)qualities:(NSDate *)lastUpdatedDate {
    
}
- (void)qualitiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Rates
- (void)rates:(NSDate *)lastUpdatedDate {
    
}
- (void)ratesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark References
- (void)references:(NSDate *)lastUpdatedDate {
    
}
- (void)referencesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Results
- (void)results:(NSDate *)lastUpdatedDate {
    
}
- (void)resultsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark ResultsLinks
- (void)resultsLinks:(NSDate *)lastUpdatedDate {
    
}
- (void)resultsLinksHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark ResultsReferences
- (void)resultsReferences:(NSDate *)lastUpdatedDate {
    
}
- (void)resultsReferencesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark SocialNetworks
- (void)socialNetworks:(NSDate *)lastUpdatedDate {
    
}
- (void)socialNetworksHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Tags
- (void)tags:(NSDate *)lastUpdatedDate {
    
}
- (void)tagsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark TagsResults
- (void)tagsResults:(NSDate *)lastUpdatedDate {
    
}
- (void)tagsResultsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Users
- (void)users:(NSDate *)lastUpdatedDate {
    
}
- (void)usersHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark UsersSocialNetworks
- (void)usersSocialNetworks:(NSDate *)lastUpdatedDate {
    
}
- (void)usersSocialNetworksHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark WeekLimits
- (void)weekLimits:(NSDate *)lastUpdatedDate {
    
}
- (void)weekLimitsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark - Additional Functions

- (void)createFirstPartOfRequestAndCallRequestMethod:(NSDictionary *)entityAttributeNames
                                     LastUpdatedDate:(NSDate *)lastUpdatedDate
                                     ResponseHandler:(SEL)responseHandler {
    NSString *entityName    = entityAttributeNames[@"entityName"];
    NSString *entityId      = entityAttributeNames[@"entityId"];
    NSString *entityId2     = entityAttributeNames[@"entityId2"];
    if ([entityId2 isEqualToString:@""]) entityId2 = nil;
    NSString *entityUpdated = entityAttributeNames[@"entityUpdated"];
    
    id (^getLastElement)(void) = ^{
        id result = nil;
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:dataController.managedObjectContext];
        [request setEntity:entity];
        [request setFetchLimit:1];
        NSArray *sortDecriptors = !entityId2 ? [self getSortDescriptors:entityId UpdatedKey:entityUpdated] :
                                               [self getSortDescriptors:entityId Id2Key:entityId2 UpdatedKey:entityUpdated];
        [request setSortDescriptors:sortDecriptors];
        NSError *error = nil;
        NSArray *elementsArray = [dataController.managedObjectContext executeFetchRequest:request error:&error];
        result = elementsArray.count > 0 ? [elementsArray firstObject] : nil;
        return result;
    };
    
    id lastElement = getLastElement();
    int lastId = 0;
    int lastId2 = 0;
    // If exists at least one element, get IDs of the last
    if (lastElement) {
        lastId = [[lastElement valueForKey:entityId] intValue];
        if (entityId2) lastId2 = [[lastElement valueForKey:entityId2] intValue];
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                                entityName, @"table_name",
                                   [API dateToMySqlString:lastUpdatedDate], @"last_updated",
                                 [NSString stringWithFormat:@"%d", lastId], @"last_id", nil];
    if (entityId2) [params setObject:[NSString stringWithFormat:@"%d", lastId2] forKey:entityId2];
    [self downloadDataFromServer:params
                 ResponseHandler:responseHandler
            EntityAttributeNames:entityAttributeNames];
}

- (void)downloadDataFromServer:(NSMutableDictionary *)params
               ResponseHandler:(SEL)responseHandler
          EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
    long user_id = [dataController getUserId];
    [params setValuesForKeysWithDictionary:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                            @"API", @"className",
                                 @"serverToDevice", @"methodName",
       [NSString stringWithFormat:@"%ld", user_id], @"user_id",
         [NSString stringWithFormat:@"%i", AMOUNT], @"amount", nil]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiURL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([self respondsToSelector:responseHandler])
            [self performSelector:responseHandler withObject:responseObject withObject:entityAttributeNames];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog([NSString stringWithFormat:@"Error: %@", error]);
    }];
}

- (void)handleServerData:(id)serverData
           SetItemMethod:(void (^)(id, NSArray *))setItem
  NextBlockOfItemsMethod:(SEL)nextBlockOfItems
    EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
    if (![serverData isKindOfClass:[NSArray class]]) return;
    NSString *entityName    = entityAttributeNames[@"entityName"];
    NSString *entityId      = entityAttributeNames[@"entityId"];
    NSString *entityId2     = entityAttributeNames[@"entityId2"];
    if ([entityId2 isEqualToString:@""]) entityId2 = nil;
    NSString *entityUpdated = entityAttributeNames[@"entityUpdated"];
    NSString *entityDeleted = entityAttributeNames[@"entityDeleted"];
    
    for (NSArray *serverItem in serverData) {
        id (^getLocalItem)(void) = ^{
            id result = nil;
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                                      inManagedObjectContext:dataController.managedObjectContext];
            [request setEntity:entity];
            
            NSNumber *itemId = [NSNumber numberWithInteger:[[serverItem valueForKey:entityId] integerValue]];
            NSNumber *itemId2 = entityId2 ? [NSNumber numberWithInteger:[[serverItem valueForKey:entityId2] integerValue]] : nil;
            NSPredicate *predicate;
            if (!entityId2)
                predicate = [NSPredicate predicateWithFormat:@"%K = %@", entityId, itemId];
            else
                predicate = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@", entityId, itemId, entityId2, itemId2];
            [request setPredicate:predicate];
            NSError *error;
            NSArray *itemArray = [dataController.managedObjectContext executeFetchRequest:request error:&error];
            if (itemArray.count > 0)
                result = [itemArray firstObject];
            return result;
        };
        
        id localItem = getLocalItem();
        BOOL deleted = [[serverItem valueForKey:entityDeleted] boolValue];
        BOOL exists = (BOOL)localItem;
        
        if (!deleted && !exists) {
            // добавление
            localItem = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                      inManagedObjectContext:dataController.managedObjectContext];
            setItem(localItem, serverItem);
        } else if (!deleted && exists) {
            // обновление
            setItem(localItem, serverItem);
        } else if (deleted && exists) {
            // удаление
            [dataController.managedObjectContext deleteObject:localItem];
        }
    }
    
    [dataController.app saveContext];
    if ([serverData count] == AMOUNT && [self respondsToSelector:nextBlockOfItems]) {
        NSString *lastElementUpdatedDateString = [[serverData lastObject] valueForKey:entityUpdated];
        NSDate *lastElementUpdatedDate = [API mySqlStringToDate:lastElementUpdatedDateString];
        [self performSelector:nextBlockOfItems withObject:lastElementUpdatedDate];
    }
}

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
