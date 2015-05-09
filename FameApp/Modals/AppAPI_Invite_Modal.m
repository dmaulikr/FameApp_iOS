//
//  AppAPI_Invite_Modal.m
//  FameApp
//
//  Created by Eldar on 5/7/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_Invite_Modal.h"

@implementation AppAPI_Invite_Modal

#pragma mark - Invite Bonus Info
+ (NSArray *) requestContruct_BonusInfo {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"invite/bonusInfo";
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal getGeneralRequestInfoDictFull];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_BonusInfo:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Friend Invited
/*!
 @param listOfInvitedFriends - Example: @[ @[@"full_name", @"phone_number", @"email_address"], ... ]
 */
+ (NSArray *) requestContruct_FriendInvited:(NSArray *)listOfInvitedFriends {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"invite/friendInvited";
    
    // prepare params
    NSMutableArray *reqData_friendsList = [[NSMutableArray alloc] init];
    for (int i=0; i<[listOfInvitedFriends count]; i++) {
        
        NSArray *aFriend = [listOfInvitedFriends objectAtIndex:i];
        
        NSDictionary *friendInfoObj = @{ @"friendFullName" : [aFriend objectAtIndex:0],
                                         @"friendPhoneNumber": [aFriend objectAtIndex:1],
                                         @"friendEmail": [aFriend objectAtIndex:2]
                                       };
        
        [reqData_friendsList addObject:friendInfoObj];
    }
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_friendsList, @"friendsList",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_FriendInvited:(NSDictionary *)responseObject {
    
    return responseObject;
}

@end

