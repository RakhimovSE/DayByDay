//
//  NewResultViewController.h
//  DayByDay
//
//  Created by Admin on 10.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultDataController.h"

@interface NewResultViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) DataController *dataController;

@end
