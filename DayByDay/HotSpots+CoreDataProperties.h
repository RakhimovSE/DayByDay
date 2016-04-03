//
//  HotSpots+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 03.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotSpots.h"
#import "Results.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotSpots (CoreDataProperties)

@property (nonatomic) BOOL hotSpot_deleted;
@property (nonatomic) int32_t hotSpot_id;
@property (nonatomic) double hotSpot_percent;
@property (nonatomic) NSTimeInterval hotSpot_updated;
@property (nullable, nonatomic, retain) HotSpotActivities *hotSpotActivity;
@property (nullable, nonatomic, retain) HotSpotCategories *hotSpotCategory;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;

@end

@interface HotSpots (CoreDataGeneratedAccessors)

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

@end

NS_ASSUME_NONNULL_END
