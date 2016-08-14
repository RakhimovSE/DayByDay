//
//  DataController.m
//  DayByDay
//
//  Created by Admin on 08.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DataController.h"

@implementation DataController

- (id)init {
    if (self = [super init]) {
        DayByDayAppDelegate *app = (DayByDayAppDelegate*)[[UIApplication sharedApplication] delegate];
        self.app = app;
        self.managedObjectContext = app.managedObjectContext;
        self.managedObjectModel = app.managedObjectModel;
        self.persistentStoreCoordinator = app.persistentStoreCoordinator;
        return self;
    }
    return nil;
}

- (long)getUserId {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    NSManagedObject *user_id = [results objectAtIndex:0];
    return [[user_id valueForKey:@"user_id"] longValue];
}

@end
