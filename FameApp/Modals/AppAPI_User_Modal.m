//
//  AppAPI_User_Modal.m
//  FameApp
//
//  Created by Eldar on 4/24/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_User_Modal.h"

@implementation AppAPI_User_Modal

#pragma mark - Sign Up
/*!
 @param bday - An array of NSNumber. Values order: day,month,year.
 */
+ (NSArray *) requestContruct_SignUp:(NSString *)userId password:(NSString *)password email:(NSString *)email bday:(NSArray *)bday {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"user/signup";
    
    // prepare params
    NSString *reqData_userId = userId;
    NSString *reqData_password = password;
    NSString *reqData_email = email;
    NSDictionary *reqData_bday = @{ @"day" : [bday objectAtIndex:0],
                                    @"month" : [bday objectAtIndex:1],
                                    @"year" : [bday objectAtIndex:2]
                                  };
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                reqData_userId, @"userId",
                                reqData_password, @"password",
                                reqData_email, @"email",
                                reqData_bday, @"bday",
                                nil];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_SignUp:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Log In
+ (NSArray *) requestContruct_LogIn:(NSString *)userId password:(NSString *)password deviceInfo:(NSString *)deviceInfo appVersion:(NSString *)appVersion notificationToken:(NSString *)notificationToken {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"user/login";
    
    // prepare params
    NSString *reqData_userId = userId;
    NSString *reqData_password = password;
    NSString *reqData_deviceInfo = deviceInfo;
    NSString *reqData_appVersion = appVersion;
    NSString *reqData_notificationToken = notificationToken;
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                reqData_userId, @"userId",
                                reqData_password, @"password",
                                reqData_deviceInfo, @"deviceInfo",
                                reqData_appVersion, @"appVersion",
                                reqData_notificationToken, @"notificationToken",
                                nil];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_LogIn:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Log In Verify
+ (NSArray *) requestContruct_LogInVerify:(NSString *)deviceInfo appVersion:(NSString *)appVersion notificationToken:(NSString *)notificationToken {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"user/loginVerify";
    
    // prepare params
    NSString *reqData_deviceInfo = deviceInfo;
    NSString *reqData_appVersion = appVersion;
    NSString *reqData_notificationToken = notificationToken;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictOnlyAccessToken_toRequestDict:
                                 [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_deviceInfo, @"deviceInfo",
                                 reqData_appVersion, @"appVersion",
                                 reqData_notificationToken, @"notificationToken",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_LogInVerify:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Log Out
+ (NSArray *) requestContruct_LogOut {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"user/logout";
    
    // prepare params
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal getGeneralRequestInfoDictOnlyAccessToken];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_LogOut:(NSDictionary *)responseObject {
    
    return responseObject;
}

@end

