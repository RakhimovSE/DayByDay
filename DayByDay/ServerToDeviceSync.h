//
//  SyncDownload.h
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerToDeviceSync : NSObject

- (void)AllData;

- (void)difficulties;
- (void)energies;
- (void)hotSpotActivities;
- (void)hotSpotActivitiesDefault;
- (void)hotSpotCategories;
- (void)hotSpotCategoriesDefault;
- (void)hotSpots;
- (void)hotSpotsDefault;
- (void)locations;
- (void)periodTypes;
- (void)priorities;
- (void)qualities;
- (void)rates;
- (void)references;
- (void)results;
- (void)resultsLinks;
- (void)resultsReferences;
- (void)socialNetworks;
- (void)tags;
- (void)tagsResults;
- (void)users;
- (void)usersSocialNetworks;
- (void)weekLimits;

@end
