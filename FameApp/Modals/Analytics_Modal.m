//
//  Analytics_Modal.m
//  FameApp
//
//  Created by Eldar on 6/25/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Analytics_Modal.h"

@implementation Analytics_Modal

// TODO: track tutorial - when it's available


+ (void)trackScreen:(UIViewController *)targetSelf {
    
    NSString *screenName = [[NSStringFromClass([targetSelf class]) componentsSeparatedByString: @"_"] objectAtIndex:0];
    
    [[AppsFlyerTracker sharedTracker] trackEvent:screenName withValue:nil];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

@end

