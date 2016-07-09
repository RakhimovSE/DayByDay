//
//  NewResultViewController.m
//  DayByDay
//
//  Created by Admin on 10.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DayByDayAppDelegate.h"
#import "ResultDataController.h"
#import "NewResultViewController.h"
#import "API.h"

@interface NewResultViewController () {
    ResultDataController *resultDataController;
    
    NSMutableDictionary *userHotSpots;
    NSMutableDictionary *hotSpotCategories;
    NSMutableDictionary *hotSpotActivities;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *periodTypesSegmented;
@property (weak, nonatomic) IBOutlet UITextField *resultNameTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *hotSpotsPicker;

@end

@implementation NewResultViewController

@synthesize periodTypesSegmented;
@synthesize resultNameTextField;
@synthesize hotSpotsPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    resultDataController = [[ResultDataController alloc] init];
    
    userHotSpots = [resultDataController getUserHotSpots];
    hotSpotActivities = [API allValuesFromMutableDictionary:userHotSpots ForKey:@"hotSpotActivity_id" Value:@"hotSpotActivity_name"];
    hotSpotCategories = [API allValuesFromMutableDictionary:userHotSpots ForKey:@"hotSpotCategory_id" Value:@"hotSpotCategory_name"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return hotSpotCategories.count;
            break;
        case 1:
            return hotSpotActivities.count;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [[hotSpotCategories allValues] objectAtIndex:row];
            break;
        case 1:
            return [[hotSpotActivities allValues] objectAtIndex:row];
            break;
        default:
            return @"";
            break;
    }
}

- (IBAction)resultTextFieldTouchUpOutside:(id)sender {
    
}

- (IBAction)createResultButton:(id)sender {
    if ([resultNameTextField.text isEqualToString:@""]) {
        [Constants showAlertMessage:@"Введите название задачи"];
        return;
    }
    NSInteger hotSpotCategoryId = [[[hotSpotCategories allKeys] objectAtIndex:[hotSpotsPicker selectedRowInComponent:0]] integerValue];
    NSInteger hotSpotActivityId = [[[hotSpotActivities allKeys] objectAtIndex:[hotSpotsPicker selectedRowInComponent:1]] integerValue];
    NSInteger userHotSpotId = [resultDataController getUserHotSpotId:userHotSpots CategoryId:hotSpotCategoryId ActivityId:hotSpotActivityId];
    if (userHotSpotId == -1) {
        [Constants showAlertMessage:@"Сфера влияния не найдена"];
        return;
    }
    NSString *periodTypeLength;
    switch (periodTypesSegmented.selectedSegmentIndex) {
        case 0:
            periodTypeLength = @"0000-00-01";
            break;
        case 1:
            periodTypeLength = @"0000-00-07";
            break;
        case 2:
            periodTypeLength = @"0000-01-00";
            break;
        case 3:
            periodTypeLength = @"0000-03-00";
            break;
        case 4:
            periodTypeLength = @"0001-00-00";
            break;
        default:
            break;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                           @"ResultAPI", @"className",
                                                        @"createResult", @"methodName",
   [NSString stringWithFormat:@"%li", [resultDataController getUserId]], @"fk_user_id",
                                                       periodTypeLength, @"fk_periodType_length",
                                               resultNameTextField.text, @"result_name",
                [NSString stringWithFormat:@"%li", (long)userHotSpotId], @"fk_hotSpot_id", nil];
    long responseCode = [API performRequestAndGetResponseCode:params];
    if (responseCode != 200) [Constants showAlertMessage:[NSString stringWithFormat:@"Не удалось добавить результат. Ошибка %lu", responseCode]];
    else
        [self.navigationController popViewControllerAnimated:YES];
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
