//
//  HotSpotsDefault+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotSpotsDefault.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotSpotsDefault (CoreDataProperties)

@property (nonatomic) BOOL hotSpotsDefault_deleted;
@property (nonatomic) int32_t hotSpotsDefault_id;
@property (nonatomic) NSTimeInterval hotSpotsDefault_updated;
@property (nullable, nonatomic, retain) HotSpotActivitiesDefault *hotSpotActivityDefault;
@property (nullable, nonatomic, retain) HotSpotCategoriesDefault *hotSpotCategoryDefault;

@end

NS_ASSUME_NONNULL_END
