//
//  SignupViewController.h
//  DayByDay
//
//  Created by Admin on 01.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataController.h"

@interface SignupViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UserDataController *dataController;

@end
