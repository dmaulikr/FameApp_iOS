//
//  AppAPI_Post_Modal.h
//  FameApp
//
//  Created by Eldar on 5/6/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppAPI_GeneralInfo_Modal.h"

@interface AppAPI_Post_Modal : NSObject

#pragma mark - Post Image
+ (NSArray *) requestContruct_PostImage:(NSString *)imageSizeInBytes;
+ (NSDictionary *) processReply_PostImage:(NSDictionary *)responseObject;

#pragma mark - Post Info
+ (NSArray *) requestContruct_PostInfo:(NSString *)imageURL timer:(int)timer;
+ (NSDictionary *) processReply_PostInfo:(NSDictionary *)responseObject;

#pragma mark - Post Status
+ (NSArray *) requestContruct_PostStatus:(NSString *)postId;
+ (NSDictionary *) processReply_PostStatus:(NSDictionary *)responseObject;

@end

