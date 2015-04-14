//
//  Options_TableViewController.m
//  FameApp
//
//  Created by Eldar on 4/14/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Options_TableViewController.h"

@interface Options_TableViewController ()
@end

@implementation Options_TableViewController

@synthesize theTableView;
@synthesize userIdLabel, userEmailLabel, versionLabel;

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  // TODO: incomplete
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
                
            case 1:
                NSLog(@"email");
                break;
            case 2:
                NSLog(@"password");
                break;
            case 3:
                NSLog(@"logout");
                break;
        }
    }
    else {
        
        switch (indexPath.row) {
                
            case 0:
                NSLog(@"privacy");
                break;
            case 1:
                NSLog(@"terms");
                break;
            case 2:
                NSLog(@"about");
                break;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//#pragma mark - Alert Popup related
//- (void)showAreYouSurePopup:(UIButton *)aButton {
//    
//    BOOL isRePostButton = ((aButton.tag - TAG_ID__BUTTON_DELETE) < 0);
//    
//    // Generate content view to present
//    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
//    popupView.translatesAutoresizingMaskIntoConstraints = NO;
//    popupView.backgroundColor = [Colors_Modal getUIColorForMain_1];
//    popupView.layer.borderColor = [UIColor whiteColor].CGColor;
//    popupView.layer.borderWidth = 3.0;
//    popupView.layer.cornerRadius = 8.0;
//    popupView.tag = 666;
//    
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 300, 50)];
//    label1.text = (isRePostButton) ? @"Are you sure\nyou want to Re-Post?" : @"Are you sure\n you want to Delete?";
//    label1.textAlignment = NSTextAlignmentCenter;
//    label1.textColor = [UIColor whiteColor];
//    label1.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0];
//    label1.numberOfLines = 2;
//    [popupView addSubview:label1];
//    
//    // action buttons
//    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, 120, 40)];
//    noButton.backgroundColor = [Colors_Modal getUIColorForMain_7];
//    noButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
//    [noButton setTitle:@"No" forState:UIControlStateNormal];
//    [noButton addTarget:self action:@selector(noButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [popupView addSubview:noButton];
//    
//    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 90, 120, 40)];
//    yesButton.backgroundColor = (isRePostButton) ? [Colors_Modal getUIColorForMain_5] : [Colors_Modal getUIColorForMain_4];
//    yesButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
//    [yesButton setTitle:@"Yes" forState:UIControlStateNormal];
//    [yesButton setTag:aButton.tag];
//    
//    // bind Re-Post action
//    if (isRePostButton) {
//        
//        [yesButton addTarget:self action:@selector(rePostAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    // bind Delete action
//    else {
//        
//        [yesButton addTarget:self action:@selector(deletePostAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    [popupView addSubview:yesButton];
//    
//    
//    // Show in popup
//    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter);
//    
//    popup = [KLCPopup popupWithContentView:popupView
//                                  showType:(KLCPopupShowType)KLCPopupShowTypeBounceIn
//                               dismissType:(KLCPopupDismissType)KLCPopupDismissTypeBounceOutToTop
//                                  maskType:(KLCPopupMaskType)KLCPopupMaskTypeDimmed
//                  dismissOnBackgroundTouch:NO
//                     dismissOnContentTouch:NO];
//    
//    [popup showWithLayout:layout];
//}
//
//- (void)noButtonPressed:(UIButton *)aButton {
//    
//    [popup dismiss:YES];
//}
//
//- (void)rePostAction:(UIButton *)aButton {  // TODO: incomplete
//    
//    // TODO: need to bind the tag of the button with the right PostHistory object.
//    
//    NSLog(@"REPOST: %ld", (long)aButton.tag);
//    
//    [popup dismiss:YES];
//}

@end

