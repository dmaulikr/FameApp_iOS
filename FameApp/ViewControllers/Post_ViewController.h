//
//  Post_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/28/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "AppDelegate.h"
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
#import "ZCSlotMachine.h"
#import "L360ConfettiArea.h"
#import "GraphView.h"
#import "Colors_Modal.h"
#import "NSString+WPAttributedMarkup.h"
#import "KKProgressTimer.h"
#import "PostHistory.h"
#import "FormattingHelper.h"
#import "AFNetworking.h"
#import "AppAPI_Post_Modal.h"
#import "DeviceTypeHelper.h"


@interface Post_ViewController : UIViewController <ZCSlotMachineDelegate, ZCSlotMachineDataSource, KKProgressTimerDelegate>

@property (nonatomic, readwrite, copy) UIImage *contentImage;
@property (nonatomic, readwrite, copy) PostHistory *currentPost;

@property (nonatomic, strong) AppDelegate *appDelegateInst;

@property (nonatomic) BOOL isWin;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *closeButton;

@property (nonatomic, strong) NSTimer *sampleTimer_postStatus;
@property (nonatomic, strong) IBOutlet UIView *biddingView;
@property (nonatomic, strong) ZCSlotMachine *mySlotMachine;
@property (nonatomic, strong) NSArray *slotIcons;
@property (nonatomic, strong) IBOutlet UILabel *winningOddsLabel;
@property (nonatomic, strong) IBOutlet UILabel *bonusOddsLabel;

@property (nonatomic) BOOL isBeingPublished;
@property (nonatomic, strong) IBOutlet UIView *winView;
@property (nonatomic, strong) IBOutlet UILabel *winHeaderLabel;
@property (nonatomic, strong) IBOutlet UIImageView *winImageView;
@property (nonatomic, strong) GraphView *winGraphView;
@property (nonatomic, strong) IBOutlet UILabel *winGraphViewsLabel;
@property (nonatomic, strong) IBOutlet UILabel *winGraphNicesLabel;
@property (nonatomic, strong) NSDictionary *labelAttributeStyle1;
@property (nonatomic, strong) KKProgressTimer *winTimerController;
@property (nonatomic) CGFloat winTimerPercentCount;
@property (nonatomic, strong) NSTimer *winTimer;
@property (nonatomic) NSInteger winTimerFinishSeconds;
@property (nonatomic) int sampleCount;

@property (nonatomic) CGFloat bonusPoints;
@property (nonatomic, strong) IBOutlet WPHotspotLabel *loseLabel;
@property (nonatomic, strong) IBOutlet WPHotspotLabel *loseWantMoreLabel;

@end

