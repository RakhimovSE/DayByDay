//
//  Energies+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 03.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Energies.h"
#import "Results.h"

NS_ASSUME_NONNULL_BEGIN

@interface Energies (CoreDataProperties)

@property (nonatomic) BOOL energy_deleted;
@property (nonatomic) int32_t energy_level;
@property (nullable, nonatomic, retain) NSString *energy_name;
@property (nonatomic) NSTimeInterval energy_updated;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;

@end

@interface Energies (CoreDataGeneratedAccessors)

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

@end

NS_ASSUME_NONNULL_END
