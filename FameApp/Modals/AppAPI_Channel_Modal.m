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

@end

