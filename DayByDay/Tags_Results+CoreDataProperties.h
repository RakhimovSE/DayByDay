//
//  Tags_Results+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tags_Results.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tags_Results (CoreDataProperties)

@property (nonatomic) NSTimeInterval tag_result_updated;
@property (nonatomic) BOOL tag_result_deleted;
@property (nullable, nonatomic, retain) Tags *tag;
@property (nullable, nonatomic, retain) Results *result;

@end

NS_ASSUME_NONNULL_END
