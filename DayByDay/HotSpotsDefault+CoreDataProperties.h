//
//  HotSpotsDefault+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotSpotsDefault.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotSpotsDefault (CoreDataProperties)

@property (nonatomic) BOOL hotSpotDefault_deleted;
@property (nonatomic) int32_t hotSpotDefault_id;
@property (nonatomic) NSTimeInterval hotSpotDefault_updated;
@property (nullable, nonatomic, retain) HotSpotActivitiesDefault *hotSpotActivityDefault;
@property (nullable, nonatomic, retain) HotSpotCategoriesDefault *hotSpotCategoryDefault;

@end

NS_ASSUME_NONNULL_END
