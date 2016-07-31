//
//  Sync.m
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "Sync.h"
#import "ServerToDeviceSync.h"
#import "DeviceToServerSync.h"
#import "Variables.h"
#import "API.h"

@implementation Sync

#pragma mark - Data downloading

+ (void)syncAllData:(id)viewControllerDelegate {
    NSDate *lastSyncOld = [Sync getLastSync];
    DeviceToServerSync *deviceToServerSync = [[DeviceToServerSync alloc] init];
    [deviceToServerSync AllData];
    ServerToDeviceSync *serverToDeviceSync = [[ServerToDeviceSync alloc] initWithLastSync:lastSyncOld];
    serverToDeviceSync.viewControllerDelegate = viewControllerDelegate;
    [serverToDeviceSync syncAllData];
}

+ (NSDate *)getLastSync {
    Variables *lastSyncVariableOld = [Variables getVariable:@"lastSyncServer"];
    NSDate *result;
    if (lastSyncVariableOld) {
        result = lastSyncVariableOld.variable_value;
    } else {
        result = [API mySqlStringToDate:@"0001-01-01 00:00:00"];
        [Variables insertVariable:@"lastSyncServer" Value:result];
    }
    return result;
}

#pragma mark - Data uploading

@end
