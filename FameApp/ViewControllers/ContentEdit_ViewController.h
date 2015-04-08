//
//  ContentEdit_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/2/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "IQLabelView.h"
#import "DeviceTypeHelper.h"

@interface ContentEdit_ViewController : UIViewController <IQLabelViewDelegate>

@property (nonatomic, readwrite, copy) UIImage *image;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IQLabelView *currentlyEditingLabel;
@property (nonatomic, strong) NSMutableArray *labels;

@end