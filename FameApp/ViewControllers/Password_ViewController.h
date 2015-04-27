//
//  Password_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/15/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
#import "Colors_Modal.h"
#import "KLCPopup.h"

@interface Password_ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, strong) IBOutlet UITextField *passwordCurrentTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordNewTextField;
@property (nonatomic, strong) IBOutlet WPHotspotLabel *forgotPasswordLabel;
@property (nonatomic, strong) KLCPopup *popup;

@end

