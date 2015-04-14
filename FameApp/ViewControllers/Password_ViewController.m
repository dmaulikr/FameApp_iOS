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
    
    // TODO: send to server
    
    // TODO: and show popup
    [self showPopup:@"MESSAGE FROM SERVER"];  // TODO:
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    [(UILabel *)[self.view viewWithTag:1000] setTextColor:[Colors_Modal getUIColorForMain_1]];
    
    [passwordCurrentTextField becomeFirstResponder];
}

#pragma mark - Alert Popup related
- (void)showPopup:(NSString *)messageFromServer {

    // Generate content view to present
    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    popupView.translatesAutoresizingMaskIntoConstraints = NO;
    popupView.backgroundColor = [Colors_Modal getUIColorForMain_1];
    popupView.layer.borderColor = [UIColor whiteColor].CGColor;
    popupView.layer.borderWidth = 3.0;
    popupView.layer.cornerRadius = 8.0;
    popupView.tag = 666;

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 300, 60)];
    label1.text = messageFromServer;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    label1.numberOfLines = 2;
    [popupView addSubview:label1];

    // action buttons
    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 90, 120, 40)];
    noButton.backgroundColor = [Colors_Modal getUIColorForMain_7];
    noButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    [noButton setTitle:@"OK" forState:UIControlStateNormal];
    [noButton addTarget:self action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:noButton];

    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter);

    popup = [KLCPopup popupWithContentView:popupView
                                  showType:(KLCPopupShowType)KLCPopupShowTypeBounceIn
                               dismissType:(KLCPopupDismissType)KLCPopupDismissTypeBounceOutToTop
                                  maskType:(KLCPopupMaskType)KLCPopupMaskTypeDimmed
                  dismissOnBackgroundTouch:NO
                     dismissOnContentTouch:NO];

    [popup showWithLayout:layout];
}

- (void)okButtonPressed:(UIButton *)aButton {

    [popup dismiss:YES];
}


@end

