//
//  AppAPI_Post_Modal.m
//  FameApp
//
//  Created by Eldar on 5/6/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_Post_Modal.h"

@implementation AppAPI_Post_Modal

#pragma mark - Post Image
+ (NSArray *) requestContruct_PostImage:(NSString *)imageSizeInBytes {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseUploaderURL];
    NSString *reqPath = @"/upload/postImage";
    
    // prepare params
    NSString *reqData_dataSize = imageSizeInBytes;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictOnlyAccessToken_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_dataSize, @"data_size",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_PostImage:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Post Info
+ (NSArray *) requestContruct_PostInfo:(NSString *)imageURL timer:(int)timer {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"submit/postInfo";
    
    // prepare params
    NSString *reqData_imageURL = imageURL;
    NSNumber *reqData_timer = [[NSNumber alloc] initWithInt:timer];
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_imageURL, @"imageUrl",
                                 reqData_timer, @"timer",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_PostInfo:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Post Status
+ (NSArray *) requestContruct_PostStatus:(NSString *)postId {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"submit/postStatus";
    
    // prepare params
    NSString *reqData_postId = postId;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_postId, @"imageUrl",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_PostStatus:(NSDictionary *)responseObject {
    
    return responseObject;
}

@end

