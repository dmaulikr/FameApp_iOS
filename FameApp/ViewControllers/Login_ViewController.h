//
//  Login_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/20/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UINavigationItem+Loading.h>
#import <CoreText/CoreText.h>
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
#import "AppDelegate.h"
#import "AppAPI_User_Modal.h"
#import "AFNetworking.h"
#import "AppVersionHelper.h"
#import "NotificationHelper.h"
#import "Colors_Modal.h"
#import "DeviceTypeHelper.h"
#import "FormattingHelper.h"
#import "KLCPopup.h"
#import "TOWebViewController.h"

@interface Login_ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) AppDelegate *appDelegateInst;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *continueButton;
@property (nonatomic, strong) IBOutlet UITextField *userIdField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet WPHotspotLabel *forgotPasswordLabel;
@property (nonatomic, strong) KLCPopup *popup;

@end

