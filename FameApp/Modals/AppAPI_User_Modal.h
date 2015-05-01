//
//  AppAPI_LogIn_Modal.h
//  FameApp
//
//  Created by Eldar on 4/24/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AppAPI_GeneralInfo_Modal.h"

@interface AppAPI_User_Modal : NSObject

#pragma mark - Sign Up
+ (NSArray *) requestContruct_SignUp:(NSString *)userId password:(NSString *)password email:(NSString *)email bday:(NSArray *)bday;
+ (NSDictionary *) processReply_SignUp:(NSDictionary *)responseObject;

#pragma mark - Log In
+ (NSArray *) requestContruct_LogIn:(NSString *)userId password:(NSString *)password deviceInfo:(NSString *)deviceInfo appVersion:(NSString *)appVersion notificationToken:(NSString *)notificationToken;
+ (NSDictionary *) processReply_LogIn:(NSDictionary *)responseObject;

#pragma mark - Log In Verify
+ (NSArray *) requestContruct_LogInVerify:(NSString *)deviceInfo appVersion:(NSString *)appVersion notificationToken:(NSString *)notificationToken;
+ (NSDictionary *) processReply_LogInVerify:(NSDictionary *)responseObject;

#pragma mark - Log Out
+ (NSArray *) requestContruct_LogOut;
+ (NSDictionary *) processReply_LogOut:(NSDictionary *)responseObject;

@end

