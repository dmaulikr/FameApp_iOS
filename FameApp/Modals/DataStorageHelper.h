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
#import "BiddingAndBonusInfo.h"

@interface DataStorageHelper : NSObject

+ (void)setupDB;

#pragma mark - UserInfo related
+ (UserInfo *)getLoginUserInfo;
/*!
 Sets/updates login user in the DB.
 And the param in AppDelegate.
 */
+ (void)setLoginUserInfo:(UserInfo *)aUser;
/*!
 Deletes login user in the DB.
 And the same goes for the param in AppDelegate.
 */
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

#pragma mark - BiddingAndBonusInfo related
/*!
 Adds a BiddingAndBonusInfo, for the currently login user.
 And also set the param in AppDelegate.
 */
+ (void)setBiddingAndBonusInfo:(BiddingAndBonusInfo *)aBiddingBonusInfo;
+ (BiddingAndBonusInfo *)getBiddingAndBonusInfo:(NSString *)userId;

@end

