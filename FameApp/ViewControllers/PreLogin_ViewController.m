//
//  PreLogin_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/20/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "PreLogin_ViewController.h"


@interface PreLogin_ViewController ()
@end


@implementation PreLogin_ViewController

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self initSubViews];
    [self verifyLogin];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    
    [((UIButton *)[self.view viewWithTag:1001]) setBackgroundColor:[Colors_Modal getUIColorForMain_8]];
    [((UIButton *)[self.view viewWithTag:1001]) setHidden:YES];
    [((UIButton *)[self.view viewWithTag:1002]) setBackgroundColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    [((UIButton *)[self.view viewWithTag:1002]) setHidden:YES];
}

- (void)showButtons {
    
    [((UIButton *)[self.view viewWithTag:1001]) setAlpha:0.0f];
    [((UIButton *)[self.view viewWithTag:1001]) setHidden:NO];
    
    [((UIButton *)[self.view viewWithTag:1002]) setAlpha:0.0f];
    [((UIButton *)[self.view viewWithTag:1002]) setHidden:NO];
    
    [UIView animateWithDuration:1.0f animations:^{
        
        [((UIButton *)[self.view viewWithTag:1001]) setAlpha:1.0f];
        [((UIButton *)[self.view viewWithTag:1002]) setAlpha:1.0f];
        
    } completion:^(BOOL finished) {
    }];
}

- (void)verifyLogin {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserInfo *loginUser = [DataStorageHelper getLoginUserInfo];
    
    // no login user
    if (loginUser == nil) {
        
        [self showButtons];
    }
    // login user found.
    // verify it.
    else {
        
        appDelegateInst.loginUser = loginUser;
        
        AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
        operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSString *deviceInfo = [DeviceTypeHelper getDeviceInfo];
        NSString *appVersion = [AppVersionHelper getAppVersion];
        NSString *notificationToken = [NotificationHelper getNotificationToken];
        
        NSArray *postReqInfo = [AppAPI_User_Modal requestContruct_LogInVerify:deviceInfo appVersion:appVersion notificationToken:notificationToken];
        
        NSLog(@"App API - Request: LogIn Verify");
        [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"App API - Reply: LogIn Verify [SUCCESS]");
                   
                   NSDictionary *repDict = [AppAPI_User_Modal processReply_LogInVerify:responseObject];
                   
                   // Successful Login Verify
                   if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                       
                       appDelegateInst.loginUser.userId = loginUser.userId;
                       appDelegateInst.loginUser.userDisplayName = [repDict objectForKey:@"displayName"];
                       appDelegateInst.loginUser.userImageURL = [repDict objectForKey:@"imageUrl"];
                       appDelegateInst.loginUser.userEmail = [repDict objectForKey:@"email"];
                       appDelegateInst.loginUser.userToken = [repDict objectForKey:@"access_token"];
                       [DataStorageHelper setLoginUserInfo:appDelegateInst.loginUser];
                       
                       UINavigationController *myNavigationController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MainNav"];
                       [self presentViewController:myNavigationController animated:YES completion:nil];
                   }
                   // Bad Login Verify
                   else {
                       
                       appDelegateInst.loginUser = nil;
                       [DataStorageHelper deleteLoginUserInfo];
                       
                       [self showButtons];
                   }
                   
               } // End of Request 'Success'
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   [self showButtons];
                   
                   NSLog(@"App API - Reply: LogIn Verify [FAILURE]");
                   NSLog(@"%@", error);
                   
               } // End of Request 'Failure'
         ];
    }
}

@end

