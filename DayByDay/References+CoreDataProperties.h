//
//  References+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 03.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "References.h"
#import "Results.h"

NS_ASSUME_NONNULL_BEGIN

@interface References (CoreDataProperties)

@property (nonatomic) BOOL reference_deleted;
@property (nonatomic) int32_t reference_id;
@property (nullable, nonatomic, retain) NSString *reference_name;
@property (nullable, nonatomic, retain) NSString *reference_text;
@property (nonatomic) NSTimeInterval reference_updated;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;
@property (nullable, nonatomic, retain) Users *user;

@end

@interface References (CoreDataGeneratedAccessors)

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

@end

NS_ASSUME_NONNULL_END
