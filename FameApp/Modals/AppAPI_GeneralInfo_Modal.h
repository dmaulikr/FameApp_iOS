//
//  AppAPI_GeneralInfo_Modal.h
//  FameApp
//
//  Created by Eldar on 4/30/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface AppAPI_GeneralInfo_Modal : NSObject

#pragma mark - General Request Info Dict: Full
+ (NSDictionary *) addGeneralRequestInfoDictFull_toRequestDict:(NSDictionary *)reqDict;
+ (NSDictionary *) getGeneralRequestInfoDictFull;

#pragma mark - General Request Info Dict: Only Access Token
+ (NSDictionary *) addGeneralRequestInfoDictOnlyAccessToken_toRequestDict:(NSDictionary *)reqDict;
+ (NSDictionary *) getGeneralRequestInfoDictOnlyAccessToken;

@end

