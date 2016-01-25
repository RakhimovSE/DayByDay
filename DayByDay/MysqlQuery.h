//
//  MysqlQuery.h
//  DayByDay
//
//  Created by Admin on 24.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MysqlDB;

@interface MysqlQuery : NSObject
{
    MysqlDB *db;
    NSMutableArray *rowsArray;
    NSInteger num_fields;
}
- (id)initWithDatabase:(MysqlDB *)dbase; // инициализатор на базе класса MysqlDB
- (void)execQuery; // выполнение запроса указанного в свойстве sql
- (NSInteger)recordCount; // кол-во строк, возвращенных после запроса
- (NSString *)stringValFromRow:(int)row Column:(int)col; // возвращает строковое значение из строки row и столбца col
- (NSInteger)integerValFromRow:(int)row Column:(int)col; // возвращает целочисленное значение из строки row и столбца col
- (double)doubleValFromRow:(int)row Column:(int)col; // возвращает дробное число из строки row и столбца col

@property (copy)NSString *sql;

@end