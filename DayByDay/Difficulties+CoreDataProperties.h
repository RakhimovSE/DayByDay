//
//  Difficulties+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Difficulties.h"
#import "Results.h"

NS_ASSUME_NONNULL_BEGIN

@interface Difficulties (CoreDataProperties)

@property (nonatomic) BOOL difficulty_deleted;
@property (nonatomic) int32_t difficulty_level;
@property (nullable, nonatomic, retain) NSString *difficulty_name;
@property (nonatomic) NSTimeInterval difficulty_updated;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;

@end

@interface Difficulties (CoreDataGeneratedAccessors)

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

@end

NS_ASSUME_NONNULL_END
