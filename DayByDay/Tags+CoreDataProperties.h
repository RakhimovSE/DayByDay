//
//  Tags+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
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
@property (nullable, nonatomic, retain) NSSet<Tags_Results *> *tags_results;
@property (nullable, nonatomic, retain) Users *user;

@end

@interface Tags (CoreDataGeneratedAccessors)

- (void)addTags_resultsObject:(Tags_Results *)value;
- (void)removeTags_resultsObject:(Tags_Results *)value;
- (void)addTags_results:(NSSet<Tags_Results *> *)values;
- (void)removeTags_results:(NSSet<Tags_Results *> *)values;

@end

NS_ASSUME_NONNULL_END
