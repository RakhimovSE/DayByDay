//
//  Variables+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Variables.h"

NS_ASSUME_NONNULL_BEGIN

@interface Variables (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *variable_key;
@property (nullable, nonatomic, retain) id variable_value;

@end

NS_ASSUME_NONNULL_END
