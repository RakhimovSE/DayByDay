//
//  ResultDataController.m
//  DayByDay
//
//  Created by Admin on 08.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ResultDataController.h"

@implementation ResultDataController

- (void)initNewResultViewController:(UIPickerView **)hotSpotsPickerView {
    [*hotSpotsPickerView setValue:@"TestValue" forKey:@"TestKey"];
    [*hotSpotsPickerView reloadAllComponents];
}

- (NSMutableDictionary *)getUserResults
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                        @"ResultAPI", @"className",
                                                   @"getUserResults", @"methodName",
                [NSString stringWithFormat:@"%ld", [self getUserId]], @"user_id", nil];
    NSNumber *responseNumber = [[NSNumber alloc] init];
    NSMutableDictionary *result = [API performRequestAndGetResultAndResponseCode:params ResponseCode:&responseNumber];
    if ([responseNumber longValue] != 200) {
        [Constants showAlertMessage:[NSString stringWithFormat:@"Error %@", responseNumber]];
        return nil;
    }
    return result;
}

- (NSMutableDictionary *)getUserHotSpots
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                        @"ResultAPI", @"className",
                                                  @"getUserHotSpots", @"methodName",
                                   [NSString stringWithFormat:@"%ld", [self getUserId]], @"user_id", nil];
    NSNumber *responseNumber = [[NSNumber alloc] init];
    NSMutableDictionary *result = [API performRequestAndGetResultAndResponseCode:params ResponseCode:&responseNumber];
    if ([responseNumber longValue] != 200) {
        [Constants showAlertMessage:[NSString stringWithFormat:@"Error %@", responseNumber]];
        return nil;
    }
    return result;
}

@end
