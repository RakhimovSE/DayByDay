//
//  Locations+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Locations.h"

NS_ASSUME_NONNULL_BEGIN

@interface Locations (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *location_address;
@property (nonatomic) BOOL location_deleted;
@property (nonatomic) int32_t location_id;
@property (nonatomic) double location_latitude;
@property (nonatomic) double location_longitude;
@property (nullable, nonatomic, retain) NSString *location_name;
@property (nonatomic) NSTimeInterval location_updated;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;
@property (nullable, nonatomic, retain) Users *user;

@end

@interface Locations (CoreDataGeneratedAccessors)

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

@end

NS_ASSUME_NONNULL_END
