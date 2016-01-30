//
//  API.h
//  DayByDay
//
//  Created by Admin on 30.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject

- (NSMutableDictionary *)getRequestResult:(NSMutableDictionary *)params;
- (void)test:(NSMutableDictionary *)params;

@end
