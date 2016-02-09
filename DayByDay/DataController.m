//
//  DataController.m
//  DayByDay
//
//  Created by Admin on 08.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DataController.h"

@implementation DataController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (self = [super init]) {
        self.managedObjectContext = managedObjectContext;
        return self;
    }
    return nil;
}

@end
