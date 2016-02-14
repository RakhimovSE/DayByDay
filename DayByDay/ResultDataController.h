//
//  ResultDataController.h
//  DayByDay
//
//  Created by Admin on 08.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DataController.h"

@interface ResultDataController : DataController

- (void)initNewResultViewController:(UIPickerView **)hotSpotsPickerView;

- (NSMutableDictionary *)getUserResults;
- (NSMutableDictionary *)getUserHotSpots;
- (NSInteger)getUserHotSpotId:(NSMutableDictionary *)userHotSpots CategoryId:(NSInteger)hotSpotCategoryId ActivityId:(NSInteger)hotSpotActivityId;

@end
