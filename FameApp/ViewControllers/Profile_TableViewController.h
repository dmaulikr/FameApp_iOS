//
//  Profile_TableViewController.h
//  FameApp
//
//  Created by Eldar on 4/7/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegueHelper_Modal.h"
#import "AFNetworking.h"
#import "AppAPI_Profile_Modal.h"
#import "YCameraViewController.h"
#import "ABMenuTableViewCell.h"
#import "NSString+WPAttributedMarkup.h"
#import "KLCPopup.h"
#import "Colors_Modal.h"
#import "DeviceTypeHelper.h"
#import "ImageStorageHelper.h"
#import "DataStorageHelper.h"
#import "PostHistory.h"
#import "FormattingHelper.h"
#import "UIHelper.h"

@interface Profile_TableViewController : UITableViewController <UITextFieldDelegate, YCameraViewControllerDelegate>

@property (nonatomic, strong) AppDelegate *appDelegateInst;
@property (nonatomic, strong) NSDictionary *labelAttributeStyle1;
@property (nonatomic, strong) IBOutlet UIImageView *userImageView;
@property (nonatomic, strong) IBOutlet UITextField *userDisplayNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *userIdLabel;
@property (nonatomic, strong) IBOutlet UITableView *postsTableView;
@property (nonatomic, strong) NSMutableArray *postsHistoryList;
@property (nonatomic, strong) KLCPopup *popup;

@end

