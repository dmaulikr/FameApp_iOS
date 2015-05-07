//
//  AppAPI_Options_Modal.m
//  FameApp
//
//  Created by Eldar on 5/4/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_Options_Modal.h"

@implementation AppAPI_Options_Modal

#pragma mark - Change Email
+ (NSArray *) requestContruct_ChangeEmail:(NSString *)newEmail currentPassword:(NSString *)currentPassword {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"options/changeEmail";
    
    // prepare params
    NSString *reqData_password = currentPassword;
    NSString *reqData_newEmail = newEmail;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_password, @"password",
                                 reqData_newEmail, @"newEmail",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_ChangeEmail:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Change Password
+ (NSArray *) requestContruct_ChangePassword:(NSString *)newPassword currentPassword:(NSString *)currentPassword {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"options/changePassword";
    
    // prepare params
    NSString *reqData_password = currentPassword;
    NSString *reqData_newPassword = newPassword;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_password, @"password",
                                 reqData_newPassword, @"newPassword",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_ChangePassword:(NSDictionary *)responseObject {
    
    return responseObject;
}

@end

