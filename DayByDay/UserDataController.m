//
//  LoginDataController.m
//  DayByDay
//
//  Created by Admin on 03.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "UserDataController.h"
#import "Users.h"

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
    long responseCode;
    responseCode = [API performRequestAndGetResponseCode:params];
    if (responseCode != 200)
        [Constants showAlertMessage:@"Пользователь уже существует"];
    return responseCode == 200;
}

- (void)updateUserData:(NSMutableDictionary *)userDictionary
{
    NSError *error = nil;
    Users *user = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    
    user.user_id = (int)[[userDictionary valueForKey:@"user_id"][0] longValue];
    user.user_email = [userDictionary valueForKey:@"user_email"][0];
    user.user_password = [userDictionary valueForKey:@"user_password"][0];
    user.user_name = [userDictionary valueForKey:@"user_name"][0];
    //user.user_avatar = [users valueForKey:@"user_avatarPath"][0];
    user.user_energy = [[userDictionary valueForKey:@"user_energy"][0] doubleValue];
    user.user_score = (int)[[userDictionary valueForKey:@"user_score"][0] longValue];
    NSDate *user_registry = [API dateWithJSONString:[userDictionary valueForKey:@"user_registry"][0]];
    user.user_registry = [user_registry timeIntervalSinceReferenceDate];
    NSDate *user_updated = [API dateWithJSONString:[userDictionary valueForKey:@"user_updated"][0]];
    user.user_updated = [user_updated timeIntervalSinceReferenceDate];
    user.user_deleted = [[userDictionary valueForKey:@"user_deleted"][0] boolValue];
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSUInteger)getUserCount {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    return results.count;
}

@end
