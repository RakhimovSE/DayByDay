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

+ (void)syncAllData {
    NSDate *lastSyncOld = [Sync getLastSync];
    ServerToDeviceSync *serverToDeviceSync = [[ServerToDeviceSync alloc] init];
    [serverToDeviceSync syncAllData:lastSyncOld];
    DeviceToServerSync *deviceToServerSync = [[DeviceToServerSync alloc] init];
    [deviceToServerSync AllData];
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
