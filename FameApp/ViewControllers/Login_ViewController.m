//
//  Login_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/20/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Login_ViewController.h"


@interface Login_ViewController ()
@end


@implementation Login_ViewController

@synthesize appDelegateInst;
@synthesize continueButton;
@synthesize userIdField, passwordField;
@synthesize forgotPasswordLabel;
@synthesize popup;

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [CustomSegueHelper_Modal setCustomBackButton:self];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    self.navigationItem.title = @"LOG IN";
    
    [self initSubViews];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [popup dismiss:NO];
}

- (IBAction)continueButtonPressed:(id)sender {
    
    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionRight];
    
    [userIdField resignFirstResponder];
    [passwordField resignFirstResponder];
    [[self.view viewWithTag:1000] setBackgroundColor:[UIColor whiteColor]];
    [[self.view viewWithTag:1001] setBackgroundColor:[UIColor whiteColor]];
    [continueButton setEnabled:NO];
    
    appDelegateInst.loginUser = nil;
    [DataStorageHelper deleteLoginUserInfo];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *userId = [NSString stringWithFormat:@"@%@", userIdField.text];
    NSString *deviceInfo = [DeviceTypeHelper getDeviceInfo];
    NSString *appVersion = [AppVersionHelper getAppVersion];
    NSString *notificationToken = [NotificationHelper getNotificationToken];
    
    NSArray *postReqInfo = [AppAPI_User_Modal requestContruct_LogIn:userId password:passwordField.text deviceInfo:deviceInfo appVersion:appVersion notificationToken:notificationToken];
    
    NSLog(@"App API - Request: LogIn");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSLog(@"App API - Reply: LogIn [SUCCESS]");
               
               NSDictionary *repDict = [AppAPI_User_Modal processReply_LogIn:responseObject];
               
               // Successful Login
               if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                   
                   appDelegateInst.loginUser = [[UserInfo alloc] init];
                   appDelegateInst.loginUser.userId = userId;
                   appDelegateInst.loginUser.userDisplayName = [repDict objectForKey:@"displayName"];
                   appDelegateInst.loginUser.userImageURL = [repDict objectForKey:@"imageUrl"];
                   appDelegateInst.loginUser.userEmail = [repDict objectForKey:@"email"];
                   appDelegateInst.loginUser.userToken = [repDict objectForKey:@"access_token"];
                   [DataStorageHelper setLoginUserInfo:appDelegateInst.loginUser];
                   
                   UINavigationController *myNavigationController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MainNav"];
                   [self presentViewController:myNavigationController animated:YES completion:nil];
               }
               // Bad Login
               else {
                   
                   [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
                   [[self.view viewWithTag:1001] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
                   
                   [self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
               }
               
              [self.navigationItem stopAnimating];
               
           } // End of Request 'Success'
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               [self.navigationItem stopAnimating];
               
               NSLog(@"App API - Reply: LogIn [FAILURE]");
               NSLog(@"%@", error);
               
               [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
               [continueButton setEnabled:YES];
               
           } // End of Request 'Failure'
     ];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    
    [self initTextFields];
    [self initForgotPasswordLabel];
}

#pragma mark - Forgot Password related
- (void)initForgotPasswordLabel {
    
    NSDictionary *labelAttributeStyle1 = @{
                                           @"body":@[ [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0], [Colors_Modal getUIColorForMain_7]],
                                           @"pass":[WPAttributedStyleAction styledActionWithAction:^{
                                               
                                               [self showWebPage:[appDelegateInst.webLinks objectForKey:@"FORGOT_PASSWORD"] title:@"FORGOT PASSWORD?"];
                                           }],
                                           @"link":@[ [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0], @{NSUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle|kCTUnderlinePatternSolid)}]
                                           };
    
    [forgotPasswordLabel setNumberOfLines:1];
    [forgotPasswordLabel setAttributedText:[@"<pass>Forgot your password?</pass>" attributedStringWithStyleBook:labelAttributeStyle1]];
}

- (void)showWebPage:(NSString *)url title:(NSString *)title {
    
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURLString:url];
    webViewController.title = title;
    webViewController.disableContextualPopupMenu = YES;
    webViewController.showPageTitles = NO;
    webViewController.showLoadingBar = NO;
    webViewController.showUrlWhileLoading = NO;
    webViewController.navigationButtonsHidden = YES;
    webViewController.showActionButton = NO;
    
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Text Fields related
- (void)initTextFields {
    
    [userIdField becomeFirstResponder];
    [userIdField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [passwordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)verifyIsAllValidInput {
    
    if (([userIdField.text isEqualToString:@""])
        || ([passwordField.text isEqualToString:@""])) {
        
        [continueButton setEnabled:NO];
    }
    else {
        
        [continueButton setEnabled:YES];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    [self verifyIsAllValidInput];
}

#pragma mark - Status Popup related
- (void)showStatusPopup:(BOOL)status message:(NSString *)message {
    
    // Generate content view to present
    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    popupView.translatesAutoresizingMaskIntoConstraints = NO;
    popupView.backgroundColor = (status) ? [Colors_Modal getUIColorForMain_5] : [Colors_Modal getUIColorForMain_4];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width-20, 35)];
    label1.text = message;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    label1.numberOfLines = 2;
    [popupView addSubview:label1];
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom);
    
    popup = [KLCPopup popupWithContentView:popupView
                                  showType:(KLCPopupShowType)KLCPopupShowTypeSlideInFromBottom
                               dismissType:(KLCPopupDismissType)KLCPopupDismissTypeSlideOutToBottom
                                  maskType:(KLCPopupMaskType)KLCPopupMaskTypeNone
                  dismissOnBackgroundTouch:NO
                     dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(dismissStatusPopup:) userInfo:nil repeats:NO];
}

- (void)dismissStatusPopup:(NSTimer *)aTimer {
    
    [popup dismiss:YES];
}

@end

