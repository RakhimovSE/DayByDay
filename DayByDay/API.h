//
//  API.h
//  DayByDay
//
//  Created by Admin on 30.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <Foundation/Foundation.h>

@interface API : NSObject

+ (NSMutableDictionary *)performRequestAndGetResultAndResponseCode:(NSMutableDictionary *)params ResponseCode:(NSNumber **)responseCode;
+ (long)performRequestAndGetResponseCode:(NSMutableDictionary *)params;

+ (NSMutableDictionary *)allValuesFromMutableDictionary:(NSMutableDictionary *)dictionary ForKey:(NSString *)keyKey Value:(NSString *)valueKey;

+ (NSString *)getSyncDateString:(NSDate *)date;
+ (NSDate *)dateFromMySqlString:(NSString *)dateString;
+ (NSString *)mySqlStringFromDate:(NSDate *)date;
+ (NSDate *)dateWithJSONString:(NSString *)dateStr;

@end
