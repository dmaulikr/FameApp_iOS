//
//  Options_TableViewController.m
//  FameApp
//
//  Created by Eldar on 4/14/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Options_TableViewController.h"

// TODO: need to connect screens:
// TODO:    1. Privacy --> do the same way as in the SIGN UP screen
// TODO:    2. Terms   --> do the same way as in the SIGN UP screen

@interface Options_TableViewController ()
@end

@implementation Options_TableViewController

@synthesize theTableView;
@synthesize userIdLabel, userEmailLabel, versionLabel;
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
    self.navigationItem.title = @"OPTIONS";
    
    [self initSubViews];
}

- (void)initSubViews {
    
    UserInfo *loginUser = [DataStorageHelper getLoginUserInfo];
    [userIdLabel setText:loginUser.userId];
    [userEmailLabel setText:loginUser.userEmail];
    
    [versionLabel setText:[NSString stringWithFormat:@"%@",
     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]];
    
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
}

#pragma mark - Table View related
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // logout
    if ((indexPath.section == 0) && (indexPath.row == 3)) {
        
        [self showPopup_logout];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Alert Popup related
- (void)showPopup_logout {
    
    // Generate content view to present
    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    popupView.translatesAutoresizingMaskIntoConstraints = NO;
    popupView.backgroundColor = [Colors_Modal getUIColorForMain_1];
    popupView.layer.borderColor = [UIColor whiteColor].CGColor;
    popupView.layer.borderWidth = 3.0;
    popupView.layer.cornerRadius = 8.0;
    popupView.tag = 666;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 300, 60)];
    label1.text = @"Are you sure sure\nyou want to leave? :(";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    label1.numberOfLines = 2;
    [popupView addSubview:label1];
    
    // action buttons
    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, 120, 40)];
    noButton.backgroundColor = [Colors_Modal getUIColorForMain_7];
    noButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    [noButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [noButton addTarget:self action:@selector(cancelLogoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:noButton];
    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 90, 120, 40)];
    yesButton.backgroundColor = [Colors_Modal getUIColorForMain_4];
    yesButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    [yesButton setTitle:@"Log Out" forState:UIControlStateNormal];
    [yesButton addTarget:self action:@selector(yesLogoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:yesButton];
    
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

- (void)yesLogoutButtonPressed:(UIButton *)aButton {
    
    [popup dismiss:YES];
    
    // TODO: send to server.
    // TODO: go to Login Screen
}

- (void)cancelLogoutButtonPressed:(UIButton *)aButton {
    
    [popup dismiss:YES];
}

@end

