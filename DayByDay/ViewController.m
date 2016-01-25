//
//  ViewController.m
//  DayByDay
//
//  Created by Admin on 18.01.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "ViewController.h"
#import "MysqlDB.h"
#import "MysqlQuery.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"I'm gonna push this to GitHub!");
}

- (void)connectToDatabase {
    MysqlDB *db = [[MysqlDB alloc] init];
    db.serverName = @"west2-mysql-instance1.cjs5oc0gdd8y.us-west-2.rds.amazonaws.com";
    db.dbName = @"DayByDay";
    db.userName = @"rakhimovse";
    db.password = @"sNa2RdNKtx7vMq";
    db.port = 3306;
    @try{
        [db connect];
        MysqlQuery *q = [[MysqlQuery alloc]initWithDatabase:db];
        q.sql = @"select * from table1 order by id";
        [q execQuery];
        NSInteger len = q.recordCount;
        for(NSInteger i=0;i<len;i++){
            NSInteger id1 = [q integerValFromRow:i Column:0];
            NSString *stringV1 = [q stringValFromRow:i Column:1];
            NSLog([NSString stringWithFormat:@"id: %li, text: %@", (long)id1, stringV1]);
        }
    }
    @catch (NSException *exception) {
        // ...
        [db errorMessage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
