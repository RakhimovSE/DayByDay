//
//  ResultTableViewController.h
//  DayByDay
//
//  Created by Admin on 01.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "ResultDataController.h"

@interface ResultTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) DataController *dataController;

@end
