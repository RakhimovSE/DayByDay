//
//  ResultTableViewController.h
//  DayByDay
//
//  Created by Admin on 01.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultDataController.h"

@interface ResultTableViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ResultDataController *dataController;

@end
