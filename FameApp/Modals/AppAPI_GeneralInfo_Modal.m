//
//  AppAPI_GeneralInfo_Modal.m
//  FameApp
//
//  Created by Eldar on 4/30/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_GeneralInfo_Modal.h"

@implementation AppAPI_GeneralInfo_Modal

#pragma mark - General Request Info Dict: Full
+ (NSDictionary *) addGeneralRequestInfoDictFull_toRequestDict:(NSDictionary *)reqDict {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // prepare params
    NSString *reqData_accessToken = appDelegateInst.loginUser.userToken;
    NSString *reqData_geoLon = [[NSNumber numberWithDouble:[appDelegateInst.lastLocation coordinate].longitude] stringValue];
    NSString *reqData_geoLat = [[NSNumber numberWithDouble:[appDelegateInst.lastLocation coordinate].latitude] stringValue];
    
    NSMutableDictionary *retDict = [reqDict mutableCopy];
    [retDict setObject:reqData_accessToken forKey:@"access_token"];
    [retDict setObject:reqData_geoLon forKey:@"geoLon"];
    [retDict setObject:reqData_geoLat forKey:@"geoLat"];
    
    return (NSDictionary *)retDict;
}

+ (NSDictionary *) getGeneralRequestInfoDictFull {
    
    return [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:[[NSDictionary alloc] init]];
}

#pragma mark - General Request Info Dict: Only Access Token
+ (NSDictionary *) addGeneralRequestInfoDictOnlyAccessToken_toRequestDict:(NSDictionary *)reqDict {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // prepare params
    NSString *reqData_accessToken = appDelegateInst.loginUser.userToken;
    
    NSMutableDictionary *retDict = [reqDict mutableCopy];
    [retDict setObject:reqData_accessToken forKey:@"access_token"];
    
    return (NSDictionary *)retDict;
}

+ (NSDictionary *) getGeneralRequestInfoDictOnlyAccessToken {
    
    return [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictOnlyAccessToken_toRequestDict:[[NSDictionary alloc] init]];
}

@end

