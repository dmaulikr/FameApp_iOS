//
//  AppAPI_Options_Modal.h
//  FameApp
//
//  Created by Eldar on 5/4/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AppAPI_GeneralInfo_Modal.h"

@interface AppAPI_Options_Modal : NSObject

#pragma mark - Change Email
+ (NSArray *) requestContruct_ChangeEmail:(NSString *)newEmail currentPassword:(NSString *)currentPassword;
+ (NSDictionary *) processReply_ChangeEmail:(NSDictionary *)responseObject;

#pragma mark - Change Password
+ (NSArray *) requestContruct_ChangePassword:(NSString *)newPassword currentPassword:(NSString *)currentPassword;
+ (NSDictionary *) processReply_ChangePassword:(NSDictionary *)responseObject;

@end

