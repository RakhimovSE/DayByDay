//
//  Tags+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tags.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tags (CoreDataProperties)

@property (nonatomic) BOOL tag_deleted;
@property (nonatomic) int32_t tag_id;
@property (nullable, nonatomic, retain) NSString *tag_name;
@property (nonatomic) NSTimeInterval tag_updated;
@property (nullable, nonatomic, retain) Users *user;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *tags_results;

@end

@interface Tags (CoreDataGeneratedAccessors)

- (void)addTags_resultsObject:(NSManagedObject *)value;
- (void)removeTags_resultsObject:(NSManagedObject *)value;
- (void)addTags_results:(NSSet<NSManagedObject *> *)values;
- (void)removeTags_results:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
