//
//  AppAPI_Invite_Modal.h
//  FameApp
//
//  Created by Eldar on 5/7/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AppAPI_GeneralInfo_Modal.h"

@interface AppAPI_Invite_Modal : NSObject

#pragma mark - Invite Bonus Info
+ (NSArray *) requestContruct_BonusInfo;
+ (NSDictionary *) processReply_BonusInfo:(NSDictionary *)responseObject;

#pragma mark - Friend Invited
/*!
 @param listOfInvitedFriends - Example: @[ @[@"full_name", @"phone_number", @"email_address"], ... ]
 */
+ (NSArray *) requestContruct_FriendInvited:(NSArray *)listOfInvitedFriends;
+ (NSDictionary *) processReply_FriendInvited:(NSDictionary *)responseObject;

@end

