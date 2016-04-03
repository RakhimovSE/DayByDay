//
//  WeekLimits+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 03.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WeekLimits.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeekLimits (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *weekLimit_activity;
@property (nonatomic) BOOL weekLimit_deleted;
@property (nonatomic) int32_t weekLimit_id;
@property (nonatomic) NSTimeInterval weekLimit_updated;
@property (nonatomic) int32_t weekLimit_weekday;
@property (nullable, nonatomic, retain) Users *user;

@end

NS_ASSUME_NONNULL_END
