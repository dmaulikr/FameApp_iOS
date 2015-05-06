//
//  AppAPI_Profile_Modal.h
//  FameApp
//
//  Created by Eldar on 5/6/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AppAPI_GeneralInfo_Modal.h"

@interface AppAPI_Profile_Modal : NSObject

#pragma mark - Update Profile Image
+ (NSArray *) requestContruct_UpdateProfileImage:(NSString *)imageSizeInBytes;
+ (NSDictionary *) processReply_UpdateProfileImage:(NSDictionary *)responseObject;

#pragma mark - Update Display Name
+ (NSArray *) requestContruct_UpdateDisplayName:(NSString *)newDisplayName;
+ (NSDictionary *) processReply_UpdateDisplayName:(NSDictionary *)responseObject;

@end

