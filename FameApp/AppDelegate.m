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
    appAPIBaseUploaderURL = @"http://thefameapp.co:8080/Uploader/api/";  //54.171.157.215
    
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
    
    // connect to DB
    [DataStorageHelper setupDB];
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

