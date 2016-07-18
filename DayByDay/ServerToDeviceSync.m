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
#import "Tags_Results.h"
#import "Users.h"
#import "Users_SocialNetworks.h"
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
    [self users:lastSync];
    [self socialNetworks:lastSync];
    [self rates:lastSync];
    [self hotSpotCategoriesDefault:lastSync];
    [self hotSpotActivitiesDefault:lastSync];
    [self priorities:lastSync];
    [self energies:lastSync];
    [self difficulties:lastSync];
    [self qualities:lastSync];
    [self periodTypes:lastSync];
    
//    Создается до того, как были созданы пользователи и соц. сети, возникает ошибка
//    [self hotSpotsDefault:lastSync];
//    [self hotSpotCategories:lastSync];
//    [self hotSpotActivities:lastSync];
//    [self users_SocialNetworks:lastSync];
//    [self tags:lastSync];
//    [self locations:lastSync];
//    [self references:lastSync];
    
//    [self hotSpots:lastSync];
    
//    [self results:lastSync];
    
//    [self tags_Results:lastSync];
//    [self results_References:lastSync];
//    [self results_Relationships:lastSync];
}

#pragma mark Difficulties
- (void)difficulties:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"Difficulties", @"entityName",
                                          @"difficulty_level", @"entityId",
                                          @"", @"entityId2",
                                          @"difficulty_updated", @"entityUpdated",
                                          @"difficulty_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(difficultiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
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
    SEL responseHandler = @selector(energiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)energiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Energies class]]) return;
        Energies *localEnergy = localItem;
        localEnergy.energy_level = [[serverItem valueForKey:@"energy_level"] intValue];
        localEnergy.energy_name  = [serverItem valueForKey:@"energy_name"];
        NSDate *energy_updated = [API mySqlStringToDate:[serverItem valueForKey:@"energy_updated"]];
        localEnergy.energy_updated = [energy_updated timeIntervalSinceReferenceDate];
        localEnergy.energy_deleted = [[serverItem valueForKey:@"energy_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(energies:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotActivities
- (void)hotSpotActivities:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"HotSpotActivities", @"entityName",
                                          @"hotSpotActivity_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotActivity_updated", @"entityUpdated",
                                          @"hotSpotActivity_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotActivitiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)hotSpotActivitiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotActivities class]]) return;
        HotSpotActivities *localHotSpotActivity = localItem;
        localHotSpotActivity.hotSpotActivity_id = [[serverItem valueForKey:@"hotSpotActivity_id"] intValue];
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        localHotSpotActivity.user = user;
        HotSpotActivitiesDefault *hotSpotActivityDefault = (HotSpotActivitiesDefault *)[Variables getVariable:@"HotSpotActivitiesDefault" EntityIdKey:@"hotSpotActivityDefault_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotActivityDefault_id"]];
        localHotSpotActivity.hotSpotActivityDefault = hotSpotActivityDefault;
        localHotSpotActivity.hotSpotActivity_name = [serverItem valueForKey:@"hotSpotActivity_name"];
        localHotSpotActivity.hotSpotActivity_description = [serverItem valueForKey:@"hotSpotActivity_description"];
        NSDate *hotSpotActivity_updated = [API mySqlStringToDate:[serverItem valueForKey:@"hotSpotActivity_updated"]];
        localHotSpotActivity.hotSpotActivity_updated = [hotSpotActivity_updated timeIntervalSinceReferenceDate];
        localHotSpotActivity.hotSpotActivity_deleted = [[serverItem valueForKey:@"hotSpotActivity_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotActivities:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotActivitiesDefault
- (void)hotSpotActivitiesDefault:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"HotSpotActivitiesDefault", @"entityName",
                                          @"hotSpotActivityDefault_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotActivityDefault_updated", @"entityUpdated",
                                          @"hotSpotActivityDefault_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotActivitiesDefaultHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)hotSpotActivitiesDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotActivitiesDefault class]]) return;
        HotSpotActivitiesDefault *localHotSpotActivityDefault = localItem;
        localHotSpotActivityDefault.hotSpotActivityDefault_id = [[serverItem valueForKey:@"hotSpotActivityDefault_id"] intValue];
        localHotSpotActivityDefault.hotSpotActivityDefault_name = [serverItem valueForKey:@"hotSpotActivityDefault_name"];
        id hotSpotActivityDefaultDescription = [serverItem valueForKey:@"hotSpotActivityDefault_description"];
        localHotSpotActivityDefault.hotSpotActivityDefault_description = [hotSpotActivityDefaultDescription isKindOfClass:[NSString class]] ? hotSpotActivityDefaultDescription : nil;
        NSDate *hotSpotActivityDefaultUpdated = [API mySqlStringToDate:[serverItem valueForKey:@"hotSpotActivityDefault_updated"]];
        localHotSpotActivityDefault.hotSpotActivityDefault_updated = [hotSpotActivityDefaultUpdated timeIntervalSinceReferenceDate];
        localHotSpotActivityDefault.hotSpotActivityDefault_deleted = [[serverItem valueForKey:@"hotSpotActivityDefault_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotActivitiesDefault:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpotCategories
- (void)hotSpotCategories:(NSDate *)lastUpdatedDate {
    
}
- (void)hotSpotCategoriesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark HotSpotCategoriesDefault
- (void)hotSpotCategoriesDefault:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"HotSpotCategoriesDefault", @"entityName",
                                          @"hotSpotCategoryDefault_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotCategoryDefault_updated", @"entityUpdated",
                                          @"hotSpotCategoryDefault_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotCategoriesDefaultHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)hotSpotCategoriesDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotCategoriesDefault class]]) return;
        HotSpotCategoriesDefault *localHotSpotCategoryDefault = localItem;
        localHotSpotCategoryDefault.hotSpotCategoryDefault_id = [[serverItem valueForKey:@"hotSpotCategoryDefault_id"] intValue];
        localHotSpotCategoryDefault.hotSpotCategoryDefault_name = [serverItem valueForKey:@"hotSpotCategoryDefault_name"];
        id hotSpotCategoryDefaultDescription = [serverItem valueForKey:@"hotSpotCategoryDefault_description"];
        localHotSpotCategoryDefault.hotSpotCategoryDefault_description = [hotSpotCategoryDefaultDescription isKindOfClass:[NSString class]] ? hotSpotCategoryDefaultDescription : nil;
        NSDate *hotSpotCategoryDefaultUpdated = [API mySqlStringToDate:[serverItem valueForKey:@"hotSpotCategoryDefault_updated"]];
        localHotSpotCategoryDefault.hotSpotCategoryDefault_updated = [hotSpotCategoryDefaultUpdated timeIntervalSinceReferenceDate];
        localHotSpotCategoryDefault.hotSpotCategoryDefault_deleted = [[serverItem valueForKey:@"hotSpotCategoryDefault_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotCategoriesDefault:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark HotSpots
- (void)hotSpots:(NSDate *)lastUpdatedDate {
    
}
- (void)hotSpotsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark HotSpotsDefault
- (void)hotSpotsDefault:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"HotSpotsDefault", @"entityName",
                                          @"hotSpotDefault_id", @"entityId",
                                          @"", @"entityId2",
                                          @"hotSpotDefault_updated", @"entityUpdated",
                                          @"hotSpotDefault_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(hotSpotsDefaultHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)hotSpotsDefaultHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[HotSpotsDefault class]]) return;
        HotSpotsDefault *localHotSpotDefault = localItem;
        localHotSpotDefault.hotSpotDefault_id = [[serverItem valueForKey:@"hotSpotDefault_id"] intValue];
        HotSpotCategoriesDefault *hotSpotCategoryDefault = (HotSpotCategoriesDefault *)
            [Variables getVariable:@"HotSpotCategoriesDefault"
                       EntityIdKey:@"hotSpotCategoryDefault_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotCategoryDefault_id"]];
        localHotSpotDefault.hotSpotCategoryDefault = hotSpotCategoryDefault;
        HotSpotActivitiesDefault *hotSpotActivityDefault = (HotSpotActivitiesDefault *)
        [Variables getVariable:@"HotSpotActivitiesDefault"
                   EntityIdKey:@"hotSpotActivityDefault_id" EntityIdValue:[serverItem valueForKey:@"fk_hotSpotActivityDefault_id"]];
        localHotSpotDefault.hotSpotActivityDefault = hotSpotActivityDefault;
        NSDate *hotSpotDefaultUpdated = [API mySqlStringToDate:[serverItem valueForKey:@"hotSpotDefault_updated"]];
        localHotSpotDefault.hotSpotDefault_updated = [hotSpotDefaultUpdated timeIntervalSinceReferenceDate];
        localHotSpotDefault.hotSpotDefault_deleted = [[serverItem valueForKey:@"hotSpotDefault_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(hotSpotsDefault:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Locations
- (void)locations:(NSDate *)lastUpdatedDate {
    
}
- (void)locationsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {

}

#pragma mark PeriodTypes
- (void)periodTypes:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"PeriodTypes", @"entityName",
                                          @"periodType_id", @"entityId",
                                          @"", @"entityId2",
                                          @"periodType_updated", @"entityUpdated",
                                          @"periodType_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(periodTypesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)periodTypesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[PeriodTypes class]]) return;
        PeriodTypes *localPeriodType = localItem;
        localPeriodType.periodType_id = [[serverItem valueForKey:@"periodType_id"] intValue];
        NSDate *periodType_length = [API mySqlStringToDate:[serverItem valueForKey:@"periodType_length"]];
        localPeriodType.periodType_length = [periodType_length timeIntervalSinceReferenceDate];
        localPeriodType.periodType_name = [serverItem valueForKey:@"periodType_name"];
        NSDate *periodType_updated = [API mySqlStringToDate:[serverItem valueForKey:@"periodType_updated"]];
        localPeriodType.periodType_updated = [periodType_updated timeIntervalSinceReferenceDate];
        localPeriodType.periodType_deleted = [[serverItem valueForKey:@"periodType_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(periodTypes:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Priorities
- (void)priorities:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"Priorities", @"entityName",
                                          @"priority_level", @"entityId",
                                          @"", @"entityId2",
                                          @"priority_updated", @"entityUpdated",
                                          @"priority_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(prioritiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)prioritiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Priorities class]]) return;
        Priorities *localPriority = localItem;
        localPriority.priority_level = [[serverItem valueForKey:@"priority_level"] intValue];
        localPriority.priority_name = [serverItem valueForKey:@"priority_name"];
        NSDate *priority_updated = [API mySqlStringToDate:[serverItem valueForKey:@"priority_updated"]];
        localPriority.priority_updated = [priority_updated timeIntervalSinceReferenceDate];
        localPriority.priority_deleted = [[serverItem valueForKey:@"priority_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(priorities:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Qualities
- (void)qualities:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"Qualities", @"entityName",
                                          @"quality_level", @"entityId",
                                          @"", @"entityId2",
                                          @"quality_updated", @"entityUpdated",
                                          @"quality_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(qualitiesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)qualitiesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Qualities class]]) return;
        Qualities *localQuality = localItem;
        localQuality.quality_level = [[serverItem valueForKey:@"quality_level"] intValue];
        localQuality.quality_name = [serverItem valueForKey:@"quality_name"];
        NSDate *quality_updated = [API mySqlStringToDate:[serverItem valueForKey:@"quality_updated"]];
        localQuality.quality_updated = [quality_updated timeIntervalSinceReferenceDate];
        localQuality.quality_deleted = [[serverItem valueForKey:@"quality_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(qualities:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Rates
- (void)rates:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"Rates", @"entityName",
                                          @"rate_level", @"entityId",
                                          @"", @"entityId2",
                                          @"rate_updated", @"entityUpdated",
                                          @"rate_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(ratesHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)ratesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Rates class]]) return;
        Rates *localRate = localItem;
        localRate.rate_level = [[serverItem valueForKey:@"rate_level"] intValue];
        localRate.rate_name = [serverItem valueForKey:@"rate_name"];
        localRate.rate_minScore = [[serverItem valueForKey:@"rate_minScore"] intValue];
        NSDate *rate_updated = [API mySqlStringToDate:[serverItem valueForKey:@"rate_updated"]];
        localRate.rate_updated = [rate_updated timeIntervalSinceReferenceDate];
        localRate.rate_deleted = [[serverItem valueForKey:@"rate_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(rates:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
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

#pragma mark Results_Relationships
- (void)results_Relationships:(NSDate *)lastUpdatedDate {
    
}
- (void)results_RelationshipsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Results_References
- (void)results_References:(NSDate *)lastUpdatedDate {
    
}
- (void)results_ReferencesHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark SocialNetworks
- (void)socialNetworks:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"SocialNetworks", @"entityName",
                                          @"socialNetwork_id", @"entityId",
                                          @"", @"entityId2",
                                          @"socialNetwork_updated", @"entityUpdated",
                                          @"socialNetwork_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(socialNetworksHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)socialNetworksHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[SocialNetworks class]]) return;
        SocialNetworks *localSocialNetwork = localItem;
        localSocialNetwork.socialNetwork_id = [[serverItem valueForKey:@"socialNetwork_id"] intValue];
        localSocialNetwork.socialNetwork_name = [serverItem valueForKey:@"socialNetwork_name"];
        localSocialNetwork.socialNetwork_link = [serverItem valueForKey:@"socialNetwork_link"];
        NSDate *socialNetwork_updated = [API mySqlStringToDate:[serverItem valueForKey:@"socialNetwork_updated"]];
        localSocialNetwork.socialNetwork_updated = [socialNetwork_updated timeIntervalSinceReferenceDate];
        localSocialNetwork.socialNetwork_deleted = [[serverItem valueForKey:@"socialNetwork_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(socialNetworks:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Tags
- (void)tags:(NSDate *)lastUpdatedDate {
    
}
- (void)tagsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Tags_Results
- (void)tags_Results:(NSDate *)lastUpdatedDate {
    
}
- (void)tags_ResultsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark Users
- (void)users:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"Users", @"entityName",
                                          @"user_id", @"entityId",
                                          @"", @"entityId2",
                                          @"user_updated", @"entityUpdated",
                                          @"user_deleted", @"entityDeleted", nil];
    SEL responseHandler = @selector(usersHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)usersHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Users class]]) return;
        Users *localUser = localItem;
        localUser.user_id = [[serverItem valueForKey:@"user_id"] intValue];
        localUser.user_email = [serverItem valueForKey:@"user_email"];
        localUser.user_password = [serverItem valueForKey:@"user_password"];
        localUser.user_name = [serverItem valueForKey:@"user_name"];
//        Доработать
//        localUser.user_avatar = ;
        localUser.user_energy = [[serverItem valueForKey:@"user_energy"] doubleValue];
        localUser.user_score = [[serverItem valueForKey:@"user_score"] intValue];
        NSDate *user_registry = [API mySqlStringToDate:[serverItem valueForKey:@"user_registry"]];
        localUser.user_registry = [user_registry timeIntervalSinceReferenceDate];
        localUser.user_emailConfirmed = [[serverItem valueForKey:@"user_emailConfirmed"] boolValue];
        NSDate *user_updated = [API mySqlStringToDate:[serverItem valueForKey:@"user_updated"]];
        localUser.user_updated = [user_updated timeIntervalSinceReferenceDate];
        localUser.user_deleted = [[serverItem valueForKey:@"user_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(users:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark Users_SocialNetworks
- (void)users_SocialNetworks:(NSDate *)lastUpdatedDate {
    NSDictionary *entityAttributeNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"Users_SocialNetworks", @"entityName",
                                          @"fk_user_id", @"entityId",
                                          @"fk_socialNetwork_id", @"entityId2",
                                          @"user_socialNetwork_updated", @"entityUpdated",
                                          @"user_socialNetwork_deleted", @"entityDeleted",
                                          @"user.user_id", @"localEntityId",
                                          @"socialNetwork.socialNetwork_id", @"localEntityId2", nil];
    SEL responseHandler = @selector(users_SocialNetworksHandler:EntityAttributeNames:);
    [self createFirstPartOfRequestAndCallRequestMethod:entityAttributeNames LastUpdatedDate:lastUpdatedDate ResponseHandler:responseHandler];
}
- (void)users_SocialNetworksHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    void (^setItem )(id, NSArray *) = ^(id localItem, NSArray *serverItem) {
        if (![localItem isKindOfClass:[Users_SocialNetworks class]]) return;
        Users_SocialNetworks *localUser_SocialNetwork = localItem;
        Users *user = (Users *)[Variables getVariable:@"Users" EntityIdKey:@"user_id" EntityIdValue:[serverItem valueForKey:@"fk_user_id"]];
        localUser_SocialNetwork.user = user;
        SocialNetworks *socialNetwork = (SocialNetworks *)
            [Variables getVariable:@"SocialNetworks" EntityIdKey:@"socialNetwork_id" EntityIdValue:[serverItem valueForKey:@"fk_socialNetwork_id"]];
        localUser_SocialNetwork.socialNetwork = socialNetwork;
        localUser_SocialNetwork.user_socialNetwork_main = [[serverItem valueForKey:@"user_socialNetwork_main"] boolValue];
        NSDate *user_socialNetwork_updated = [API mySqlStringToDate:[serverItem valueForKey:@"user_socialNetwork_updated"]];
        localUser_SocialNetwork.user_socialNetwork_updated = [user_socialNetwork_updated timeIntervalSinceReferenceDate];
        localUser_SocialNetwork.user_socialNetwork_deleted = [[serverItem valueForKey:@"user_socialNetwork_deleted"] boolValue];
    };
    
    SEL nextBlockOfItems = @selector(users_SocialNetworks:);
    [self handleServerData:serverData SetItemMethod:setItem NextBlockOfItemsMethod:nextBlockOfItems EntityAttributeNames:entityAttributeNames];
}

#pragma mark WeekLimits
- (void)weekLimits:(NSDate *)lastUpdatedDate {
    
}
- (void)weekLimitsHandler:(id)serverData EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
}

#pragma mark - Additional Functions

- (void)createFirstPartOfRequestAndCallRequestMethod:(NSDictionary *)entityAttributeNames
                                     LastUpdatedDate:(NSDate *)lastUpdatedDate ResponseHandler:(SEL)responseHandler {
    NSString *entityName     = entityAttributeNames[@"entityName"];
    NSString *entityId       = entityAttributeNames[@"entityId"];
    NSString *entityId2      = entityAttributeNames[@"entityId2"];
    if ([entityId2 isEqualToString:@""]) entityId2 = nil;
    NSString *entityUpdated  = entityAttributeNames[@"entityUpdated"];
    NSString *localEntityId  = entityAttributeNames[@"localEntityId"];
    if (!localEntityId) localEntityId = entityId;
    NSString *localEntityId2 = entityAttributeNames[@"localEntityId2"];
    if (!localEntityId2) localEntityId2 = entityId2;
    
    id (^getLastElement)(void) = ^{
        id result = nil;
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:dataController.managedObjectContext];
        NSArray *sortDecriptors = !entityId2 ? [self getSortDescriptors:localEntityId UpdatedKey:entityUpdated] :
                                               [self getSortDescriptors:localEntityId Id2Key:localEntityId2 UpdatedKey:entityUpdated];
        [request setSortDescriptors:sortDecriptors];
        [request setEntity:entity];
        [request setFetchLimit:1];
        NSError *error = nil;
        NSArray *elementsArray = [dataController.managedObjectContext executeFetchRequest:request error:&error];
        result = elementsArray.count > 0 ? [elementsArray firstObject] : nil;
        return result;
    };
    
    id lastElement = getLastElement();
    
    long (^getLastId)(NSString *) = ^(NSString *entityId){
        long result = -1000;
        if (!lastElement || !entityId) return result;
        if ([entityId rangeOfString:@"."].location == NSNotFound)
            return [[lastElement valueForKey:entityId] longValue];
        NSArray *parts = [entityId componentsSeparatedByString:@"."];
        return [[[lastElement valueForKey:parts[0]] valueForKey:parts[1]] longValue];
    };
    long lastId = getLastId(localEntityId);
    long lastId2 = getLastId(localEntityId2);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                                entityName, @"table_name",
                                   [API dateToMySqlString:lastUpdatedDate], @"last_updated",
                                [NSString stringWithFormat:@"%ld", lastId], @"last_id", nil];
    if (entityId2) [params setObject:[NSString stringWithFormat:@"%ld", lastId2] forKey:entityId2];
    [self downloadDataFromServer:params ResponseHandler:responseHandler EntityAttributeNames:entityAttributeNames];
}

- (void)downloadDataFromServer:(NSMutableDictionary *)params ResponseHandler:(SEL)responseHandler
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

- (void)handleServerData:(id)serverData SetItemMethod:(void (^)(id, NSArray *))setItem
        NextBlockOfItemsMethod:(SEL)nextBlockOfItems EntityAttributeNames:(NSDictionary *)entityAttributeNames {
    
    if (![serverData isKindOfClass:[NSArray class]] || [serverData count] == 0) return;
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
    
    NSString *lastElementUpdatedDateString = [[serverData lastObject] valueForKey:entityUpdated];
    NSDate *lastElementUpdatedDate = [API mySqlStringToDate:lastElementUpdatedDateString];
    
    void (^updateLastSyncServerDate)(void) = ^{
        Variables *lastSyncServer = [Variables getVariable:@"lastSyncServer"];
        NSDate *currentLastSyncServerDate = lastSyncServer.variable_value;
        if ([[currentLastSyncServerDate laterDate:lastElementUpdatedDate] isEqualToDate:lastElementUpdatedDate]) {
            lastSyncServer.variable_value = lastElementUpdatedDate;
            NSLog(@"New lastUpdatedDate: %@", lastElementUpdatedDate);
        }
    };
    
//    updateLastSyncServerDate();
    [dataController.app saveContext];
    if ([serverData count] == AMOUNT && [self respondsToSelector:nextBlockOfItems]) {
        [self performSelector:nextBlockOfItems withObject:lastElementUpdatedDate];
    }
}

- (NSArray *)getSortDescriptors:(NSString *)idKey UpdatedKey:(NSString *)updatedKey {
    NSSortDescriptor *idSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:idKey ascending:NO];
    NSSortDescriptor *updatedSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:updatedKey ascending:NO];
    NSArray *result = [NSArray arrayWithObjects:idSortDescriptor, updatedSortDescriptor, nil];
    return result;
}

- (NSArray *)getSortDescriptors:(NSString *)idKey Id2Key:(NSString *)id2Key UpdatedKey:(NSString *)updatedKey {
    NSSortDescriptor *id2SortDescriptor = [NSSortDescriptor sortDescriptorWithKey:id2Key ascending:NO];
    NSMutableArray *result = [NSMutableArray arrayWithArray:[self getSortDescriptors:idKey UpdatedKey:updatedKey]];
    [result insertObject:id2SortDescriptor atIndex:1];
    return [NSArray arrayWithArray:result];
}

@end
