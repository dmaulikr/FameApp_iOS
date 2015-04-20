//
//  Password_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/15/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Password_ViewController.h"

@interface Password_ViewController ()
@end

@implementation Password_ViewController

@synthesize saveButton;
@synthesize passwordCurrentTextField, passwordNewTextField;
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
    self.navigationItem.title = @"YOUR PASSWORD";
    
    [self initSubViews];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    [passwordCurrentTextField resignFirstResponder];
    [passwordNewTextField resignFirstResponder];
    [[self.view viewWithTag:1001] setBackgroundColor:[UIColor whiteColor]];
    [[self.view viewWithTag:1002] setBackgroundColor:[UIColor whiteColor]];
    [saveButton setEnabled:NO];
    
    // TODO: send to server
    
    // TODO: and show popup
    
    // TODO: incomplete
    
    
    // TODO: send to server to see if everything is OK.
    // TODO:    1. verify existing password is good.
    // TODO:    2. verify new password is by our standard.
    
    // TODO: the below is when the server retuns error on input verification:
    // TOOD: EXAMPLE:
    [[self.view viewWithTag:1001] setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
    [self showStatusPopup:NO message:@"Wrong Password !!"];  // TODO:  message from server
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    [(UILabel *)[self.view viewWithTag:1000] setTextColor:[Colors_Modal getUIColorForMain_1]];
    
    [self initTextFields];
}

#pragma mark - TextFields related
- (void)initTextFields {
    
    [passwordCurrentTextField becomeFirstResponder];
    [passwordCurrentTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [passwordNewTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)verifyIsAllValidInput {
    
    if (([passwordCurrentTextField.text isEqualToString:@""])
        || ([passwordNewTextField.text isEqualToString:@""])) {
        
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

