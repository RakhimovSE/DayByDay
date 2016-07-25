//
//  DBCleaner.h
//  DayByDay
//
//  Created by Admin on 03.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBRemover : NSObject

- (void)removeEntireDatabase;
- (void)removeUserData;

- (void)removeDifficulties;
- (void)removeEnergies;
- (void)removeHotSpotActivities;
- (void)removeHotSpotActivitiesDefault;
- (void)removeHotSpotCategories;
- (void)removeHotSpotCategoriesDefault;
- (void)removeHotSpots;
- (void)removeHotSpotsDefault;
- (void)removeLocations;
- (void)removePeriodTypes;
- (void)removePriorities;
- (void)removeQualities;
- (void)removeRates;
- (void)removeReferences;
- (void)removeResults;
- (void)removeResults_Relationships;
- (void)removeResults_References;
- (void)removeSocialNetworks;
- (void)removeTags;
- (void)removeTags_Results;
- (void)removeUsers;
- (void)removeUsers_SocialNetworks;
- (void)removeVariables;

@end
