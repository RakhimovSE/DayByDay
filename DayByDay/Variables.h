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

+ (NSManagedObject *)getVariable:(NSString *)entityName EntityIdKey:(NSString *)entityIdKey   EntityIdValue:(NSString *)entityIdValue;
+ (NSManagedObject *)getVariable:(NSString *)entityName EntityIdKey:(NSString *)entityIdKey   EntityIdValue:(NSString *)entityIdValue
                    EntityId2Key:(NSString *)entityId2Key EntityId2Value:(NSString *)entityId2Value;

+ (Variables *)insertVariable:(NSString *)key Value:(id)value;
+ (Variables *)getVariableWithKey:(NSString *)key;
+ (void)updateVariable:(NSString *)key Value:(id)value;
+ (void)deleteVariable:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

#import "Variables+CoreDataProperties.h"
