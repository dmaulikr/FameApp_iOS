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

@synthesize continueButton;
@synthesize userIdField, passwordField;
@synthesize forgotPasswordLabel;
@synthesize popup;

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
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
    
    [userIdField resignFirstResponder];
    [passwordField resignFirstResponder];
    [[self.view viewWithTag:1000] setBackgroundColor:[UIColor whiteColor]];
    [[self.view viewWithTag:1001] setBackgroundColor:[UIColor whiteColor]];
    [continueButton setEnabled:NO];
    
    // TODO: incomplete
    
    // TODO: send to server to see if everything is OK.
    // TODO:    1. userId and password are correct.  (don't forget to attach '@' at the beginning of the userId, before sending to server)
    
    // TODO: the below is when the server retuns error on input verification:
    [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
    [[self.view viewWithTag:1001] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
    [self showStatusPopup:NO message:@"Wrong Username or Password"];  // TODO: message from server
    NSLog(@"CONTINUE");
    
    
    // TODO: if everything is OK:
    // TODO:    1. save to login UserInfo in the appDelegate.   (don't forget to add the '@' at the beginning of the userId)
    // TODO:    2. go to MAIN screen.
    
    
    UINavigationController *myNavigationController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MainNav"];
    [self presentViewController:myNavigationController animated:YES completion:nil];
    
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    
    [self initTextFields];
    [self initForgotPasswordLabel];
}

#pragma mark - Forgot Password label related
- (void)initForgotPasswordLabel {
    
    NSDictionary *labelAttributeStyle1 = @{
                                           @"body":@[ [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0], [Colors_Modal getUIColorForMain_7]],
                                           @"pass":[WPAttributedStyleAction styledActionWithAction:^{
                                               
                                               NSLog(@"FORGOT PASS LINK PRESSED");  // TODO: incomplete
                                               // TODO: need to decide:
                                               // TODO:     1. go with in app screen.
                                               // TODO:    OR
                                               // TODO:     2. go with a web page.
                                           }],
                                           @"link":@[ [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0], @{NSUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle|kCTUnderlinePatternSolid)}]
                                           };
    
    [forgotPasswordLabel setNumberOfLines:1];
    [forgotPasswordLabel setAttributedText:[@"<pass>Forgot your password?</pass>" attributedStringWithStyleBook:labelAttributeStyle1]];
    
    [self.view addSubview:forgotPasswordLabel];
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

