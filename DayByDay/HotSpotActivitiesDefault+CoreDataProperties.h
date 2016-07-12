//
//  HotSpotActivitiesDefault+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotSpotActivitiesDefault.h"
#import "HotSpotsDefault.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotSpotActivitiesDefault (CoreDataProperties)

@property (nonatomic) BOOL hotSpotActivityDefault_deleted;
@property (nullable, nonatomic, retain) NSString *hotSpotActivityDefault_description;
@property (nonatomic) int32_t hotSpotActivityDefault_id;
@property (nullable, nonatomic, retain) NSString *hotSpotActivityDefault_name;
@property (nonatomic) NSTimeInterval hotSpotActivityDefault_updated;
@property (nullable, nonatomic, retain) NSSet<HotSpotActivities *> *hotSpotActivities;
@property (nullable, nonatomic, retain) NSSet<HotSpotsDefault *> *hotSpotsDefault;

@end

@interface HotSpotActivitiesDefault (CoreDataGeneratedAccessors)

- (void)addHotSpotActivitiesObject:(HotSpotActivities *)value;
- (void)removeHotSpotActivitiesObject:(HotSpotActivities *)value;
- (void)addHotSpotActivities:(NSSet<HotSpotActivities *> *)values;
- (void)removeHotSpotActivities:(NSSet<HotSpotActivities *> *)values;

- (void)addHotSpotsDefaultObject:(HotSpotsDefault *)value;
- (void)removeHotSpotsDefaultObject:(HotSpotsDefault *)value;
- (void)addHotSpotsDefault:(NSSet<HotSpotsDefault *> *)values;
- (void)removeHotSpotsDefault:(NSSet<HotSpotsDefault *> *)values;

@end

NS_ASSUME_NONNULL_END
