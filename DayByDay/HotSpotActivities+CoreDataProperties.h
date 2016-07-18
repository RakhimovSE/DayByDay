//
//  HotSpotActivities+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotSpotActivities.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotSpotActivities (CoreDataProperties)

@property (nonatomic) BOOL hotSpotActivity_deleted;
@property (nullable, nonatomic, retain) NSString *hotSpotActivity_description;
@property (nonatomic) int32_t hotSpotActivity_id;
@property (nullable, nonatomic, retain) NSString *hotSpotActivity_name;
@property (nonatomic) NSTimeInterval hotSpotActivity_updated;
@property (nullable, nonatomic, retain) HotSpotActivitiesDefault *hotSpotActivityDefault;
@property (nullable, nonatomic, retain) NSSet<HotSpots *> *hotSpots;
@property (nullable, nonatomic, retain) Users *user;

@end

@interface HotSpotActivities (CoreDataGeneratedAccessors)

- (void)addHotSpotsObject:(HotSpots *)value;
- (void)removeHotSpotsObject:(HotSpots *)value;
- (void)addHotSpots:(NSSet<HotSpots *> *)values;
- (void)removeHotSpots:(NSSet<HotSpots *> *)values;

@end

NS_ASSUME_NONNULL_END
