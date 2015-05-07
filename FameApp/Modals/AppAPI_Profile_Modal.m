//
//  AppAPI_Profile_Modal.m
//  FameApp
//
//  Created by Eldar on 5/6/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_Profile_Modal.h"

@implementation AppAPI_Profile_Modal

#pragma mark - Update Profile Image
+ (NSArray *) requestContruct_UpdateProfileImage:(NSString *)imageSizeInBytes {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"upload/profileImage";
    
    // prepare params
    NSString *reqData_dataSize = imageSizeInBytes;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictOnlyAccessToken_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_dataSize, @"data_size",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_UpdateProfileImage:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Update Display Name
+ (NSArray *) requestContruct_UpdateDisplayName:(NSString *)newDisplayName {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"profile/updateDisplayName";
    
    // prepare params
    NSString *reqData_newDisplayName = newDisplayName;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_newDisplayName, @"newDisplayName",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_UpdateDisplayName:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Deleted Post History
+ (NSArray *) requestContruct_DeletedPostHistory:(NSString *)postId {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"profile/deletedPostHistory";
    
    // prepare params
    NSString *reqData_postId = postId;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_postId, @"postId",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_DeletedPostHistory:(NSDictionary *)responseObject {
    
    return responseObject;
}

@end

