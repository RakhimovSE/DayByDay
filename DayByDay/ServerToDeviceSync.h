//
//  ServerToDeviceSync.h
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerToDeviceSync : NSObject

- (id)initWithLastSync:(NSDate *)lastSync;
- (void)syncAllData;

@end
