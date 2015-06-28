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
    
    NSString *eventName = [[NSStringFromClass([targetSelf class]) componentsSeparatedByString: @"_"] objectAtIndex:0];
    
    [[AppsFlyerTracker sharedTracker] trackEvent:eventName withValue:nil];
}


//
//+ (void)preLoginScreen {
//    
//    [[AppsFlyerTracker sharedTracker] trackEvent:@"PreLogin" withValue:nil];
//}
//
//+ (void)signupScreen {
//    
//    [[AppsFlyerTracker sharedTracker] trackEvent:@"SignUp" withValue:nil];
//}
//
//+ (void)loginScreen {
//    
//    [[AppsFlyerTracker sharedTracker] trackEvent:@"Login" withValue:nil];
//}
//
//+ (void)mainScreen {
//    
//    [[AppsFlyerTracker sharedTracker] trackEvent:@"Main" withValue:nil];
//}
//
//+ (void)profileScreen {
//    
//    [[AppsFlyerTracker sharedTracker] trackEvent:@"Profile" withValue:nil];
//}

@end

