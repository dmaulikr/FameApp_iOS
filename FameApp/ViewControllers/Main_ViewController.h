//
//  Main_ViewController.h
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Colors_Modal.h"
#import "DeviceTypeHelper.h"
#import "UIHelper.h"
#import "YCameraViewController.h"
#import "KKProgressTimer.h"
#import "KLCPopup.h"
#import "DLRadioButton.h"
#import "INTULocationManager.h"


@interface Main_ViewController : UIViewController <YCameraViewControllerDelegate, KKProgressTimerDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *userImageView;
@property (nonatomic, strong) IBOutlet UILabel *userDisplayName;
@property (nonatomic, strong) IBOutlet UIImageView *contentView;
@property (nonatomic, strong) IBOutlet UIButton *niceButton;
@property (nonatomic, strong) IBOutlet UIButton *skipButton;
@property (nonatomic, strong) IBOutlet UIButton *bidPostButton;
@property (nonatomic, strong) IBOutlet UILabel *oddsLabel;
@property (nonatomic, strong) IBOutlet UILabel *oddsBonusLabel;
@property (nonatomic, strong) IBOutlet UIButton *inviteFriendsButton;

@property (nonatomic, strong) KKProgressTimer *timerController;
@property (nonatomic) CGFloat timerPercentCount;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSInteger timerFinishSeconds;

@property (nonatomic, strong) KLCPopup* popup;
@property (nonatomic, strong) DLRadioButton *radio1;
@property (nonatomic, strong) KLCPopup* popupStatus;

@end

