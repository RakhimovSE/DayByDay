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

+ (Variables *)insertVariable:(NSString *)key Value:(id)value {
    DataController *dataController = [[DataController alloc] init];
    Variables *result = [NSEntityDescription insertNewObjectForEntityForName:@"Variables" inManagedObjectContext:dataController.managedObjectContext];
    result.variable_key = key;
    result.variable_value = value;
    [dataController.app saveContext];
    return result;
}

+ (Variables *)getVariable:(NSString *)key {
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
    Variables *result = [Variables getVariable:key];
    result.variable_value = value;
    [dataController.app saveContext];
}

+ (void)deleteVariable:(NSString *)key {
    DataController *dataController = [[DataController alloc] init];
    Variables *result = [Variables getVariable:key];
    [dataController.managedObjectContext deleteObject:result];
}

@end
