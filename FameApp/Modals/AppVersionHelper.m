//
//  AppVersionHelper.m
//  FameApp
//
//  Created by Eldar on 5/1/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppVersionHelper.h"

@implementation AppVersionHelper

+ (NSString *)getAppVersion {
    
    return [NSString stringWithFormat:@"%@",
            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
}

@end

