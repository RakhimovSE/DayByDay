//
//  Variables.m
//  DayByDay
//
//  Created by Admin on 09.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "Variables.h"
#import "DataController.h"

@implementation Variables

// Insert code here to add functionality to your managed object subclass

+ (NSPredicate *)getPredicate:(NSString *)entityIdKey   EntityIdValue:(NSString *)entityIdValue
                 EntityId2Key:(NSString *)entityId2Key EntityId2Value:(NSString *)entityId2Value {
    NSPredicate *result;
    if ([entityId2Key isEqualToString:@""]) result = [NSPredicate predicateWithFormat:@"%K = %@", entityIdKey, entityIdValue];
    else result = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@", entityIdKey, entityIdValue, entityId2Key, entityId2Value];
    return result;
}

+ (NSManagedObject *)getVariable:(NSString *)entityName EntityIdKey:(NSString *)entityIdKey   EntityIdValue:(NSString *)entityIdValue {
    return [self getVariable:entityName EntityIdKey:entityIdKey EntityIdValue:entityIdValue EntityId2Key:@"" EntityId2Value:@""];
}

+ (NSManagedObject *)getVariable:(NSString *)entityName EntityIdKey:(NSString *)entityIdKey   EntityIdValue:(NSString *)entityIdValue
                                                       EntityId2Key:(NSString *)entityId2Key EntityId2Value:(NSString *)entityId2Value {
    NSManagedObject *result = nil;
    DataController *dataController = [[DataController alloc] init];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:dataController.managedObjectContext];
    [request setEntity:entity];
    NSPredicate *predicate = [self getPredicate:entityIdKey EntityIdValue:entityIdValue EntityId2Key:entityId2Key EntityId2Value:entityId2Value];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *itemArray = [dataController.managedObjectContext executeFetchRequest:request error:&error];
    if (itemArray.count > 0) result = [itemArray firstObject];
    return result;
}

+ (Variables *)insertVariable:(NSString *)key Value:(id)value {
    DataController *dataController = [[DataController alloc] init];
    Variables *result = [NSEntityDescription insertNewObjectForEntityForName:@"Variables" inManagedObjectContext:dataController.managedObjectContext];
    result.variable_key = key;
    result.variable_value = value;
    [dataController.app saveContext];
    return result;
}

+ (Variables *)getVariableWithKey:(NSString *)key {
    DataController *dataController = [[DataController alloc] init];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Variables"
                                              inManagedObjectContext:dataController.managedObjectContext];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"variable_key = %@", key];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *itemArray = [dataController.managedObjectContext executeFetchRequest:request error:&error];
    return [itemArray firstObject];
}

+ (void)updateVariable:(NSString *)key Value:(id)value {
    DataController *dataController = [[DataController alloc] init];
    Variables *result = [Variables getVariableWithKey:key];
    result.variable_value = value;
    [dataController.app saveContext];
}

+ (void)deleteVariable:(NSString *)key {
    DataController *dataController = [[DataController alloc] init];
    Variables *result = [Variables getVariableWithKey:key];
    [dataController.managedObjectContext deleteObject:result];
}

@end
