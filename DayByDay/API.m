//
//  API.m
//  DayByDay
//
//  Created by Admin on 30.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "API.h"
#import "Constants.h"

@implementation API

+ (NSMutableDictionary *)performRequestAndGetResultAndResponseCode:(NSMutableDictionary *)params
{
    NSMutableDictionary *result;
    NSURLResponse *response;
    //Capturing server response
    NSData *data = [self getResponseData:params Response:&response];
    NSInteger *responseCode = [(NSHTTPURLResponse *)response statusCode];
    if (responseCode != 200) return nil;
    NSError *e;
    result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    [result setValue:[NSNumber numberWithLong:responseCode] forKey:@"responseCode"];
    return result;
}

+ (long)performRequestAndGetResponseCode:(NSMutableDictionary *)params
{
    NSMutableDictionary *result;
    result = [self performRequestAndGetResultAndResponseCode:params];
    return [[result valueForKey:@"responseCode"][0] longValue];
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

@end