//
//  Results+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 03.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Results.h"

NS_ASSUME_NONNULL_BEGIN

@interface Results (CoreDataProperties)

@property (nonatomic) BOOL result_deleted;
@property (nullable, nonatomic, retain) NSString *result_description;
@property (nonatomic) NSTimeInterval result_finishDate;
@property (nonatomic) int32_t result_id;
@property (nonatomic) BOOL result_main;
@property (nullable, nonatomic, retain) NSString *result_name;
@property (nonatomic) NSTimeInterval result_startDateTime;
@property (nonatomic) NSTimeInterval result_updated;
@property (nonatomic) NSTimeInterval resut_timeAmount;
@property (nullable, nonatomic, retain) NSSet<Results *> *childrenResults;
@property (nullable, nonatomic, retain) Difficulties *difficulty;
@property (nullable, nonatomic, retain) Energies *energy;
@property (nullable, nonatomic, retain) HotSpots *hotSpot;
@property (nullable, nonatomic, retain) Locations *location;
@property (nullable, nonatomic, retain) Results *parentResult;
@property (nullable, nonatomic, retain) PeriodTypes *periodType;
@property (nullable, nonatomic, retain) Priorities *priority;
@property (nullable, nonatomic, retain) Qualities *quality;
@property (nullable, nonatomic, retain) NSSet<References *> *references;
@property (nullable, nonatomic, retain) NSSet<Tags *> *tags;
@property (nullable, nonatomic, retain) Users *user;

@end

@interface Results (CoreDataGeneratedAccessors)

- (void)addChildrenResultsObject:(Results *)value;
- (void)removeChildrenResultsObject:(Results *)value;
- (void)addChildrenResults:(NSSet<Results *> *)values;
- (void)removeChildrenResults:(NSSet<Results *> *)values;

- (void)addReferencesObject:(References *)value;
- (void)removeReferencesObject:(References *)value;
- (void)addReferences:(NSSet<References *> *)values;
- (void)removeReferences:(NSSet<References *> *)values;

- (void)addTagsObject:(Tags *)value;
- (void)removeTagsObject:(Tags *)value;
- (void)addTags:(NSSet<Tags *> *)values;
- (void)removeTags:(NSSet<Tags *> *)values;

@end

NS_ASSUME_NONNULL_END
