//
//  ContentEdit_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/2/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegueHelper_Modal.h"
#import <UINavigationItem+Loading.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AppAPI_Post_Modal.h"
#import "IQLabelView.h"
#import "DeviceTypeHelper.h"
#import "ImageStorageHelper.h"
#import "PostHistory.h"
#import "FormattingHelper.h"
#import "KLCPopup.h"
#import "Post_ViewController.h"

@interface ContentEdit_ViewController : UIViewController <IQLabelViewDelegate>

@property (nonatomic, readwrite, copy) UIImage *image;
@property (nonatomic, strong) AppDelegate *appDelegateInst;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IQLabelView *currentlyEditingLabel;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) KLCPopup *popup;
@property (nonatomic, strong) PostHistory *currentPost;

@end

