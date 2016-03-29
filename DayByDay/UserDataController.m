//
//  LoginDataController.m
//  DayByDay
//
//  Created by Admin on 03.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "UserDataController.h"

@interface UserDataController ()

@end

@implementation UserDataController

NSString *const className = @"UserAPI";

- (BOOL)login:(NSString *)email Password:(NSString *)password
{
    email = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    password = [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (email.length == 0 || password.length == 0)
    {
        [Constants showAlertMessage:@"Введите логин и пароль"];
        return NO;
    }
    
    NSString *methodName = @"login";
    NSNumber *responseNumber = [[NSNumber alloc] init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                  className, @"className",
                                                 methodName, @"methodName",
                                    [email lowercaseString], @"user_email",
                                   [Constants md5:password], @"user_password", nil];
    NSMutableDictionary *result;
    result = [API performRequestAndGetResultAndResponseCode:params ResponseCode:&responseNumber];
    long responseCode = [responseNumber longValue];
    
    if (responseCode != 200) {
        [Constants showAlertMessage:[NSString stringWithFormat:@"Error %li", responseCode] Title:@"Ошибка авторизации"];
        return NO;
    }
    [self updateUserData:result];
    return YES;
}

- (BOOL)signup:(NSString *)email Password:(NSString *)password RepeatPassword:(NSString *)repeatPassword Name:(NSString *)name
{
    if (![password isEqualToString:repeatPassword]) {
        [Constants showAlertMessage:@"Пароли не совпадают"];
        return NO;
    }
    NSString *methodName = @"signup";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                  className, @"className",
                                                 methodName, @"methodName",
                                    [email lowercaseString], @"user_email",
                                   [Constants md5:password], @"user_password",
                                                       name, @"user_name", nil];
    NSInteger *responseCode;
    responseCode = [API performRequestAndGetResponseCode:params];
    if (responseCode != 200)
        [Constants showAlertMessage:@"Пользователь уже существует"];
    return responseCode == 200;
}

- (void)updateUserData:(NSMutableDictionary *)dictionary
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];

    NSManagedObject *user_id = [results objectAtIndex:0];
    [user_id setValue:[dictionary valueForKey:@"user_id"][0] forKey:@"user_id"];
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
