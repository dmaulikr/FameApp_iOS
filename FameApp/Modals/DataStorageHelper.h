//
//  DataStorageHelper.h
//  FameApp
//
//  Created by Eldar on 4/10/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "SQPersist.h"
#import "UserInfo.h"
#import "PostHistory.h"

@interface DataStorageHelper : NSObject

+ (void)setupDB;

#pragma mark - UserInfo related
+ (UserInfo *)getLoginUserInfo;
+ (void)setLoginUserInfo:(UserInfo *)aUser;
+ (void)deleteLoginUserInfo;

#pragma mark - PostHistory related
/*!
 Adds a PostHistory, for the currently login user.
 And creates a timestamp.
 */
+ (void)addPostHistory:(PostHistory *)aPost;
/*!
 Gets all PostHistory related to the currently login user.
 @return Mutable Array of PostHistory objects OR nil.
 */
+ (NSMutableArray *)getAllPostHistory;
+ (PostHistory *)getPostHistory:(NSString *)postId;
+ (void)deletePostHistory:(NSString *)postId;

@end

