//
//  MysqlDB.m
//  DayByDay
//
//  Created by Admin on 24.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "MysqlDB.h"

@implementation MysqlDB

@synthesize socket;
@synthesize serverName;
@synthesize dbName;
@synthesize port;
@synthesize userName;
@synthesize password;
@synthesize mysql;

- (id)init
{
    self = [super init];
    if (self) {
        if (mysql_library_init(0, NULL, NULL)) {
            NSLog(@"База данных не подключена");
            return nil;
        }
    }
    return self;
}

- (void)finalize
{
    mysql_library_end();
}

- (void)connect
{
    mysql = mysql_init(NULL);
    const char *params[5] = {
        socket ? socket.UTF8String : NULL,
        serverName ? serverName.UTF8String : NULL,
        dbName ? dbName.UTF8String : NULL,
        userName ? userName.UTF8String : "root",
        password ? password.UTF8String : ""
    };
    if (!port) port = 3306;
    if (!mysql_real_connect(mysql, params[1], params[3], params[4], params[2], port, params[0], 0))
        [self mysqlError];
    // при использовании UTF-8
    if (mysql_set_character_set(mysql, "utf8"))
        [self mysqlError];
}

- (void)mysqlError
{
    const char *ch = mysql_error(mysql);
    if (ch) {
        lastError = [NSString stringWithUTF8String:ch];
        if (lastError.length) {
            NSLog(@"Ошибка подключения: %@", lastError);
            NSException *ex = [NSException exceptionWithName:@"Error MySQL database" reason:lastError userInfo:nil];
            @throw ex;
        }
    }
}

- (void)disconnect
{
    if (mysql) {
        mysql_close(mysql);
        mysql = nil;
    }
}

- (NSString *)r_escape:(NSString *)s
{
    NSInteger len = [s lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (len) {
        NSInteger l = (len << 1) + 2; // максимально возможная длина в UTF-8
        char toch[l];
        char *to = toch;
        memset(to, 0, l);
        mysql_real_escape_string(mysql, to, s.UTF8String, len);
        return [NSString stringWithUTF8String:to];
    }
    return s;
}

- (NSInteger)autoincrementID
{
    NSInteger result = mysql_insert_id(mysql);
    return result;
}

- (BOOL)connected
{
    if (mysql_stat(mysql))
        return YES;
    else
        return NO;
}

- (void) errorMessage
{
    /*
    if(lastError){
        UIAlertView* alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"MySQL error"];
        [alert setInformativeText:lastError];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
        lastError = nil;
    }
  */
}

@end