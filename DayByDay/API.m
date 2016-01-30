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

- (NSMutableDictionary *)getRequestResult:(NSMutableDictionary *)params
{
    __block NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
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
    //    And finally, we can send our request, and read the reply by creating a new NSURLSession:
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200)
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSError *e;
                result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            });
    }] resume];
    
    return result;
}

- (void)test:(NSMutableDictionary *)params
{
    __block NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
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
    //    And finally, we can send our request, and read the reply by creating a new NSURLSession:
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        NSLog(@"status: %ld", statusCode);
        if (statusCode == 200)
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *e;
                result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
                NSLog(@"%@", result);
            });
    }] resume];
}

- (NSString *)convertPostToString:(NSMutableDictionary *)array
{
    NSString *result = @"";
    for (NSString *key in array) {
        NSString *value = [array valueForKey:key];
        if ([result isEqualToString:@""])
            result = [NSString stringWithFormat:@"%@=%@", key, value];
        else
            result = [NSString stringWithFormat:@"%@&%@=%@", result, key, value];
    }
    return result;
}

@end