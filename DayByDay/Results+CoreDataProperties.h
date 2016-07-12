//
//  Results+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 12.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Results.h"
#import "Results_Relationships.h"
#import "Results_References.h"
#import "Tags_Results.h"

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
@property (nullable, nonatomic, retain) NSSet<Results_Relationships *> *childResults_relationships;
@property (nullable, nonatomic, retain) Difficulties *difficulty;
@property (nullable, nonatomic, retain) Energies *energy;
@property (nullable, nonatomic, retain) HotSpots *hotSpot;
@property (nullable, nonatomic, retain) Locations *location;
@property (nullable, nonatomic, retain) NSSet<Results_Relationships *> *parentResults_relationships;
@property (nullable, nonatomic, retain) PeriodTypes *periodType;
@property (nullable, nonatomic, retain) Priorities *priority;
@property (nullable, nonatomic, retain) Qualities *quality;
@property (nullable, nonatomic, retain) NSSet<Results_References *> *results_references;
@property (nullable, nonatomic, retain) NSSet<Tags_Results *> *tags_results;
@property (nullable, nonatomic, retain) Users *user;

@end

@interface Results (CoreDataGeneratedAccessors)

- (void)addChildResults_relationshipsObject:(Results_Relationships *)value;
- (void)removeChildResults_relationshipsObject:(Results_Relationships *)value;
- (void)addChildResults_relationships:(NSSet<Results_Relationships *> *)values;
- (void)removeChildResults_relationships:(NSSet<Results_Relationships *> *)values;

- (void)addParentResults_relationshipsObject:(Results_Relationships *)value;
- (void)removeParentResults_relationshipsObject:(Results_Relationships *)value;
- (void)addParentResults_relationships:(NSSet<Results_Relationships *> *)values;
- (void)removeParentResults_relationships:(NSSet<Results_Relationships *> *)values;

- (void)addResults_referencesObject:(Results_References *)value;
- (void)removeResults_referencesObject:(Results_References *)value;
- (void)addResults_references:(NSSet<Results_References *> *)values;
- (void)removeResults_references:(NSSet<Results_References *> *)values;

- (void)addTags_resultsObject:(Tags_Results *)value;
- (void)removeTags_resultsObject:(Tags_Results *)value;
- (void)addTags_results:(NSSet<Tags_Results *> *)values;
- (void)removeTags_results:(NSSet<Tags_Results *> *)values;

@end

NS_ASSUME_NONNULL_END
