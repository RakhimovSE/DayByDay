//
//  Results_References+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Results_References.h"

NS_ASSUME_NONNULL_BEGIN

@interface Results_References (CoreDataProperties)

@property (nonatomic) BOOL result_reference_deleted;
@property (nonatomic) NSTimeInterval result_reference_updated;
@property (nullable, nonatomic, retain) References *reference;
@property (nullable, nonatomic, retain) Results *result;

@end

NS_ASSUME_NONNULL_END
