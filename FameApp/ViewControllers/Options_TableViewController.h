//
//  Options_TableViewController.h
//  FameApp
//
//  Created by Eldar on 4/14/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegueHelper_Modal.h"
#import <UINavigationItem+Loading.h>
#import "AFNetworking.h"
#import "AppVersionHelper.h"
#import "AppAPI_User_Modal.h"
#import "AppDelegate.h"
#import "KLCPopup.h"
#import "Colors_Modal.h"
#import "DataStorageHelper.h"
#import "UserInfo.h"
#import "TOWebViewController.h"

@interface Options_TableViewController : UITableViewController

@property (nonatomic, strong) AppDelegate *appDelegateInst;
@property (nonatomic, strong) IBOutlet UITableView *theTableView;
@property (nonatomic, strong) IBOutlet UILabel *userIdLabel;
@property (nonatomic, strong) IBOutlet UILabel *userEmailLabel;
@property (nonatomic, strong) IBOutlet UILabel *versionLabel;
@property (nonatomic, strong) KLCPopup *popup;

@end

