//
//  API.m
//  DayByDay
//
//  Created by Admin on 30.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "API.h"
#import "Constants.h"
#import <AFNetworking.h>
#import <CoreData/CoreData.h>
#import "DataController.h"

@implementation API

+ (NSMutableDictionary *)performRequestAndGetResultAndResponseCode:(NSMutableDictionary *)params ResponseCode:(NSNumber **)responseCode
{
    NSMutableDictionary *result;
    NSURLResponse *response;
    //Capturing server response
    NSData *data = [self getResponseData:params Response:&response];
    NSInteger responseInteger = [(NSHTTPURLResponse *)response statusCode];
    *responseCode = [NSNumber numberWithInteger:responseInteger];
    if (responseInteger != 200) return nil;
    NSError *e;
    result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    return result;
}

+ (long)performRequestAndGetResponseCode:(NSMutableDictionary *)params
{
    NSMutableDictionary *result;
    NSNumber *number = [[NSNumber alloc] init];
    result = [self performRequestAndGetResultAndResponseCode:params ResponseCode:&number];
    return [number longValue];
}

+ (NSData *)getResponseData:(NSMutableDictionary *)params Response:(NSURLResponse **)response
{
    //    We begin by creating our POST's body (ergo. what we'd like to send) as an NSString, and converting it to NSData.
    NSString *post = [self convertPostToString:params];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //    Next up, we read the postData's length, so we can pass it along in the request.
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    //    Now that we have what we'd like to post, we can create an NSMutableURLRequest, and include our postData.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:apiURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    // синхронный запрос
    NSError *error = nil;
    
    //Capturing server response
    NSData *data = [NSURLConnection sendSynchronousRequest:request  returningResponse:response error:&error];
    return data;
}

+ (NSString *)convertPostToString:(NSMutableDictionary *)dictionary
{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSString *key in dictionary) {
        NSString *value = [dictionary valueForKey:key];
        if ([result length] > 0)
            [result appendString:@"&"];
        [result appendFormat:@"%@=%@", key, value];
    }
    return [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSMutableDictionary *)allValuesFromMutableDictionary:(NSMutableDictionary *)dictionary ForKey:(NSString *)keyKey Value:(NSString *)valueKey {
    NSArray *values = [dictionary valueForKey:valueKey];
    NSArray *keys = [dictionary valueForKey:keyKey];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys];
    return result;
}

+ (NSDate *)dateWithJSONString:(NSString *)dateString
{
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDate *date = [dateFormat dateFromString:dateString];
    return date;
}

+ (NSDate *)mySqlStringToDate:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss'"];
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)dateToMySqlString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss'"];
    return [dateFormatter stringFromDate:date];
}

@end