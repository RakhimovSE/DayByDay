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
- (void)removeResultsLinks;
- (void)removeResultsReferences;
- (void)removeSocialNetworks;
- (void)removeTags;
- (void)removeTagsResults;
- (void)removeUsers;
- (void)removeUsersSocialNetworks;
- (void)removeWeekLimits;

@end
