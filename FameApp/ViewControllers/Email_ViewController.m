//
//  Email_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/15/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Email_ViewController.h"

@interface Email_ViewController ()
@end

@implementation Email_ViewController

@synthesize appDelegateInst;
@synthesize saveButton;
@synthesize passwordCurrentTextField, emailNewTextField;
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
    self.navigationItem.title = @"YOUR EMAIL";
    
    [self initSubViews];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    [emailNewTextField resignFirstResponder];
    [[self.view viewWithTag:1001] setBackgroundColor:[UIColor whiteColor]];
    [[self.view viewWithTag:1002] setBackgroundColor:[UIColor whiteColor]];
    [saveButton setEnabled:NO];
    
    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionRight];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSArray *postReqInfo = [AppAPI_Options_Modal requestContruct_ChangeEmail:emailNewTextField.text currentPassword:passwordCurrentTextField.text];
    
    NSLog(@"App API - Request: Change Email");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSLog(@"App API - Reply: Change Email [SUCCESS]");
               
               NSDictionary *repDict = [AppAPI_Options_Modal processReply_ChangeEmail:responseObject];
               
               // Success - changing email address
               if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                   
                   // update locally stored login user's email address
                   appDelegateInst.loginUser.userEmail = emailNewTextField.text;
                   [DataStorageHelper setLoginUserInfo:appDelegateInst.loginUser];
                   
                   [self showStatusPopup:YES message:[repDict objectForKey:@"statusMsg"]];
               }
               // Error - changing email address
               else {
                   
                   NSString *errorField = [repDict objectForKey:@"errorField"];
                   
                   if ([errorField isEqualToString:@"password"]) {
                       
                       [[self.view viewWithTag:1001] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
                   }
                   else if ([errorField isEqualToString:@"newEmail"]) {
                       
                       [[self.view viewWithTag:1002] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
                   }
                   
                   [self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
               }
               
              [self.navigationItem stopAnimating];
               
           } // End of Request 'Success'
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               [self.navigationItem stopAnimating];
               
               NSLog(@"App API - Reply: Change Email [FAILURE]");
               NSLog(@"%@", error);
               
               [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
               [saveButton setEnabled:YES];
               
           } // End of Request 'Failure'
     ];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    [(UILabel *)[self.view viewWithTag:1000] setTextColor:[Colors_Modal getUIColorForMain_1]];
    
    [self initForgotPasswordLabel];
    [self initTextFields];
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

#pragma mark - TextFields related
- (void)initTextFields {
    
    [emailNewTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)verifyIsAllValidInput {
    
    if (([emailNewTextField.text isEqualToString:@""])
        || ([passwordCurrentTextField.text isEqualToString:@""])) {
        
        [saveButton setEnabled:NO];
    }
    else {
        
        [saveButton setEnabled:YES];
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
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(dismissStatusPopup:) userInfo:nil repeats:NO];
}

- (void)dismissStatusPopup:(NSTimer *)aTimer {

    [popup dismiss:YES];
}

@end

