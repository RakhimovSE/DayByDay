//
//  TagsDefault+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 31.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TagsDefault.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsDefault (CoreDataProperties)

@property (nonatomic) int32_t tagDefault_id;
@property (nonatomic) BOOL tagDefault_deleted;
@property (nonatomic) NSTimeInterval tagDefault_updated;
@property (nullable, nonatomic, retain) NSString *tagDefault_name;

@end

NS_ASSUME_NONNULL_END
