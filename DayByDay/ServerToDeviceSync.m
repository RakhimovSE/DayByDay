//
//  ServerToDeviceSync.m
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ServerToDeviceSync.h"
#import <AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import "MenuTableViewController.h"

#import "Constants.h"
#import "DataController.h"
#import "Difficulties.h"
#import "Energies.h"
#import "HotSpotActivities.h"
#import "HotSpotActivitiesDefault.h"
#import "HotSpotCategories.h"
#import "HotSpotCategoriesDefault.h"
#import "HotSpots.h"
#import "HotSpotsDefault.h"
#import "Locations.h"
#import "PeriodTypes.h"
#import "Priorities.h"
#import "Qualities.h"
#import "Rates.h"
#import "References.h"
#import "Results.h"
#import "Results_Relationships.h"
#import "Results_References.h"
#import "SocialNetworks.h"
#import "Tags.h"
#import "TagsDefault.h"
#import "Tags_Results.h"
#import "Users.h"
#import "Users_SocialNetworks.h"
#import "Variables.h"

@implementation ServerToDeviceSync {
    DataController *dataController;
    NSArray *syncWaves;
    NSDictionary *lastElementParamsOnFirstSync;
    NSDate *lastElementUpdatedDate;
    long user_id;
    UIImageView *userAvatarImageView;
}

const int AMOUNT = 1000;

- (id)initWithLastSync:(NSDate *)lastSync {
    if (self = [super init]) {
        dataController = [[DataController alloc] init];
        NSMutableDictionary *syncWave0 = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:FALSE], @"users:", nil];
        NSMutableDictionary *syncWave1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [NSNumber numberWithBool:FALSE], @"socialNetworks:",
                                          [NSNumber numberWithBool:FALSE], @"rates:",
                                          [NSNumber numberWithBool:FALSE], @"tagsDefault:",
                                          [NSNumber numberWithBool:FALSE], @"hotSpotCategoriesDefault:",
                                          [NSNumber numberWithBool:FALSE], @"hotSpotActivitiesDefault:",
                                          [NSNumber numberWithBool:FALSE], @"priorities:",
                                          [NSNumber numberWithBool:FALSE], @"energies:",
                                          [NSNumber numberWithBool:FALSE], @"difficulties:",
                                          [NSNumber numberWithBool:FALSE], @"qualities:",
                                          [NSNumber numberWithBool:FALSE], @"periodTypes:", nil];
        NSMutableDictionary *syncWave2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [NSNumber numberWithBool:FALSE], @"hotSpotsDefault:",
                                          [NSNumber numberWithBool:FALSE], @"hotSpotCategories:",
                                          [NSNumber numberWithBool:FALSE], @"hotSpotActivities:",
                                          [NSNumber numberWithBool:FALSE], @"users_SocialNetworks:",
                                          [NSNumber numberWithBool:FALSE], @"tags:",
                                          [NSNumber numberWithBool:FALSE], @"locations:",
                                          [NSNumber numberWithBool:FALSE], @"references:", nil];
        NSMutableDictionary *syncWave3 = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:FALSE], @"hotSpots:", nil];
        NSMutableDictionary *syncWave4 = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:FALSE], @"results:", nil];
        NSMutableDictionary *syncWave5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [NSNumber numberWithBool:FALSE], @"tags_Results:",
                                          [NSNumber numberWithBool:FALSE], @"results_References:",
                                          [NSNumber numberWithBool:FALSE], @"results_Relationships:", nil];
        syncWaves = [NSArray arrayWithObjects:syncWave0, syncWave1, syncWave2, syncWave3, syncWave4, syncWave5, nil];
        lastElementUpdatedDate = lastSync;
        lastElementParamsOnFirstSync = [NSDictionary dictionaryWithObjectsAndKeys:lastSync, @"last_updated", nil];
        user_id = [dataController getUserId];
        return self;
    }
    return nil;
}

- (void)syncAllData {
    [self getServerDate];
}

#pragma mark - Sync Waves
- (void)getServerDate {
    Variables *lastSyncLocal = [Variables getVariableWithKey:@"lastSyncLocal"];
    lastSyncLocal.variable_value = [NSDate date];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"API", @"className",
                                   @"getServerDate", @"methodName", nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Variables *lastSyncServer = [Variables getVariableWithKey:@"lastSyncServer"];
        NSDate *serverDate = [API dateFromMySqlString:[responseObject valueForKey:@"serverDate"]];
        lastSyncServer.variable_value = serverDate;
        [self syncWave0];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog([NSString stringWithFormat:@"Error: %@", error]);
        [self finishSyncWithSuccess:NO];
    }];
}
- (void)syncWave0 {
    [self users:lastElementParamsOnFirstSync];
}

- (void)syncWave1 {
    [self socialNetworks:lastElementParamsOnFirstSync];
    [self rates:lastElementParamsOnFirstSync];
    [self tagsDefault:lastElementParamsOnFirstSync];
    [self hotSpotCategoriesDefault:lastElementParamsOnFirstSync];
    [self hotSpotActivitiesDefault:lastElementParamsOnFirstSync];
    [self priorities:lastElementParamsOnFirstSync];
    [self energies:lastElementParamsOnFirstSync];
    [self difficulties:lastElementParamsOnFirstSync];
    [self qualities:lastElementParamsOnFirstSync];
    [self periodTypes:lastElementParamsOnFirstSync];
}

- (void)syncWave2 {
    [self periodTypes:lastElementParamsOnFirstSync];
    [self hotSpotsDefault:lastElementParamsOnFirstSync];
    [self hotSpotCategories:lastElementParamsOnFirstSync];
    [self hotSpotActivities:lastElementParamsOnFirstSync];
    [self users_SocialNetworks:lastElementParamsOnFirstSync];
    [self tags:lastElementParamsOnFirstSync];
    [self locations:lastElementParamsOnFirstSync];
    [self references:lastElementParamsOnFirstSync];
}

- (void)syncWave3 {
    [self hotSpots:lastElementParamsOnFirstSync];
}

- (void)syncWave4 {
    [self results:lastElementParamsOnFirstSync];
}

- (void)syncWave5 {
    [self tags_Results:lastElementParamsOnFirstSync];
    [self results_References:lastElementParamsOnFirstSync];
    [self results_Relationships:lastElementParamsOnFirstSync];
}

// Sync is over
- (void)syncWave6 {
    Variables *lastSyncServer = [Variables getVariableWithKey:@"lastSyncServer"];
    lastSyncServer.variable_value = lastElementUpdatedDate;
    NSDate *lastSyncLocalDate = [NSDate date];
    Variables *lastSyncLocal = [Variables getVariableWithKey:@"lastSyncLocal"];
    if (!lastSyncLocal)
        [Variables insertVariable:@"lastSyncLocal" Value:lastSyncLocalDate];
    else
        lastSyncLocal.variable_value = lastSyncLocalDate;
    [dataController.app saveContext];
    [self finishSyncWithSuccess:YES];
}

- (void)finishSyncWithSuccess:(BOOL)success {
    if (self.viewControllerDelegate && [self.viewControllerDelegate isKindOfClass:[MenuTableViewController class]]) {
        MenuTableViewController *controller = (MenuTableViewController *)self.viewControllerDelegate;
        if (!success) controller.syncLabel.textColor = [UIColor redColor];
        [controller.syncImageView.layer removeAllAnimations];
        controller.syncStarted = 0;
        [controller setMenuTableViewControllerStyle];
    }
    //    [Constants showAlertMessage:@"Sync Completed"];
}

#pragma mark Difficulties
- (void)difficulties:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Difficulties", @"entityName",
                                          @"difficulty_level", @"entityId",
                                          @"", @"entityId2",
                                          @"difficulty_updated", @"entityUpdated",
                                          @"difficulty_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(difficultiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)difficultiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Difficulties class]]) return;
        Difficulties *localDifficulty = localItem;
        localDifficulty.difficulty_level = [[serverItem valueForKey:@"difficulty_level"] intValue];
        localDifficulty.difficulty_name = [serverItem valueForKey:@"difficulty_name"];
        NSDate *difficulty_updated = [API dateFromMySqlString:[serverItem valueForKey:@"difficulty_updated"]];
        localDifficulty.difficulty_updated = [difficulty_updated timeIntervalSinceReferenceDate];
        localDifficulty.difficulty_deleted = [[serverItem valueForKey:@"difficulty_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(difficulties:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Energies
- (void)energies:(NSDictionary *)lastElementParams {
    
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Energies", @"entityName",
                                          @"energy_level", @"entityId",
                                          @"", @"entityId2",
                                          @"energy_updated", @"entityUpdated",
                                          @"energy_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(energiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)energiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Energies class]]) return;
        Energies *localEnergy = localItem;
        localEnergy.energy_level = [[serverItem valueForKey:@"energy_level"] intValue];
        localEnergy.energy_name  = [serverItem valueForKey:@"energy_name"];
        NSDate *energy_updated = [API dateFromMySqlString:[serverItem valueForKey:@"energy_updated"]];
        localEnergy.energy_updated = [energy_updated timeIntervalSinceReferenceDate];
        localEnergy.energy_deleted = [[serverItem valueForKey:@"energy_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(energies:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotActivities
- (void)hotSpotActivities:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"HotSpotActivities", @"entityName",
                                          @"hotSpotActivity_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotActivity_updated", @"entityUpdated",
                                          @"hotSpotActivity_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotActivitiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)hotSpotActivitiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotActivities class]]) return;
        HotSpotActivities *localHotSpotActivity = localItem;
        localHotSpotActivity.hotSpotActivity_id = [[serverItem valueForKey:@"hotSpotActivity_id"] intValue];
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        [localHotSpotActivity setUser:user];
        HotSpotActivitiesDefault *hotSpotActivityDefault = (HotSpotActivitiesDefault *)[Variables getVariable:@"HotSpotActivitiesDefault" EntityIdKey:@"hotSpotActivityDefault_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotActivityDefault_id"]];
        [localHotSpotActivity setHotSpotActivityDefault:hotSpotActivityDefault];
        localHotSpotActivity.hotSpotActivity_name = [serverItem valueForKey:@"hotSpotActivity_name"];
        id hotSpotActivityDescription = [serverItem valueForKey:@"hotSpotActivity_description"];
        if (![hotSpotActivityDescription isKindOfClass:[NSNull class]])
            localHotSpotActivity.hotSpotActivity_description = hotSpotActivityDescription;
        else
            localHotSpotActivity.hotSpotActivity_description = nil;
        NSDate *hotSpotActivity_updated = [API dateFromMySqlString:[serverItem valueForKey:@"hotSpotActivity_updated"]];
        localHotSpotActivity.hotSpotActivity_updated = [hotSpotActivity_updated timeIntervalSinceReferenceDate];
        localHotSpotActivity.hotSpotActivity_deleted = [[serverItem valueForKey:@"hotSpotActivity_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotActivities:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotActivitiesDefault
- (void)hotSpotActivitiesDefault:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"HotSpotActivitiesDefault", @"entityName",
                                          @"hotSpotActivityDefault_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotActivityDefault_updated", @"entityUpdated",
                                          @"hotSpotActivityDefault_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotActivitiesDefaultHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)hotSpotActivitiesDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotActivitiesDefault class]]) return;
        HotSpotActivitiesDefault *localHotSpotActivityDefault = localItem;
        localHotSpotActivityDefault.hotSpotActivityDefault_id = [[serverItem valueForKey:@"hotSpotActivityDefault_id"] intValue];
        localHotSpotActivityDefault.hotSpotActivityDefault_name = [serverItem valueForKey:@"hotSpotActivityDefault_name"];
        id hotSpotActivityDefaultDescription = [serverItem valueForKey:@"hotSpotActivityDefault_description"];
        if (![hotSpotActivityDefaultDescription isKindOfClass:[NSNull class]])
            localHotSpotActivityDefault.hotSpotActivityDefault_description = hotSpotActivityDefaultDescription;
        else
            localHotSpotActivityDefault.hotSpotActivityDefault_description = nil;
        NSDate *hotSpotActivityDefaultUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"hotSpotActivityDefault_updated"]];
        localHotSpotActivityDefault.hotSpotActivityDefault_updated = [hotSpotActivityDefaultUpdated timeIntervalSinceReferenceDate];
        localHotSpotActivityDefault.hotSpotActivityDefault_deleted = [[serverItem valueForKey:@"hotSpotActivityDefault_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotActivitiesDefault:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotCategories
- (void)hotSpotCategories:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"HotSpotCategories", @"entityName",
                                          @"hotSpotCategory_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotCategory_updated", @"entityUpdated",
                                          @"hotSpotCategory_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotCategoriesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)hotSpotCategoriesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotCategories class]]) return;
        HotSpotCategories *localHotSpotCategory = localItem;
        localHotSpotCategory.hotSpotCategory_id = [[serverItem valueForKey:@"hotSpotCategory_id"] intValue];
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        [localHotSpotCategory setUser:user];
        HotSpotCategoriesDefault *hotSpotCategoryDefault = (HotSpotCategoriesDefault *)[Variables getVariable:@"HotSpotCategoriesDefault"
            EntityIdKey:@"hotSpotCategoryDefault_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotCategoryDefault_id"]];
        [localHotSpotCategory setHotSpotCategoryDefault:hotSpotCategoryDefault];
        localHotSpotCategory.hotSpotCategory_name = [serverItem valueForKey:@"hotSpotCategory_name"];
        id hotSpotCategoryDescription = [serverItem valueForKey:@"hotSpotCategory_description"];
        if (![hotSpotCategoryDescription isKindOfClass:[NSNull class]])
            localHotSpotCategory.hotSpotCategory_description = hotSpotCategoryDescription;
        else
            localHotSpotCategory.hotSpotCategory_description = nil;
        NSDate *hotSpotCategoryUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"hotSpotCategory_updated"]];
        localHotSpotCategory.hotSpotCategory_updated = [hotSpotCategoryUpdated timeIntervalSinceReferenceDate];
        localHotSpotCategory.hotSpotCategory_deleted = [[serverItem valueForKey:@"hotSpotCategory_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotCategories:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotCategoriesDefault
- (void)hotSpotCategoriesDefault:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"HotSpotCategoriesDefault", @"entityName",
                                          @"hotSpotCategoryDefault_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotCategoryDefault_updated", @"entityUpdated",
                                          @"hotSpotCategoryDefault_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotCategoriesDefaultHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)hotSpotCategoriesDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotCategoriesDefault class]]) return;
        HotSpotCategoriesDefault *localHotSpotCategoryDefault = localItem;
        localHotSpotCategoryDefault.hotSpotCategoryDefault_id = [[serverItem valueForKey:@"hotSpotCategoryDefault_id"] intValue];
        localHotSpotCategoryDefault.hotSpotCategoryDefault_name = [serverItem valueForKey:@"hotSpotCategoryDefault_name"];
        id hotSpotCategoryDefaultDescription = [serverItem valueForKey:@"hotSpotCategoryDefault_description"];
        if (![hotSpotCategoryDefaultDescription isKindOfClass:[NSNull class]])
            localHotSpotCategoryDefault.hotSpotCategoryDefault_description = hotSpotCategoryDefaultDescription;
        else
            localHotSpotCategoryDefault.hotSpotCategoryDefault_description = nil;
        NSDate *hotSpotCategoryDefaultUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"hotSpotCategoryDefault_updated"]];
        localHotSpotCategoryDefault.hotSpotCategoryDefault_updated = [hotSpotCategoryDefaultUpdated timeIntervalSinceReferenceDate];
        localHotSpotCategoryDefault.hotSpotCategoryDefault_deleted = [[serverItem valueForKey:@"hotSpotCategoryDefault_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotCategoriesDefault:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpots
- (void)hotSpots:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"HotSpots", @"entityName",
                                          @"hotSpot_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpot_updated", @"entityUpdated",
                                          @"hotSpot_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotsHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)hotSpotsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpots class]]) return;
        HotSpots *localHotSpot = localItem;
        localHotSpot.hotSpot_id = [[serverItem valueForKey:@"hotSpot_id"] intValue];
        HotSpotCategories *hotSpotCategory = (HotSpotCategories *)[Variables getVariable:@"HotSpotCategories"
            EntityIdKey:@"hotSpotCategory_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotCategory_id"]];
        [localHotSpot setHotSpotCategory:hotSpotCategory];
        HotSpotActivities *hotSpotActivity = (HotSpotActivities *)[Variables getVariable:@"HotSpotActivities"
            EntityIdKey:@"hotSpotActivity_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotActivity_id"]];
        [localHotSpot setHotSpotActivity:hotSpotActivity];
        localHotSpot.hotSpot_percent = [[serverItem valueForKey:@"hotSpot_percent"] doubleValue];
        id hotSpotBoundaryMinimum = [serverItem valueForKey:@"hotSpot_boundaryMinimum"];
        if (![hotSpotBoundaryMinimum isKindOfClass:[NSNull class]])
            localHotSpot.hotSpot_boundaryMinimum = [hotSpotBoundaryMinimum intValue];
        else
            [localHotSpot setValue:nil forKey:@"hotSpot_boundaryMinimum"];
        id hotSpotBoundaryMaximum = [serverItem valueForKey:@"hotSpot_boundaryMaximum"];
        if (![hotSpotBoundaryMaximum isKindOfClass:[NSNull class]])
            localHotSpot.hotSpot_boundaryMaximum = [hotSpotBoundaryMaximum intValue];
        else
            [localHotSpot setValue:nil forKey:@"hotSpot_boundaryMaximum"];
        NSDate *hotSpotUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"hotSpot_updated"]];
        localHotSpot.hotSpot_updated = [hotSpotUpdated timeIntervalSinceReferenceDate];
        localHotSpot.hotSpot_deleted = [[serverItem valueForKey:@"hotSpot_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpots:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotsDefault
- (void)hotSpotsDefault:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"HotSpotsDefault", @"entityName",
                                          @"hotSpotDefault_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotDefault_updated", @"entityUpdated",
                                          @"hotSpotDefault_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotsDefaultHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)hotSpotsDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotsDefault class]]) return;
        HotSpotsDefault *localHotSpotDefault = localItem;
        localHotSpotDefault.hotSpotDefault_id = [[serverItem valueForKey:@"hotSpotDefault_id"] intValue];
        HotSpotCategoriesDefault *hotSpotCategoryDefault = (HotSpotCategoriesDefault *)
            [Variables getVariable:@"HotSpotCategoriesDefault"
                       EntityIdKey:@"hotSpotCategoryDefault_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotCategoryDefault_id"]];
        [localHotSpotDefault setHotSpotCategoryDefault:hotSpotCategoryDefault];
        HotSpotActivitiesDefault *hotSpotActivityDefault = (HotSpotActivitiesDefault *)
        [Variables getVariable:@"HotSpotActivitiesDefault"
                   EntityIdKey:@"hotSpotActivityDefault_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotActivityDefault_id"]];
        [localHotSpotDefault setHotSpotActivityDefault:hotSpotActivityDefault];
        NSDate *hotSpotDefaultUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"hotSpotDefault_updated"]];
        localHotSpotDefault.hotSpotDefault_updated = [hotSpotDefaultUpdated timeIntervalSinceReferenceDate];
        localHotSpotDefault.hotSpotDefault_deleted = [[serverItem valueForKey:@"hotSpotDefault_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotsDefault:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Locations
- (void)locations:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Locations", @"entityName",
                                          @"location_id", @"entityId",
                                          @"", @"entityId2",
                                          @"location_updated", @"entityUpdated",
                                          @"location_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(locationsHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)locationsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Locations class]]) return;
        Locations *localLocation = localItem;
        localLocation.location_id = [[serverItem valueForKey:@"location_id"] intValue];
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        [localLocation setUser:user];
        localLocation.location_name = [serverItem valueForKey:@"location_name"];
        id locationAddress = [serverItem valueForKey:@"location_address"];
        if (![locationAddress isKindOfClass:[NSNull class]])
            localLocation.location_address = locationAddress;
        else
            localLocation.location_address = nil;
        id locationLatitude = [serverItem valueForKey:@"location_latitude"];
        if (![locationLatitude isKindOfClass:[NSNull class]])
            localLocation.location_latitude = [locationLatitude doubleValue];
        else
            [localLocation setValue:nil forKey:@"location_latitude"];
        id locationLongitude = [serverItem valueForKey:@"location_longitude"];
        if (![locationLongitude isKindOfClass:[NSNull class]])
            localLocation.location_longitude = [locationLongitude doubleValue];
        else
            [localLocation setValue:nil forKey:@"location_longitude"];
        NSDate *locationUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"location_updated"]];
        localLocation.location_updated = [locationUpdated timeIntervalSinceReferenceDate];
        localLocation.location_deleted = [[serverItem valueForKey:@"location_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(locations:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];

}

#pragma mark PeriodTypes
- (void)periodTypes:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"PeriodTypes", @"entityName",
                                          @"periodType_id", @"entityId",
                                          @"", @"entityId2",
                                          @"periodType_updated", @"entityUpdated",
                                          @"periodType_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(periodTypesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)periodTypesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[PeriodTypes class]]) return;
        PeriodTypes *localPeriodType = localItem;
        localPeriodType.periodType_id = [[serverItem valueForKey:@"periodType_id"] intValue];
        localPeriodType.periodType_name = [serverItem valueForKey:@"periodType_name"];
        localPeriodType.periodType_years = [[serverItem valueForKey:@"periodType_years"] intValue];
        localPeriodType.periodType_months = [[serverItem valueForKey:@"periodType_months"] intValue];
        localPeriodType.periodType_days = [[serverItem valueForKey:@"periodType_days"] intValue];
        id parentPeriodTypeId = [serverItem valueForKey:@"periodType_parentPeriodType_id"];
        if (![parentPeriodTypeId isKindOfClass:[NSNull class]]) {
            PeriodTypes *parentPeriodType = (PeriodTypes *)
                [Variables getVariable:@"PeriodTypes" EntityIdKey:@"periodType_id" EntityIdValue:parentPeriodTypeId];
            [localPeriodType setParentPeriodType:parentPeriodType];
        }
        else
            [localPeriodType setParentPeriodType:nil];
        id childPeriodTypeId = [serverItem valueForKey:@"periodType_childPeriodType_id"];
        if (![childPeriodTypeId isKindOfClass:[NSNull class]]) {
            PeriodTypes *childPeriodType = (PeriodTypes *)
                [Variables getVariable:@"PeriodTypes" EntityIdKey:@"periodType_id" EntityIdValue:childPeriodTypeId];
            [localPeriodType setChildPeriodType:childPeriodType];
        }
        else
            [localPeriodType setChildPeriodType:nil];
        NSDate *periodType_updated = [API dateFromMySqlString:[serverItem valueForKey:@"periodType_updated"]];
        localPeriodType.periodType_updated = [periodType_updated timeIntervalSinceReferenceDate];
        localPeriodType.periodType_deleted = [[serverItem valueForKey:@"periodType_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(periodTypes:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Priorities
- (void)priorities:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Priorities", @"entityName",
                                          @"priority_level", @"entityId",
                                          @"", @"entityId2",
                                          @"priority_updated", @"entityUpdated",
                                          @"priority_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(prioritiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)prioritiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Priorities class]]) return;
        Priorities *localPriority = localItem;
        localPriority.priority_level = [[serverItem valueForKey:@"priority_level"] intValue];
        localPriority.priority_name = [serverItem valueForKey:@"priority_name"];
        NSDate *priority_updated = [API dateFromMySqlString:[serverItem valueForKey:@"priority_updated"]];
        localPriority.priority_updated = [priority_updated timeIntervalSinceReferenceDate];
        localPriority.priority_deleted = [[serverItem valueForKey:@"priority_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(priorities:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Qualities
- (void)qualities:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Qualities", @"entityName",
                                          @"quality_level", @"entityId",
                                          @"", @"entityId2",
                                          @"quality_updated", @"entityUpdated",
                                          @"quality_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(qualitiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)qualitiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Qualities class]]) return;
        Qualities *localQuality = localItem;
        localQuality.quality_level = [[serverItem valueForKey:@"quality_level"] intValue];
        localQuality.quality_name = [serverItem valueForKey:@"quality_name"];
        NSDate *quality_updated = [API dateFromMySqlString:[serverItem valueForKey:@"quality_updated"]];
        localQuality.quality_updated = [quality_updated timeIntervalSinceReferenceDate];
        localQuality.quality_deleted = [[serverItem valueForKey:@"quality_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(qualities:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Rates
- (void)rates:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Rates", @"entityName",
                                          @"rate_level", @"entityId",
                                          @"", @"entityId2",
                                          @"rate_updated", @"entityUpdated",
                                          @"rate_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(ratesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)ratesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Rates class]]) return;
        Rates *localRate = localItem;
        localRate.rate_level = [[serverItem valueForKey:@"rate_level"] intValue];
        localRate.rate_name = [serverItem valueForKey:@"rate_name"];
        localRate.rate_minScore = [[serverItem valueForKey:@"rate_minScore"] intValue];
        NSDate *rate_updated = [API dateFromMySqlString:[serverItem valueForKey:@"rate_updated"]];
        localRate.rate_updated = [rate_updated timeIntervalSinceReferenceDate];
        localRate.rate_deleted = [[serverItem valueForKey:@"rate_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(rates:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark References
- (void)references:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"References", @"entityName",
                                          @"reference_id", @"entityId",
                                          @"", @"entityId2",
                                          @"reference_updated", @"entityUpdated",
                                          @"reference_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(referencesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)referencesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[References class]]) return;
        References *localReference = localItem;
        localReference.reference_id = [[serverItem valueForKey:@"reference_id"] intValue];
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        [localReference setUser:user];
        localReference.reference_name = [serverItem valueForKey:@"reference_name"];
        id referenceText = [serverItem valueForKey:@"reference_text"];
        if (![referenceText isKindOfClass:[NSNull class]])
            localReference.reference_text = referenceText;
        else
            localReference.reference_text = nil;
        NSDate *referenceUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"reference_updated"]];
        localReference.reference_updated = [referenceUpdated timeIntervalSinceReferenceDate];
        localReference.reference_deleted = [[serverItem valueForKey:@"reference_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(references:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Results
- (void)results:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Results", @"entityName",
                                          @"result_id", @"entityId",
                                          @"", @"entityId2",
                                          @"result_updated", @"entityUpdated",
                                          @"result_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(resultsHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)resultsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Results class]]) return;
        Results *localResult = localItem;
        localResult.result_id = [[serverItem valueForKey:@"result_id"] intValue];
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        [localResult setUser:user];
        id hotSpotId = [serverItem valueForKey:@"fk_hotSpot_id"];
        if (![hotSpotId isKindOfClass:[NSNull class]]) {
            HotSpots *hotSpot = (HotSpots *)[Variables getVariable:@"HotSpots" EntityIdKey:@"hotSpot_id" EntityIdValue:hotSpotId];
            [localResult setHotSpot:hotSpot];
        } else
            [localResult setHotSpot:nil];
        Priorities *priority = (Priorities *)[Variables getVariable:@"Priorities"
            EntityIdKey:@"priority_level" EntityIdValue:[serverItem valueForKey:@"fk_priority_level"]];
        [localResult setPriority:priority];
        localResult.result_name = [serverItem valueForKey:@"result_name"];
        id resultDescription = [serverItem valueForKey:@"result_description"];
        if (![resultDescription isKindOfClass:[NSNull class]])
            localResult.result_description = resultDescription;
        else
            localResult.result_description = nil;
        localResult.result_main = [[serverItem valueForKey:@"result_main"] boolValue];
        Energies *energy = (Energies *)[Variables getVariable:@"Energies"
            EntityIdKey:@"energy_level" EntityIdValue:[serverItem valueForKey:@"fk_energy_level"]];
        [localResult setEnergy:energy];
        NSDate *resultStartDate = [API dateFromMySqlString:[serverItem valueForKey:@"result_startDate"]];
        localResult.result_startDate = [resultStartDate timeIntervalSinceReferenceDate];
        Difficulties *difficulty = (Difficulties *)[Variables getVariable:@"Difficulties"
            EntityIdKey:@"difficulty_level" EntityIdValue:[serverItem valueForKey:@"fk_difficulty_level"]];
        [localResult setDifficulty:difficulty];
        id resultFinishDate = [serverItem valueForKey:@"result_finishDate"];
        if (![resultFinishDate isKindOfClass:[NSNull class]]) {
            NSDate *resultFinishDateDate = [API dateFromMySqlString:resultFinishDate];
            localResult.result_finishDate = [resultFinishDateDate timeIntervalSinceReferenceDate];
        }
        else {
            [localResult setValue:nil forKey:@"result_finishDate"];
        }
        id qualityLevel = [serverItem valueForKey:@"fk_quality_level"];
        if (![qualityLevel isKindOfClass:[NSNull class]]) {
            Qualities *quality = (Qualities *)[Variables getVariable:@"Qualities" EntityIdKey:@"quality_level" EntityIdValue:qualityLevel];
            [localResult setQuality:quality];
        }
        else
            [localResult setQuality:nil];
        id locationId = [serverItem valueForKey:@"fk_location_id"];
        if (![locationId isKindOfClass:[NSNull class]]) {
            Locations *location = (Locations *)[Variables getVariable:@"Locations" EntityIdKey:@"location_id" EntityIdValue:locationId];
            [localResult setLocation:location];
        }
        else
            [localResult setLocation:nil];
        PeriodTypes *periodType = (PeriodTypes *)[Variables getVariable:@"PeriodTypes"
             EntityIdKey:@"periodType_id" EntityIdValue:[serverItem valueForKey:@"fk_periodType_id"]];
        [localResult setPeriodType:periodType];
        NSDate *resultUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"result_updated"]];
        localResult.result_updated = [resultUpdated timeIntervalSinceReferenceDate];
        localResult.result_deleted = [[serverItem valueForKey:@"result_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(results:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Results_Relationships
- (void)results_Relationships:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Results_Relationships", @"entityName",
                                          @"fk_parentResult_id", @"entityId",
                                          @"fk_childResult_id", @"entityId2",
                                          @"result_relationship_updated", @"entityUpdated",
                                          @"result_relationship_deleted", @"entityDeleted",
                                          @"parentResult.result_id", @"localEntityId",
                                          @"childResult.result_id", @"localEntityId2", nil];
    SEL responseHandler = @selector(results_RelationshipsHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)results_RelationshipsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Results_Relationships class]]) return;
        Results_Relationships *localResult_Relationship = localItem;
        Results *parentResult = (Results *)[Variables getVariable:@"Results"
            EntityIdKey:@"result_id" EntityIdValue:[serverItem valueForKey:@"fk_parentResult_id"]];
        [localResult_Relationship setParentResult:parentResult];
        Results *childResult = (Results *)[Variables getVariable:@"Results"
            EntityIdKey:@"result_id" EntityIdValue:[serverItem valueForKey:@"fk_childResult_id"]];
        [localResult_Relationship setChildResult:childResult];
        NSDate *result_RelationshipUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"result_relationship_updated"]];
        localResult_Relationship.result_relationship_updated = [result_RelationshipUpdated timeIntervalSinceReferenceDate];
        localResult_Relationship.result_relationship_deleted = [[serverItem valueForKey:@"result_relationship_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(results_Relationships:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Results_References
- (void)results_References:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Results_References", @"entityName",
                                          @"fk_result_id", @"entityId",
                                          @"fk_reference_id", @"entityId2",
                                          @"result_reference_updated", @"entityUpdated",
                                          @"result_reference_deleted", @"entityDeleted",
                                          @"result.result_id", @"localEntityId",
                                          @"reference.reference_id", @"localEntityId2", nil];
    SEL responseHandler = @selector(results_ReferencesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)results_ReferencesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Results_References class]]) return;
        Results_References *localResult_Reference = localItem;
        Results *result = (Results *)[Variables getVariable:@"Results" EntityIdKey:@"result_id" EntityIdValue:[serverItem valueForKey:@"fk_result_id"]];
        [localResult_Reference setResult:result];
        References *reference = (References *)[Variables getVariable:@"References"
            EntityIdKey:@"reference_id" EntityIdValue:[serverItem valueForKey:@"fk_reference_id"]];
        [localResult_Reference setReference:reference];
        NSDate *result_referenceUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"result_reference_updated"]];
        localResult_Reference.result_reference_updated = [result_referenceUpdated timeIntervalSinceReferenceDate];
        localResult_Reference.result_reference_deleted = [[serverItem valueForKey:@"result_reference_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(results_References:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark SocialNetworks
- (void)socialNetworks:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"SocialNetworks", @"entityName",
                                          @"socialNetwork_id", @"entityId",
                                          @"", @"entityId2",
                                          @"socialNetwork_updated", @"entityUpdated",
                                          @"socialNetwork_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(socialNetworksHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)socialNetworksHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[SocialNetworks class]]) return;
        SocialNetworks *localSocialNetwork = localItem;
        localSocialNetwork.socialNetwork_id = [[serverItem valueForKey:@"socialNetwork_id"] intValue];
        localSocialNetwork.socialNetwork_name = [serverItem valueForKey:@"socialNetwork_name"];
        localSocialNetwork.socialNetwork_link = [serverItem valueForKey:@"socialNetwork_link"];
        NSDate *socialNetwork_updated = [API dateFromMySqlString:[serverItem valueForKey:@"socialNetwork_updated"]];
        localSocialNetwork.socialNetwork_updated = [socialNetwork_updated timeIntervalSinceReferenceDate];
        localSocialNetwork.socialNetwork_deleted = [[serverItem valueForKey:@"socialNetwork_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(socialNetworks:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Tags
- (void)tags:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Tags", @"entityName",
                                          @"tag_id", @"entityId",
                                          @"", @"entityId2",
                                          @"tag_updated", @"entityUpdated",
                                          @"tag_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(tagsHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)tagsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Tags class]]) return;
        Tags *localTag = localItem;
        localTag.tag_id = [[serverItem valueForKey:@"tag_id"] intValue];
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        [localTag setUser:user];
        localTag.tag_name = [serverItem valueForKey:@"tag_name"];
        NSDate *tagUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"tag_updated"]];
        localTag.tag_updated = [tagUpdated timeIntervalSinceReferenceDate];
        localTag.tag_deleted = [[serverItem valueForKey:@"tag_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(tags:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark TagsDefault
- (void)tagsDefault:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"TagsDefault", @"entityName",
                                          @"tagDefault_id", @"entityId",
                                          @"", @"entityId2",
                                          @"tagDefault_updated", @"entityUpdated",
                                          @"tagDefault_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(tagsDefaultHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)tagsDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[TagsDefault class]]) return;
        TagsDefault *localTagDefault = localItem;
        localTagDefault.tagDefault_id = [[serverItem valueForKey:@"tagDefault_id"] intValue];
        localTagDefault.tagDefault_name = [serverItem valueForKey:@"tagDefault_name"];
        NSDate *tagDefaultUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"tagDefault_updated"]];
        localTagDefault.tagDefault_updated = [tagDefaultUpdated timeIntervalSinceReferenceDate];
        localTagDefault.tagDefault_deleted = [[serverItem valueForKey:@"tagDefault_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(tagsDefault:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Tags_Results
- (void)tags_Results:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Tags_Results", @"entityName",
                                          @"fk_result_id", @"entityId",
                                          @"fk_tag_id", @"entityId2",
                                          @"tag_result_updated", @"entityUpdated",
                                          @"tag_result_deleted", @"entityDeleted",
                                          @"result.result_id", @"localEntityId",
                                          @"tag.tag_id", @"localEntityId2", nil];
    SEL responseHandler = @selector(tags_ResultsHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)tags_ResultsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Tags_Results class]]) return;
        Tags_Results *localTag_Result = localItem;
        Results *result = (Results *)[Variables getVariable:@"Results" EntityIdKey:@"result_id" EntityIdValue:[serverItem valueForKey:@"fk_result_id"]];
        [localTag_Result setResult:result];
        Tags *tag = (Tags *)[Variables getVariable:@"Tags" EntityIdKey:@"tag_id" EntityIdValue:[serverItem valueForKey:@"fk_tag_id"]];
        [localTag_Result setTag:tag];
        NSDate *tag_resultUpdated = [API dateFromMySqlString:[serverItem valueForKey:@"tag_result_updated"]];
        localTag_Result.tag_result_updated = [tag_resultUpdated timeIntervalSinceReferenceDate];
        localTag_Result.tag_result_deleted = [[serverItem valueForKey:@"tag_result_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(tags_Results:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Users
- (void)users:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Users", @"entityName",
                                          @"user_id", @"entityId",
                                          @"", @"entityId2",
                                          @"user_updated", @"entityUpdated",
                                          @"user_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(usersHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}

- (void)downloadUserAvatar:(Users *)user Avatar:(NSString *)userAvatarPath {
    
}
- (void)usersHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Users class]]) return;
        Users *localUser = localItem;
        localUser.user_id = [[serverItem valueForKey:@"user_id"] intValue];
        localUser.user_email = [serverItem valueForKey:@"user_email"];
        localUser.user_password = [serverItem valueForKey:@"user_password"];
        localUser.user_name = [serverItem valueForKey:@"user_name"];
        
        id userAvatarPath = [serverItem valueForKey:@"user_avatarPath"];
        if (![userAvatarPath isKindOfClass:[NSNull class]]) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@avatars/%@", apiURL, userAvatarPath]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            UIImage *placeholderImage = [UIImage imageNamed:@"no_avatar.png"];
            userAvatarImageView = [[UIImageView alloc] initWithImage:placeholderImage];
            [userAvatarImageView setImageWithURLRequest:request placeholderImage:placeholderImage
                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                    NSData *dataImage = UIImagePNGRepresentation(image);
                                    localUser.user_avatar = dataImage;
                                } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                    
                                }];
        }
        else
            localUser.user_avatar = nil;
        
        localUser.user_energy = [[serverItem valueForKey:@"user_energy"] doubleValue];
        localUser.user_score = [[serverItem valueForKey:@"user_score"] intValue];
        NSDate *user_registry = [API dateFromMySqlString:[serverItem valueForKey:@"user_registry"]];
        localUser.user_registry = [user_registry timeIntervalSinceReferenceDate];
        localUser.user_emailConfirmed = [[serverItem valueForKey:@"user_emailConfirmed"] boolValue];
        NSDate *user_updated = [API dateFromMySqlString:[serverItem valueForKey:@"user_updated"]];
        localUser.user_updated = [user_updated timeIntervalSinceReferenceDate];
        localUser.user_deleted = [[serverItem valueForKey:@"user_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(users:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Users_SocialNetworks
- (void)users_SocialNetworks:(NSDictionary *)lastElementParams {
    NSDictionary *entityAttributeNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"Users_SocialNetworks", @"entityName",
                                          @"fk_user_id", @"entityId",
                                          @"fk_socialNetwork_id", @"entityId2",
                                          @"user_socialNetwork_updated", @"entityUpdated",
                                          @"user_socialNetwork_deleted", @"entityDeleted",
                                          @"user.user_id", @"localEntityId",
                                          @"socialNetwork.socialNetwork_id", @"localEntityId2", nil];
    SEL responseHandler = @selector(users_SocialNetworksHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastElementParams:lastElementParams ResponseHandler:responseHandler];
}
- (void)users_SocialNetworksHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Users_SocialNetworks class]]) return;
        Users_SocialNetworks *localUser_SocialNetwork = localItem;
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        [localUser_SocialNetwork setUser:user];
        SocialNetworks *socialNetwork = (SocialNetworks *)
            [Variables getVariable:@"SocialNetworks" EntityIdKey:@"socialNetwork_id" EntityIdValue:[serverItem valueForKey:@"fk_socialNetwork_id"]];
        [localUser_SocialNetwork setSocialNetwork:socialNetwork];
        localUser_SocialNetwork.user_socialNetwork_main = [[serverItem valueForKey:@"user_socialNetwork_main"] boolValue];
        NSDate *user_socialNetwork_updated = [API dateFromMySqlString:[serverItem valueForKey:@"user_socialNetwork_updated"]];
        localUser_SocialNetwork.user_socialNetwork_updated = [user_socialNetwork_updated timeIntervalSinceReferenceDate];
        localUser_SocialNetwork.user_socialNetwork_deleted = [[serverItem valueForKey:@"user_socialNetwork_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(users_SocialNetworks:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark WeekLimits
- (void)weekLimits:(NSDictionary *)lastElementParams {
    
}
- (void)weekLimitsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark - Additional Functions

- (void)createFirstPartOfRequestAndCallRequestMethod:(NSDictionary *)entityAttributeNames
                                     LastElementParams:(NSDictionary *)lastElementParams ResponseHandler:(SEL)responseHandler {
    NSString *entityName     = entityAttributeNames[@"entityName"];
    NSString *entityId       = entityAttributeNames[@"entityId"];
    NSString *entityId2      = entityAttributeNames[@"entityId2"];
    if ([entityId2 isEqualToString:@""]) entityId2 = nil;
    NSString *entityUpdated  = entityAttributeNames[@"entityUpdated"];
    NSString *localEntityId  = entityAttributeNames[@"localEntityId"];
    if (!localEntityId) localEntityId = entityId;
    NSString *localEntityId2 = entityAttributeNames[@"localEntityId2"];
    if (!localEntityId2) localEntityId2 = entityId2;
    NSString *lastUpdatedString = [API mySqlStringFromDate:[lastElementParams valueForKey:@"last_updated"]];
    NSString *lastId = [[lastElementParams valueForKey:@"last_id"] stringValue];
    NSString *lastId2 = [[lastElementParams valueForKey:@"last_id2"] stringValue];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   entityName, @"table_name",
                                   lastUpdatedString, @"last_updated", nil];
    if (lastId) [params setObject:lastId forKey:@"last_id"];
    if (lastId2) [params setObject:lastId2 forKey:@"last_id2"];
    [self downloadDataFromServer:params ResponseHandler:responseHandler EntityAttributeNames:entityAttributeNames];
}

- (void)downloadDataFromServer:(NSMutableDictionary *)params ResponseHandler:(SEL)responseHandler
          EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
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
        [self finishSyncWithSuccess:NO];
    }];
}

- (void)handleServerData:(id)serverData SetItemMethod:(void (^)(id, NSArray *))setItem
        NextBlockOfItemsMethod:(SEL)nextBlockOfItems EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
    void (^completeTableSync)(void) = ^{
        // Table sync is completed, check if other tables in current wave are synced. If so, sync next wave
        int (^getSyncWaveIndex)(void) = ^{
            NSString *selectorString = NSStringFromSelector(nextBlockOfItems);
            for (int i = 0; i < syncWaves.count; i++) {
                id element = [[syncWaves objectAtIndex:i] valueForKey:selectorString];
                if (element) return i;
            }
            return -1;
        };
        int syncWaveIndex = getSyncWaveIndex();
        
        void (^markSyncWaveAsCompleted)(void) = ^{
            NSString *selectorString = NSStringFromSelector(nextBlockOfItems);
            NSMutableDictionary *syncWave = [syncWaves objectAtIndex:syncWaveIndex];
            [syncWave setObject:[NSNumber numberWithBool:TRUE] forKey:selectorString];
        };
        BOOL (^isSyncWaveCompleted)(void) = ^{
            NSMutableDictionary *syncWave = [syncWaves objectAtIndex:syncWaveIndex];
            for (NSString *selectorString in syncWave) {
                if (![[syncWave valueForKey:selectorString] boolValue]) return NO;
            }
            return YES;
        };
        if (!isSyncWaveCompleted()) {
            markSyncWaveAsCompleted();
            if (isSyncWaveCompleted()) {
                NSLog(@"Sync wave %i completed", syncWaveIndex);
                SEL nextWaveSelector = NSSelectorFromString([NSString stringWithFormat:@"syncWave%i", syncWaveIndex + 1]);
                if ([self respondsToSelector:nextWaveSelector]) {
                    [self performSelector:nextWaveSelector];
                }
            }
        }
    };
    
    if (![serverData isKindOfClass:[NSArray class]]) return;
    if ([serverData count] == 0) {
        completeTableSync();
        return;
    }
    NSString *entityName    = entityAttributeNames[@"entityName"];
    NSString *entityId      = entityAttributeNames[@"entityId"];
    NSString *entityId2     = entityAttributeNames[@"entityId2"];
    if ([entityId2 isEqualToString:@""]) entityId2 = nil;
    NSString *entityUpdated = entityAttributeNames[@"entityUpdated"];
    NSString *entityDeleted = entityAttributeNames[@"entityDeleted"];
    
    for (NSArray *serverItem in serverData) {
        NSNumber *itemId = [NSNumber numberWithInteger:[[serverItem valueForKey:entityId] integerValue]];
        NSNumber *itemId2 = entityId2 ? [NSNumber numberWithInteger:[[serverItem valueForKey:entityId2] integerValue]] : nil;
        id (^getLocalItem)(void) = ^{
            id result = nil;
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                                      inManagedObjectContext:dataController.managedObjectContext];
            [request setEntity:entity];
            
            NSString *localEntityId  = entityAttributeNames[@"localEntityId"];
            if (!localEntityId) localEntityId = entityId;
            NSString *localEntityId2 = entityAttributeNames[@"localEntityId2"];
            if (!localEntityId2) localEntityId2 = entityId2;
            NSPredicate *predicate;
            if (!localEntityId2)
                predicate = [NSPredicate predicateWithFormat:@"%K = %@", localEntityId, itemId];
            else
                predicate = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@", localEntityId, itemId, localEntityId2, itemId2];
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
            if (!entityId2) NSLog(@"Added %@ to %@", itemId, entityName);
            else            NSLog(@"Added %@;%@ to %@", itemId, itemId2, entityName);
        } else if (!deleted && exists) {
            // обновление
            setItem(localItem, serverItem);
            if (!entityId2) NSLog(@"Updated %@ in %@", itemId, entityName);
            else            NSLog(@"Updated %@;%@ in %@", itemId, itemId2, entityName);
        } else if (deleted && exists) {
            // удаление
            [dataController.managedObjectContext deleteObject:localItem];
            if (!entityId2) NSLog(@"Deleted %@ from %@", itemId, entityName);
            else            NSLog(@"Deleted %@;%@ from %@", itemId, itemId2, entityName);
        } else {
            if (!entityId2) NSLog(@"%@ didn't changed %@", itemId, entityName);
            else            NSLog(@"%@;%@ didn't changed %@", itemId, itemId2, entityName);
        }
    }
    
    NSDictionary *lastElement = [serverData lastObject];
    NSString *lastElementUpdatedDateString = [lastElement valueForKey:entityUpdated];
    NSDate *localLastElementUpdatedDate = [API dateFromMySqlString:lastElementUpdatedDateString];
    
    void (^updateLastElementUpdatedDate)(void) = ^{
        if ([[lastElementUpdatedDate laterDate:localLastElementUpdatedDate] isEqualToDate:localLastElementUpdatedDate]) {
            lastElementUpdatedDate = localLastElementUpdatedDate;
            NSLog(@"New lastUpdatedDate: %@", localLastElementUpdatedDate);
        }
    };
    updateLastElementUpdatedDate();
    
    void (^syncNextBlockOfItems)(void) = ^{
        NSMutableDictionary *lastElementParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  localLastElementUpdatedDate, @"last_updated",
                                                  [lastElement valueForKey:entityId], @"last_id", nil];
        if (entityId2) [lastElementParams setObject:[lastElement valueForKey:entityId2] forKey:@"last_id2"];
        if ([self respondsToSelector:nextBlockOfItems])
            [self performSelector:nextBlockOfItems withObject:[NSDictionary dictionaryWithDictionary:lastElementParams]];
    };
    
    if ([serverData count] == AMOUNT) {
        // Table sync isn't completed, request next block of items
        syncNextBlockOfItems();
    } else
        completeTableSync();
}

@end
