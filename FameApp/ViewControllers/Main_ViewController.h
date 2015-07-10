//
//  Main_ViewController.h
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Analytics_Modal.h"
#import "Colors_Modal.h"
#import "DeviceTypeHelper.h"
#import "PlaceholderImageHelper.h"
#import "UIHelper.h"
#import "URLHelper.h"
#import "YCameraViewController.h"
#import "KKProgressTimer.h"
#import "KLCPopup.h"
#import "DLRadioButton.h"
#import "INTULocationManager.h"
#import "AFNetworking.h"
#import "AppAPI_Channel_Modal.h"
#import "AppAPI_Report_Modal.h"
#import "DKQueue.h"
#import "UIView+MaterialDesign.h"
#import "UIGestureRecognizer+SHGestureRecognizerBlocks.h"
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"


@interface Main_ViewController : UIViewController <YCameraViewControllerDelegate, KKProgressTimerDelegate, UITextViewDelegate>

@property (nonatomic, strong) AppDelegate *appDelegateInst;

@property (nonatomic) NSInteger appTimeOffset;
@property (nonatomic, strong) DKQueue *contentQueue_1;
@property (nonatomic, strong) DKQueue *contentQueue_2;
@property (nonatomic) BOOL isMainQueue_1;

@property (nonatomic, strong) NSDictionary *labelAttributeStyle1;
@property (nonatomic, strong) NSString *currentContent_postId;

@property (nonatomic, strong) UIView *colorSplashView;
@property (nonatomic, strong) IBOutlet UIImageView *userImageView;
@property (nonatomic, strong) IBOutlet UILabel *userInfoLabel;
@property (nonatomic, strong) IBOutlet UIImageView *contentImageView;
@property (nonatomic, strong) IBOutlet UIButton *niceButton;
@property (nonatomic, strong) IBOutlet UIButton *skipButton;
@property (nonatomic, strong) IBOutlet UIButton *bidPostButton;
@property (nonatomic, strong) IBOutlet UILabel *oddsLabel;
@property (nonatomic, strong) IBOutlet UILabel *oddsBonusLabel;
@property (nonatomic, strong) IBOutlet UIButton *inviteFriendsButton;
@property (nonatomic, strong) IBOutlet WPHotspotLabel *inviteFriendsLabelAction;

@property (nonatomic, strong) KKProgressTimer *timerController;
@property (nonatomic) CGFloat timerPercentCount;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSInteger timerFinishSeconds;
@property (nonatomic) BOOL isReachedTimerOnLastMoments;
@property (nonatomic) int reasonToShowNextContent;
@property (nonatomic) int seenTimeBeforeSkipped_mSec;

@property (nonatomic, strong) KLCPopup* popup;
@property (nonatomic, strong) DLRadioButton *radio1;
@property (nonatomic, strong) UITextView *reportMsgField;
@property (nonatomic, strong) KLCPopup* popupStatus;

@end

