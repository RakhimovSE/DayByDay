//
//  HotSpotCategoriesDefault+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 03.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotSpotCategoriesDefault.h"
#import "HotSpotActivitiesDefault.h"
#import "HotSpotCategories.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotSpotCategoriesDefault (CoreDataProperties)

@property (nonatomic) BOOL hotSpotCategoryDefault_deleted;
@property (nullable, nonatomic, retain) NSString *hotSpotCategoryDefault_description;
@property (nonatomic) int32_t hotSpotCategoryDefault_id;
@property (nullable, nonatomic, retain) NSString *hotSpotCategoryDefault_name;
@property (nonatomic) NSTimeInterval hotSpotCategoryDefault_updated;
@property (nullable, nonatomic, retain) NSSet<HotSpotActivitiesDefault *> *hotSpotActivitiesDefault;
@property (nullable, nonatomic, retain) NSSet<HotSpotCategories *> *hotSpotCategories;

@end

@interface HotSpotCategoriesDefault (CoreDataGeneratedAccessors)

- (void)addHotSpotActivitiesDefaultObject:(HotSpotActivitiesDefault *)value;
- (void)removeHotSpotActivitiesDefaultObject:(HotSpotActivitiesDefault *)value;
- (void)addHotSpotActivitiesDefault:(NSSet<HotSpotActivitiesDefault *> *)values;
- (void)removeHotSpotActivitiesDefault:(NSSet<HotSpotActivitiesDefault *> *)values;

- (void)addHotSpotCategoriesObject:(HotSpotCategories *)value;
- (void)removeHotSpotCategoriesObject:(HotSpotCategories *)value;
- (void)addHotSpotCategories:(NSSet<HotSpotCategories *> *)values;
- (void)removeHotSpotCategories:(NSSet<HotSpotCategories *> *)values;

@end

NS_ASSUME_NONNULL_END
