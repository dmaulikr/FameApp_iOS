//
//  AppDelegate.m
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

@synthesize appAPIBaseURL, appAPIBaseUploaderURL;
@synthesize webLinks;
@synthesize loginUser;
@synthesize lastLocation;
@synthesize myBiddingAndBonusInfo;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    appAPIBaseURL = @"http://thefameapp.co:8080/FameApp/api/";
    appAPIBaseUploaderURL = @"http://thefameapp.co:8080/Uploader/api/";
    
//    appAPIBaseURL = @"http://10.0.0.10:8080/FameApp/api/";
//    appAPIBaseUploaderURL = @"http://10.0.0.10:8080/Uploader/api/";
    
    webLinks = [[NSDictionary alloc] initWithObjectsAndKeys:
                @"http://thefameapp.co/terms?app", @"TERMS_OF_USE",
                @"http://thefameapp.co/privacy?app", @"PRIVACY_POLICY",
                @"http://thefameapp.co/forgot?app", @"FORGOT_PASSWORD",
                @"http://thefameapp.co/licenses?app", @"LICENSES",
                nil];
    
    // global UI appearance
    [[UINavigationBar appearance] setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    [[UINavigationBar appearance] setTintColor:[Colors_Modal getUIColorForNavigationBar_tintColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            [Colors_Modal getUIColorForNavigationBar_tintColor], NSForegroundColorAttributeName,
                                                            [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:22.0], NSFontAttributeName, nil]];
    [UIActivityIndicatorView appearanceWhenContainedIn:[UINavigationBar class], nil].color = [Colors_Modal getUIColorForNavigationBar_tintColor];
    
    // connect to local DB
    [DataStorageHelper setupDB];
    
    
    /* Init AppsFlyer Analytics */
    
    [AppsFlyerTracker sharedTracker].appleAppID = @"1000219460";
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = @"fQ27trRPBoYrNJcqx8ib3j";
    
    // (optional) uncomment the following line to set a user id used by your app:
    // [[AppsFlyerTracker sharedTracker].customerUserID = myAppsUserId];
    
    
    /* Init Google Analytics */
    
    // Configure tracker from GoogleService-Info.plist.
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    // Optional: configure GAI options.
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
    gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // track launch - It's VERY important that this code will be located in the applicationDidBecomeActive of your app delegate!
    [[AppsFlyerTracker sharedTracker] trackAppLaunch]; //***** THIS LINE IS MANDATORY *****
    
    // (Optional) to get AppsFlyer's attribution data you can use AppsFlyerTrackerDelegate as follow . Note that the callback will fail as long as the appleAppID and developer key are not set properly.
    [AppsFlyerTracker sharedTracker].delegate = self; //Delegate methods below
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma AppsFlyerTrackerDelegate methods
- (void) onConversionDataReceived:(NSDictionary*) installData {
    
    id status = [installData objectForKey:@"af_status"];
    if([status isEqualToString:@"Non-organic"]) {
        
        id sourceID = [installData objectForKey:@"media_source"];
        id campaign = [installData objectForKey:@"campaign"];
        NSLog(@"This is a none organic install.");
        NSLog(@"Media source: %@",sourceID);
        NSLog(@"Campaign: %@",campaign);
    }
    else if([status isEqualToString:@"Organic"]) {
        
        NSLog(@"This is an organic install.");
    }
}

- (void) onConversionDataRequestFailure:(NSError *)error {
    
    NSLog(@"Failed to get data from AppsFlyer's server: %@",[error localizedDescription]);
}

@end

