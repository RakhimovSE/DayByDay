//
//  ResultDataController.m
//  DayByDay
//
//  Created by Admin on 08.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ResultDataController.h"

@implementation ResultDataController

- (NSMutableDictionary *)getUserResults
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Variables" inManagedObjectContext:self.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    NSManagedObject *user_id = [results objectAtIndex:0];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        @"ResultAPI", @"className",
                                   @"getUserResults", @"methodName",
        [[user_id valueForKey:@"value"] description], @"user_id", nil];
    NSMutableDictionary *result = [API performRequestAndGetResultAndResponseCode:params];
    return result;
}

@end
