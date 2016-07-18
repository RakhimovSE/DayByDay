//
//  Qualities+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Qualities.h"

NS_ASSUME_NONNULL_BEGIN

@interface Qualities (CoreDataProperties)

@property (nonatomic) BOOL quality_deleted;
@property (nonatomic) int32_t quality_level;
@property (nullable, nonatomic, retain) NSString *quality_name;
@property (nonatomic) NSTimeInterval quality_updated;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;

@end

@interface Qualities (CoreDataGeneratedAccessors)

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

@end

NS_ASSUME_NONNULL_END
