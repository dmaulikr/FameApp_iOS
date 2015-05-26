//
//  SignUp_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/19/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "SignUp_ViewController.h"
#import "Tutorial_ViewController.h"

int dt;

// TODO: should be ask for the SEX ?

@interface SignUp_ViewController ()
@end


@implementation SignUp_ViewController

@synthesize appDelegateInst;
@synthesize createNewUserButton;
@synthesize userIdField, emailField, passwordField, bdayField;
@synthesize termsLabel;
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
    self.navigationItem.title = @"SIGN UP";
    
    [self initSubViews];
    
    // TODO: DEBUG - REMOVE
//    Tutorial_ViewController *myViewController = [[Tutorial_ViewController alloc] init];
//    [self.navigationController pushViewController:myViewController animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [popup dismiss:NO];
}

- (IBAction)createNewUserButtonPressed:(id)sender {
    
    [self.navigationItem startAnimatingAt:ANNavBarLoaderPositionRight];
    
    [userIdField resignFirstResponder];
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
    [bdayField resignFirstResponder];
    [[self.view viewWithTag:999] setBackgroundColor:[UIColor whiteColor]];
    [[self.view viewWithTag:1000] setBackgroundColor:[UIColor whiteColor]];
    [[self.view viewWithTag:1001] setBackgroundColor:[UIColor whiteColor]];
    [[self.view viewWithTag:1002] setBackgroundColor:[UIColor whiteColor]];
    [createNewUserButton setEnabled:NO];
    
    appDelegateInst.loginUser = nil;
    [DataStorageHelper deleteLoginUserInfo];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSArray *bdayArray = @[ [NSNumber numberWithInteger:bdayField.day],
                            [NSNumber numberWithInteger:bdayField.month],
                            [NSNumber numberWithInteger:bdayField.year] ];
    NSString *userId = [NSString stringWithFormat:@"@%@", userIdField.text];
    
    NSArray *postReqInfo = [AppAPI_User_Modal requestContruct_SignUp:userId password:passwordField.text email:emailField.text bday:bdayArray];
    
    NSLog(@"App API - Request: SignUp");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSLog(@"App API - Reply: SignUp [SUCCESS]");
               
               NSDictionary *repDict = [AppAPI_User_Modal processReply_SignUp:responseObject];
               
               // Successful SignUp
               if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                   
                   appDelegateInst.loginUser = [[UserInfo alloc] init];
                   appDelegateInst.loginUser.userId = userId;
                   appDelegateInst.loginUser.userDisplayName = @"";
                   appDelegateInst.loginUser.userImageURL = @"";
                   appDelegateInst.loginUser.userEmail = emailField.text;
                   appDelegateInst.loginUser.userToken = [repDict objectForKey:@"access_token"];
                   [DataStorageHelper setLoginUserInfo:appDelegateInst.loginUser];
                   
//                   // show tutorial
//                   Tutorial_ViewController *myViewController = [[Tutorial_ViewController alloc] init];
//                   [self.navigationController pushViewController:myViewController animated:YES];
                   
                   // TODO: DEBUG - REMOVE
                   UINavigationController *myNavigationController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MainNav"];
                   [self presentViewController:myNavigationController animated:YES completion:nil];
               }
               // Bad SignUp
               else {
                   
                   NSString *errorField = [repDict objectForKey:@"errorField"];
                   
                   if ([errorField isEqualToString:@"userId"]) {
                       
                       [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
                   }
                   else if ([errorField isEqualToString:@"password"]) {
                       
                       [[self.view viewWithTag:1001] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
                   }
                   else if ([errorField isEqualToString:@"email"]) {
                       
                       [[self.view viewWithTag:1002] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
                   }
                   else if ([errorField isEqualToString:@"bday"]) {
                       
                       [[self.view viewWithTag:1003] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
                   }
                   
                   [self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
               }
               
              [self.navigationItem stopAnimating];
               
           } // End of Request 'Success'
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               [self.navigationItem stopAnimating];
               
               NSLog(@"App API - Reply: Signup [FAILURE]");
               NSLog(@"%@", error);
               
               [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
               [createNewUserButton setEnabled:YES];
               
           } // End of Request 'Failure'
     ];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    
    dt = [DeviceTypeHelper getDeviceType];
    if ((dt != IPHONE_4x) && (dt != IPHONE_5x)) {
        
        // don't auto show keyboard:
        // on iPhone4x & iPhone5x the keyboard opens over the Terms of Use.
        [userIdField becomeFirstResponder];
    }
    
    [self initTermsLabel];
    [self initTextFields];
    [self initBdayDatePicker];
}

#pragma mark - Terms & Privacy label related
- (void)initTermsLabel {
    
    NSDictionary *labelAttributeStyle1 = @{
                        @"body":@[ [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0], [Colors_Modal getUIColorForMain_7] ],
                        @"termsLink":[WPAttributedStyleAction styledActionWithAction:^{
                            
                            [self showWebPage:[appDelegateInst.webLinks objectForKey:@"TERMS_OF_USE"] title:@"TERMS OF USE"];
                        }],
                        @"privacyLink":[WPAttributedStyleAction styledActionWithAction:^{
                            
                            [self showWebPage:[appDelegateInst.webLinks objectForKey:@"PRIVACY_POLICY"] title:@"PRIVACY POLICY"];
                        }],
                        @"link":@[ [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0], @{NSUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle|kCTUnderlinePatternSolid)}]
                     };
    
    [termsLabel setTextAlignment:NSTextAlignmentJustified];
    [termsLabel setNumberOfLines:4];
    [termsLabel setAttributedText:[@"By tapping to create a new account, you are indicating that you agree to the <termsLink>Terms of Use</termsLink> and that you have read the <privacyLink>Privacy Policy</privacyLink>." attributedStringWithStyleBook:labelAttributeStyle1]];
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
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - Text Fields & Date Picker related
- (void)initTextFields {
    
    [emailField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [passwordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)initBdayDatePicker {
    
    bdayField.dropDownMode = IQDropDownModeDatePicker;
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd/MM/yyyy"];
    bdayField.dateFormatter = df;
    
    // Assign a minimum date and/or maximum date if you want
//    bdayField.minimumDate = [NSDate date];
    
    NVDate *myNVDate = [[NVDate alloc] initUsingToday];
    [myNVDate setYear:([myNVDate year] - 13)];
    bdayField.maximumDate = [myNVDate date];
}

- (void)verifyIsAllValidInput {
    
    if (([userIdField.text isEqualToString:@""])
        || ([emailField.text isEqualToString:@""])
        || ([passwordField.text isEqualToString:@""])
        || ([bdayField.text isEqualToString:@""])) {
        
        [createNewUserButton setEnabled:NO];
    }
    else {
        
        [createNewUserButton setEnabled:YES];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    [self verifyIsAllValidInput];
}

-(void)textField:(IQDropDownTextField*)textField didSelectItem:(NSString*)item {
    
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








