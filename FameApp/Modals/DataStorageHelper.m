////
////  DataStorageHelper.m
////  FameApp
////
////  Created by Eldar on 4/10/15.
////  Copyright (c) 2015 FameApp. All rights reserved.
////
//
//#import "DataStorageHelper.h"
//
//@implementation DataStorageHelper
//
//+ (void)testCreate {
//    
//    [[AFSQLManager sharedManager]openLocalDatabaseWithName:@"testdb_WTF.sqlite" andStatusBlock:^(BOOL success, NSError *error) {
//        
//        [[AFSQLManager sharedManager]performQuery:
//         @"create table if not exists User(id INT PRIMARY KEY NOT NULL, userId TEXT, userDisplayName TEXT)" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
//             
//             [[AFSQLManager sharedManager]performQuery:
//              @"SELECT 1 FROM user LIMIT 1;" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
//                  
//                  NSLog(@"AA");
//              }];
//         }];
//    }];
//}
//
//+ (void)testAdd {
//    
//    NSLog(@"WTF");
//    // check if table exists
//    [[AFSQLManager sharedManager]performQuery:
//     @"SELECT 1 FROM user LIMIT 1;" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
//         
//         NSLog(@"TABLE CHECK");
//     }];
//    
////    NSLog(@"HERE 1");
////    [[AFSQLManager sharedManager]performQuery:
////     @"CREATE TABLE User(id INT PRIMARY KEY NOT NULL, userId TEXT, userDisplayName TEXT);" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
////         
////         NSLog(@"HERE 2");
////         
////         // Handle each row
////         [[AFSQLManager sharedManager]performQuery:@"INSERT INTO User (id, userId, userDisplayName) VALUES (2, '@number2', 'Number2');" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
////             
////             NSLog(@"HERE 3");
////             
////             [DataStorageHelper testGet];
////         }];
////     }];
//
////    [[AFSQLManager sharedManager]performQuery:@"INSERT INTO User (id, userId, userDisplayName) VALUES (1, '@number1', 'Number1');" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
////        
////        NSLog(@"HERE 3");
////        
//////        [DataStorageHelper testGet];
////    }];
//    
//}
//
//+ (void)testGet {
//
//    [[AFSQLManager sharedManager]performQuery:@"SELECT * FROM User" withBlock:^(NSArray *row, NSError *error, BOOL finished) {
//        
//        NSLog(@"XXX");
//        NSLog(@">> %@", error);
//        NSLog(@"<< %@", row);
//    }];
//}
//
//@end
//
