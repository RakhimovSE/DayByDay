//
//  NewResultViewController.m
//  DayByDay
//
//  Created by Admin on 10.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "NewResultViewController.h"

@interface NewResultViewController () {
    ResultDataController *resultDataController;
}

@property (strong, nonatomic) IBOutlet UIPickerView *hotSpotsPicker;

@end

@implementation NewResultViewController

@synthesize hotSpotsPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    resultDataController = [[ResultDataController alloc] initWithDataController:_dataController];
    NSLog(@"%@", resultDataController);
}
- (IBAction)createResultButton:(id)sender {
    //NSMutableDictionary *userHotSpots = [resultDataController getUserHotSpots];
    //NSLog(@"%@", userHotSpots);
    [Constants showAlertMessage:[NSString stringWithFormat:@"%@", [resultDataController getUserHotSpots]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
