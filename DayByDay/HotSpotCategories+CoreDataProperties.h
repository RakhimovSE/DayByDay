//
//  HotSpotCategories+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotSpotCategories.h"
#import "HotSpots.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotSpotCategories (CoreDataProperties)

@property (nonatomic) BOOL hotSpotCategory_deleted;
@property (nullable, nonatomic, retain) NSString *hotSpotCategory_description;
@property (nonatomic) int32_t hotSpotCategory_id;
@property (nullable, nonatomic, retain) NSString *hotSpotCategory_name;
@property (nonatomic) NSTimeInterval hotSpotCategory_updated;
@property (nullable, nonatomic, retain) HotSpotCategoriesDefault *hotSpotCategoryDefault;
@property (nullable, nonatomic, retain) NSSet<HotSpots *> *hotSpots;
@property (nullable, nonatomic, retain) Users *user;

@end

@interface HotSpotCategories (CoreDataGeneratedAccessors)

- (void)addHotSpotsObject:(HotSpots *)value;
- (void)removeHotSpotsObject:(HotSpots *)value;
- (void)addHotSpots:(NSSet<HotSpots *> *)values;
- (void)removeHotSpots:(NSSet<HotSpots *> *)values;

@end

NS_ASSUME_NONNULL_END
