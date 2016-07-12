//
//  Rates+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Rates.h"

NS_ASSUME_NONNULL_BEGIN

@interface Rates (CoreDataProperties)

@property (nonatomic) BOOL rate_deleted;
@property (nonatomic) int32_t rate_level;
@property (nonatomic) int32_t rate_minScore;
@property (nullable, nonatomic, retain) NSString *rate_name;
@property (nonatomic) NSTimeInterval rate_updated;

@end

NS_ASSUME_NONNULL_END
