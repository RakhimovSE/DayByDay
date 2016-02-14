//
//  API.h
//  DayByDay
//
//  Created by Admin on 30.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface API : NSObject

+ (NSMutableDictionary *)performRequestAndGetResultAndResponseCode:(NSMutableDictionary *)params ResponseCode:(NSNumber **)responseCode;
+ (long)performRequestAndGetResponseCode:(NSMutableDictionary *)params;

@end
