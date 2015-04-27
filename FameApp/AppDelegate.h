//
//  AppDelegate.h
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStorageHelper.h"
#import "UserInfo.h"
#import "Colors_Modal.h"
#import "INTULocationManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSString *appAPIBaseURL;
@property (nonatomic, strong) NSDictionary *webLinks;
@property (nonatomic, strong) UserInfo *loginUser;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic) BOOL isAfterLogin;

@end

