//
//  Priorities+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Priorities.h"
#import "Results.h"

NS_ASSUME_NONNULL_BEGIN

@interface Priorities (CoreDataProperties)

@property (nonatomic) BOOL priority_deleted;
@property (nonatomic) int32_t priority_level;
@property (nullable, nonatomic, retain) NSString *priority_name;
@property (nonatomic) NSTimeInterval priority_updated;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;

@end

@interface Priorities (CoreDataGeneratedAccessors)

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

@end

NS_ASSUME_NONNULL_END
