//
//  Login_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/20/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
#import "Colors_Modal.h"
#import "DeviceTypeHelper.h"
#import "KLCPopup.h"

@interface Login_ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIBarButtonItem *continueButton;
@property (nonatomic, strong) IBOutlet UITextField *userIdField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet WPHotspotLabel *forgotPasswordLabel;
@property (nonatomic, strong) KLCPopup *popup;

@end

