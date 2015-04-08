//
//  Main_ViewController.h
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors_Modal.h"
#import "DeviceTypeHelper.h"
#import "UIHelper.h"
#import "YCameraViewController.h"

@interface Main_ViewController : UIViewController <YCameraViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *contentView;
@property (nonatomic, strong) IBOutlet UIButton *niceButton;
@property (nonatomic, strong) IBOutlet UIButton *skipButton;
@property (nonatomic, strong) IBOutlet UIButton *bidPostButton;



@end
