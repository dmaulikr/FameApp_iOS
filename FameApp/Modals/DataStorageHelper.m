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
    
    [[SQPDatabase sharedInstance] setupDatabaseWithName:@"mydb_1.db"];  // TODO: this is not the final DB name
}

#pragma mark - UserInfo related
// there can be ONLY one user at every given time
+ (UserInfo *)getLoginUserInfo {
    
    return [UserInfo SQPFetchOne];
}

+ (void)setLoginUserInfo:(UserInfo *)aUser {
    
    UserInfo *existingUser = [DataStorageHelper getLoginUserInfo];
    
    // update existing user
    if (existingUser != nil) {
        
        existingUser.userId = aUser.userId;
        existingUser.userDisplayName = aUser.userDisplayName;
        existingUser.userImageURL = aUser.userImageURL;
        
        [existingUser SQPSaveEntity];
    }
    // insert new user
    else {
        
        UserInfo *newUser = [UserInfo SQPCreateEntity];
        newUser.userId = aUser.userId;
        newUser.userDisplayName = aUser.userDisplayName;
        newUser.userImageURL = aUser.userImageURL;
        
        [newUser SQPSaveEntity];
    }
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
        
        [newPost SQPSaveEntity];
    }
}

/*!
 Gets all PostHistory related to the currently login user.
 @return Mutable Array of PostHistory objects OR nil.
 */
+ (NSMutableArray *)getAllPostHistory {
    
    // TODO: reverse the order: new -> old
    
    UserInfo *loginUser = [DataStorageHelper getLoginUserInfo];
    if (loginUser != nil) {
        
        NSString *query = [NSString stringWithFormat:@"userId = '%@'", loginUser.userId];
        return [PostHistory SQPFetchAllWhere:query];
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


@end

