//
//  Profile_TableViewController.h
//  FameApp
//
//  Created by Eldar on 4/7/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors_Modal.h"
#import "DeviceTypeHelper.h"
#import "ABMenuTableViewCell.h"
#import "NSString+WPAttributedMarkup.h"

@interface Profile_TableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *labelAttributeStyle1;
@property (nonatomic, strong) IBOutlet UIImageView *userImageView;
@property (nonatomic, strong) IBOutlet UILabel *userDisplayNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;

@end
