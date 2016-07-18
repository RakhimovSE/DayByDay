//
//  HotSpotCategoriesDefault+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotSpotCategoriesDefault.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotSpotCategoriesDefault (CoreDataProperties)

@property (nonatomic) BOOL hotSpotCategoryDefault_deleted;
@property (nullable, nonatomic, retain) NSString *hotSpotCategoryDefault_description;
@property (nonatomic) int32_t hotSpotCategoryDefault_id;
@property (nullable, nonatomic, retain) NSString *hotSpotCategoryDefault_name;
@property (nonatomic) NSTimeInterval hotSpotCategoryDefault_updated;
@property (nullable, nonatomic, retain) NSSet<HotSpotCategories *> *hotSpotCategories;
@property (nullable, nonatomic, retain) NSSet<HotSpotsDefault *> *hotSpotsDefault;

@end

@interface HotSpotCategoriesDefault (CoreDataGeneratedAccessors)

- (void)addHotSpotCategoriesObject:(HotSpotCategories *)value;
- (void)removeHotSpotCategoriesObject:(HotSpotCategories *)value;
- (void)addHotSpotCategories:(NSSet<HotSpotCategories *> *)values;
- (void)removeHotSpotCategories:(NSSet<HotSpotCategories *> *)values;

- (void)addHotSpotsDefaultObject:(HotSpotsDefault *)value;
- (void)removeHotSpotsDefaultObject:(HotSpotsDefault *)value;
- (void)addHotSpotsDefault:(NSSet<HotSpotsDefault *> *)values;
- (void)removeHotSpotsDefault:(NSSet<HotSpotsDefault *> *)values;

@end

NS_ASSUME_NONNULL_END
