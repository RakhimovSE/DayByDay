//
//  Results_Relationships+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Results_Relationships.h"

NS_ASSUME_NONNULL_BEGIN

@interface Results_Relationships (CoreDataProperties)

@property (nonatomic) BOOL result_relationship_deleted;
@property (nonatomic) NSTimeInterval result_relationship_updated;
@property (nullable, nonatomic, retain) Results *childResult;
@property (nullable, nonatomic, retain) Results *parentResult;

@end

NS_ASSUME_NONNULL_END
