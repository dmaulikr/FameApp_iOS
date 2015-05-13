//
//  AppAPI_Channel_Modal.m
//  FameApp
//
//  Created by Eldar on 5/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_Channel_Modal.h"

@implementation AppAPI_Channel_Modal

#pragma mark - Channel Bidding Info
+ (NSArray *) requestContruct_BiddingInfo {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"channel/biddingInfo";
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal getGeneralRequestInfoDictFull];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_BiddingInfo:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Channel Get Content
+ (NSArray *) requestContruct_GetContent {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"channel/getContent";
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal getGeneralRequestInfoDictFull];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_GetContent:(NSDictionary *)responseObject {
    
    return responseObject;
}

#pragma mark - Channel Skip
+ (NSArray *) requestContruct_Skip:(NSString *)postId timerPoint:(long)timerPoint actionType:(int)actionType {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"channel/skip";
    
    NSString *reqData_postId = postId;
    NSNumber *reqData_timerPoint = [[NSNumber alloc] initWithLong:timerPoint];
    NSNumber *reqData_actionType = [[NSNumber alloc] initWithInt:actionType];
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_postId, @"postId",
                                 reqData_timerPoint, @"timerPoint",
                                 reqData_actionType, @"actionType",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_Skip:(NSDictionary *)responseObject {
    
    return responseObject;
}

@end

