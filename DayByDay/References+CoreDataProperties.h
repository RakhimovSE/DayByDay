//
//  References+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "References.h"
#import "Results_References.h"

NS_ASSUME_NONNULL_BEGIN

@interface References (CoreDataProperties)

@property (nonatomic) BOOL reference_deleted;
@property (nonatomic) int32_t reference_id;
@property (nullable, nonatomic, retain) NSString *reference_name;
@property (nullable, nonatomic, retain) NSString *reference_text;
@property (nonatomic) NSTimeInterval reference_updated;
@property (nullable, nonatomic, retain) Users *user;
@property (nullable, nonatomic, retain) NSSet<Results_References *> *results_references;

@end

@interface References (CoreDataGeneratedAccessors)

- (void)addResults_referencesObject:(Results_References *)value;
- (void)removeResults_referencesObject:(Results_References *)value;
- (void)addResults_references:(NSSet<Results_References *> *)values;
- (void)removeResults_references:(NSSet<Results_References *> *)values;

@end

NS_ASSUME_NONNULL_END
