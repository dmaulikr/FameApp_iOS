//
//  SignUp_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/19/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "AppDelegate.h"
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
#import "IQDropDownTextField.h"
#import "Colors_Modal.h"
#import "DeviceTypeHelper.h"
#import "KLCPopup.h"
#import "TOWebViewController.h"

@interface SignUp_ViewController : UIViewController <IQDropDownTextFieldDelegate, UITextFieldDelegate>

@property (nonatomic, strong) AppDelegate *appDelegateInst;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *createNewUserButton;
@property (nonatomic, strong) IBOutlet UITextField *userIdField;
@property (nonatomic, strong) IBOutlet UITextField *emailField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet IQDropDownTextField *bdayField;
@property (nonatomic, strong) IBOutlet WPHotspotLabel *termsLabel;
@property (nonatomic, strong) KLCPopup *popup;

@end

