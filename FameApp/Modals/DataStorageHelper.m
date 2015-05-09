//
//  DataStorageHelper.m
//  FameApp
//
//  Created by Eldar on 4/10/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "DataStorageHelper.h"

@implementation DataStorageHelper

+ (void)setupDB {
    
    [[SQPDatabase sharedInstance] setupDatabaseWithName:@"mydb_6.db"];  // TODO: this is not the final DB name
}

#pragma mark - UserInfo related
// there can be ONLY one user at every given time
+ (UserInfo *)getLoginUserInfo {
    
    return [UserInfo SQPFetchOne];
}

/*!
  Sets/updates login user in the DB.
  And the param in AppDelegate.
 */
+ (void)setLoginUserInfo:(UserInfo *)aUser {
    
    UserInfo *currentUser = [DataStorageHelper getLoginUserInfo];
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // login user doesn't exist in DB
    if (currentUser == nil) {
        
        currentUser = [UserInfo SQPCreateEntity];
    }
    
    currentUser.userId = aUser.userId;
    currentUser.userDisplayName = aUser.userDisplayName;
    currentUser.userImageURL = aUser.userImageURL;
    currentUser.userEmail = aUser.userEmail;
    currentUser.userToken = aUser.userToken;
    
    [currentUser SQPSaveEntity];
    
    appDelegateInst.loginUser = currentUser;
}

+ (void)deleteLoginUserInfo {
    
    UserInfo *user = [DataStorageHelper getLoginUserInfo];
    
    if (user != nil) {
        
        // delete existing login user
        user.deleteObject = YES;
        [user SQPSaveEntity];
    }
}


#pragma mark - PostHistory related
/*!
 Adds a PostHistory, for the currently login user.
 And creates a timestamp.
 */
+ (void)addPostHistory:(PostHistory *)aPost {
    
    UserInfo *loginUser = [DataStorageHelper getLoginUserInfo];
    if (loginUser != nil) {
        
        PostHistory *newPost = [PostHistory SQPCreateEntity];
        newPost.userId = loginUser.userId;
        newPost.timestamp = [[NSDate alloc] init];
        newPost.postId = aPost.postId;
        newPost.contentFileName = aPost.contentFileName;
        newPost.isPublished = aPost.isPublished;
        newPost.countViews = aPost.countViews;
        newPost.countNices = aPost.countNices;
        newPost.timerMSec = aPost.timerMSec;
        
        [newPost SQPSaveEntity];
    }
}

/*!
 Gets all PostHistory related to the currently login user.
 @return Mutable Array of PostHistory objects OR nil.
 */
+ (NSMutableArray *)getAllPostHistory {
    
    UserInfo *loginUser = [DataStorageHelper getLoginUserInfo];
    if (loginUser != nil) {
        
        NSString *query = [NSString stringWithFormat:@"userId = '%@'", loginUser.userId];
        return [PostHistory SQPFetchAllWhere:query orderBy:@"timestamp DESC"];
    }
    else {
        
        return nil;
    }
}

+ (PostHistory *)getPostHistory:(NSString *)postId {
    
    NSString *query = [NSString stringWithFormat:@"postId = '%@'", postId];
    return [PostHistory SQPFetchOneWhere:query];
}

+ (void)deletePostHistory:(NSString *)postId {
    
    PostHistory *aPost = [DataStorageHelper getPostHistory:postId];
    if (aPost != nil) {
        
        // delete a PostHistory entry
        aPost.deleteObject = YES;
        [aPost SQPSaveEntity];
    }
}


#pragma mark - BiddingAndBonusInfo related
/*!
 Adds a BiddingAndBonusInfo, for the currently login user.
 And also set the param in AppDelegate.
 */
+ (void)setBiddingAndBonusInfo:(BiddingAndBonusInfo *)aBiddingBonusInfo {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserInfo *loginUser = [DataStorageHelper getLoginUserInfo];
    BiddingAndBonusInfo *currentBiddingAndBonusInfo = [DataStorageHelper getBiddingAndBonusInfo:loginUser.userId];
    
    // first time entry for the currently login user
    if (currentBiddingAndBonusInfo == nil) {
        
        currentBiddingAndBonusInfo = [BiddingAndBonusInfo SQPCreateEntity];
    }
    
    currentBiddingAndBonusInfo.userId = loginUser.userId;
    currentBiddingAndBonusInfo.winningOdds = aBiddingBonusInfo.winningOdds;
    currentBiddingAndBonusInfo.bonusOdds = aBiddingBonusInfo.bonusOdds;
    currentBiddingAndBonusInfo.bonusForFriendInvite = aBiddingBonusInfo.bonusForFriendInvite;
    currentBiddingAndBonusInfo.bonusForShareToSN = aBiddingBonusInfo.bonusForShareToSN;
    
    [currentBiddingAndBonusInfo SQPSaveEntity];
    
    appDelegateInst.myBiddingAndBonusInfo = currentBiddingAndBonusInfo;
}

+ (BiddingAndBonusInfo *)getBiddingAndBonusInfo:(NSString *)userId {
    
    return [BiddingAndBonusInfo SQPFetchOneWhere:[NSString stringWithFormat:@"userId = '%@'", userId]];
}

@end








