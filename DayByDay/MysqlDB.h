//
//  MysqlDB.h
//  DayByDay
//
//  Created by Admin on 24.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mysql.h"

@interface MysqlDB : NSObject
{
    MYSQL *mysql;
    NSString *lastError;
}

- (void)connect; // Соединение с БД
- (void)mysqlError; // Вывод ошибки в консоль и сохранение в *lastError
- (void)disconnect; // Отключение от БД
- (NSString *)r_escape: (NSString *)s; // Экранирование символов для SQL запросов
- (NSInteger)autoincrementID; // Получение последнего значения вставки Autoincrement
- (BOOL)connected; // Тест на соединение
- (void)errorMessage; // Вывод на экран NSAlert с последней ошибкой

@property (copy)NSString *socket;
@property (copy)NSString *serverName;
@property (copy)NSString *dbName;
@property NSInteger port;
@property (copy)NSString *userName;
@property (copy)NSString *password;
@property (readonly)MYSQL *mysql;

@end
