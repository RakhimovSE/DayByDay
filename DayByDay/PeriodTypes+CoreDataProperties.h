//
//  PeriodTypes+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 31.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PeriodTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface PeriodTypes (CoreDataProperties)

@property (nonatomic) BOOL periodType_deleted;
@property (nonatomic) int32_t periodType_id;
@property (nullable, nonatomic, retain) NSString *periodType_name;
@property (nonatomic) NSTimeInterval periodType_updated;
@property (nonatomic) int32_t periodType_years;
@property (nonatomic) int32_t periodType_months;
@property (nonatomic) int32_t periodType_days;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;
@property (nullable, nonatomic, retain) PeriodTypes *childPeriodType;
@property (nullable, nonatomic, retain) PeriodTypes *parentPeriodType;

@end

@interface PeriodTypes (CoreDataGeneratedAccessors)

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

@end

NS_ASSUME_NONNULL_END
