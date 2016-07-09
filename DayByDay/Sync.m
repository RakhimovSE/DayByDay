//
//  Sync.m
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ServerToDeviceSync.h"
#import "DeviceToServerSync.h"
#import "Sync.h"

@implementation Sync

#pragma mark - Data downloading

+ (void)syncAllData {
    ServerToDeviceSync *serverToDeviceSync = [[ServerToDeviceSync alloc] init];
    [serverToDeviceSync AllData];
    DeviceToServerSync *deviceToServerSync = [[DeviceToServerSync alloc] init];
    [deviceToServerSync AllData];
}

+ (void)updateLastSyncDate {
    
}

#pragma mark - Data uploading

@end
