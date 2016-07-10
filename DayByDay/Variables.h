//
//  Variables.h
//  DayByDay
//
//  Created by Admin on 09.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Variables : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (Variables *)insertVariable:(NSString *)key Value:(id)value;
+ (Variables *)getVariable:(NSString *)key;
+ (void)updateVariable:(NSString *)key Value:(id)value;
+ (void)deleteVariable:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

#import "Variables+CoreDataProperties.h"
