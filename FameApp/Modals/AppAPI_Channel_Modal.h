//
//  AppAPI_Channel_Modal.h
//  FameApp
//
//  Created by Eldar on 5/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AppAPI_GeneralInfo_Modal.h"

@interface AppAPI_Channel_Modal : NSObject

#pragma mark - Channel Bidding Info
+ (NSArray *) requestContruct_BiddingInfo;
+ (NSDictionary *) processReply_BiddingInfo:(NSDictionary *)responseObject;

#pragma mark - Channel Get Content
+ (NSArray *) requestContruct_GetContent;
+ (NSDictionary *) processReply_GetContent:(NSDictionary *)responseObject;

@end

