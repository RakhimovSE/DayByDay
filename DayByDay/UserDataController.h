//
//  LoginDataController.h
//  DayByDay
//
//  Created by Admin on 03.02.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DataController.h"

@interface UserDataController : DataController

- (BOOL)login:(NSString *)user_email Password:(NSString *)password;
- (BOOL)signup:(NSString *)email Password:(NSString *)password RepeatPassword:(NSString *)repeatPassword Name:(NSString *)name;
- (NSUInteger)getUserCount;

@end
