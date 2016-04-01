//
//  Sync.m
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "SyncDownload.h"
#import "SyncUpload.h"
#import "Sync.h"

@implementation Sync

#pragma mark - Data downloading

+ (void)syncAllData {
    [SyncDownload AllData];
    [SyncUpload AllData];
}

#pragma mark - Data uploading



@end
