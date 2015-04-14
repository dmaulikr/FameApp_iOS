//
//  Options_TableViewController.h
//  FameApp
//
//  Created by Eldar on 4/14/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors_Modal.h"
#import "DataStorageHelper.h"
#import "UserInfo.h"

@interface Options_TableViewController : UITableViewController

@property (nonatomic, strong) IBOutlet UITableView *theTableView;
@property (nonatomic, strong) IBOutlet UILabel *userIdLabel;
@property (nonatomic, strong) IBOutlet UILabel *userEmailLabel;
@property (nonatomic, strong) IBOutlet UILabel *versionLabel;

@end

