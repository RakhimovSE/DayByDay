//
//  DataController.m
//  DayByDay
//
//  Created by Admin on 08.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DataController.h"

@implementation DataController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    if (self = [super init]) {
        self.managedObjectContext = managedObjectContext;
        return self;
    }
    return nil;
}

- (id)initWithDataController:(DataController *)dataController {
    if (self = [super init]) {
        self.fetchedResultsController = dataController.fetchedResultsController;
        self.managedObjectContext = dataController.managedObjectContext;
        self.managedObjectModel = dataController.managedObjectModel;
        self.persistentStoreCoordinator = dataController.persistentStoreCoordinator;
        return self;
    }
    return nil;
}

- (long)getUserId {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Variables" inManagedObjectContext:self.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    NSManagedObject *user_id = [results objectAtIndex:0];
    return [[[user_id valueForKey:@"value"] description] longLongValue];
}

@end
