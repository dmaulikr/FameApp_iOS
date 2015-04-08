//
//  Profile_TableViewController.m
//  FameApp
//
//  Created by Eldar on 4/7/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Profile_TableViewController.h"

const int TAG_ID__BUTTON_REPOST = 800000;
const int TAG_ID__BUTTON_DELETE = 900000;
const int CELL_HEIGHT__THE_VIEW = 170;
const int CELL_HEIGHT__THE_SEPARATOR = 10;
int dt;


// TODO: top on cell is the same as swipe left


@interface Profile_TableViewController ()
@end


@implementation Profile_TableViewController

@synthesize labelAttributeStyle1;
@synthesize userImageView, userDisplayNameLabel, usernameLabel;

- (void)didReceiveMemoryWarning {
 
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    self.navigationItem.title = @"YOU";
    
    [self initSubViews];
    [self initLabelAttributes];
}

#pragma mark - Subviews init by device type
- (void)initSubViews {
    
    [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    
    
    // TODO: display if the table is empty
//    // nothing to see label
//    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
//    UILabel *nothingToSeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-75, self.view.center.y-150, 150, 150)];
//    [nothingToSeeLabel setText:@"You haven't posted anything yet"];
//    [nothingToSeeLabel setNumberOfLines:2];
//    [nothingToSeeLabel setTextColor:[Colors_Modal getUIColorForMain_7]];
//    [nothingToSeeLabel setTextAlignment:NSTextAlignmentCenter];
//    [self.view addSubview:nothingToSeeLabel];
    
    dt = [DeviceTypeHelper getDeviceType];
    
    if (dt == IPHONE_6) {
        
        [self initSubViews_iPhone6];
    }
}

- (void)initSubViews_iPhone6 {  // TODO: incomplete
    
    //    [self.view viewWithTag:1000].frame = CGRectMake(5, 69, 365, 476);
    //    [self.view viewWithTag:1001].frame = CGRectMake(10, 57, 345, 336);
    //
    //    [self.view viewWithTag:2000].frame = CGRectMake(5, 544, 365, 122);
}

#pragma mark - Table View related
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (CELL_HEIGHT__THE_VIEW + CELL_HEIGHT__THE_SEPARATOR);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"ABMenuTableViewCell";
    ABMenuTableViewCell *cell = (ABMenuTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[ABMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // custom side menu view
    UIView *sideMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, CELL_HEIGHT__THE_VIEW)];
    UIView *sideMenuView_inside = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT__THE_SEPARATOR*1.5, 200, CELL_HEIGHT__THE_VIEW)];
    [sideMenuView addSubview:sideMenuView_inside];

    UIButton *buttonRepost = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    [buttonRepost addTarget:self action:@selector(buttonDelete_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonRepost setBackgroundColor:[Colors_Modal getUIColorForMain_5]];
    [buttonRepost.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:30]];
    [buttonRepost setTitle:@"Re-Post" forState:UIControlStateNormal];
    [buttonRepost setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonRepost setTag:(TAG_ID__BUTTON_REPOST + indexPath.row)];
    [sideMenuView_inside addSubview:buttonRepost];
    
    UIButton *buttonDelete = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 200, 50)];
    [buttonDelete addTarget:self action:@selector(buttonDelete_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonDelete.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    [buttonDelete setTitle:@"Delete" forState:UIControlStateNormal];
    [buttonDelete setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
    [buttonDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonDelete setTag:(TAG_ID__BUTTON_DELETE + indexPath.row)];
    [sideMenuView_inside addSubview:buttonDelete];
    
    cell.rightMenuView = sideMenuView;
    
    // view itself
    [cell.contentView setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    
    UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(CELL_HEIGHT__THE_SEPARATOR, CELL_HEIGHT__THE_SEPARATOR*1.5, tableView.bounds.size.width - CELL_HEIGHT__THE_SEPARATOR, CELL_HEIGHT__THE_VIEW)];
    [theView setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [cell.contentView addSubview:theView];
    
    // content image
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(theView.bounds.size.width - 160, 10, 150, 150)];
    [imageView setImage:[UIImage imageNamed:@"Tests_1"]];  // TODO: DEBUG
    [theView addSubview:imageView];
    
    // date
    int adjustment_smallDevice = ((dt==IPHONE_4x) || (dt==IPHONE_5x)) ? 20 : 0;
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x - 50, 10+adjustment_smallDevice, 40, 20)];
    [dateLabel setText:@"April 7"];
    [dateLabel setTextColor:[UIColor blackColor]];
    [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10]];
    [dateLabel setTextAlignment:NSTextAlignmentRight];
    [theView addSubview:dateLabel];
    
//    // win/lose status
//    UILabel *publishStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
//    [publishStatusLabel setText:@"NOT PUBLISHED"];
//    [publishStatusLabel setTextColor:[Colors_Modal getUIColorForMain_4]];
//    [publishStatusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20]];
//    [theView addSubview:publishStatusLabel];
//    
//    // message for 'not published'
//    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, theView.center.y/2+10, imageView.frame.origin.x - 20, 50)];
//    [msgLabel setNumberOfLines:2];
//    [msgLabel setAttributedText:[@"Want to try again?\n      <bold>⇐ Swipe left</bold>" attributedStringWithStyleBook:labelAttributeStyle1]];
//    [theView addSubview:msgLabel];
    
    // win/lose status
    UILabel *publishStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
    [publishStatusLabel setText:@"PUBLISHED"];
    [publishStatusLabel setTextColor:[UIColor blackColor]];
    [publishStatusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:22]];
    [theView addSubview:publishStatusLabel];
    
    // ranking info
    UILabel *rankingSeenCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, imageView.frame.origin.x - 20, 50)];
    [rankingSeenCountLabel setNumberOfLines:2];
    [rankingSeenCountLabel setAttributedText:[@"Seen by <number>100,000</number>." attributedStringWithStyleBook:labelAttributeStyle1]];
    [theView addSubview:rankingSeenCountLabel];
    
    UILabel *rankingNiceCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, imageView.frame.origin.x - 20, 50)];
    [rankingNiceCountLabel setNumberOfLines:2];
    [rankingNiceCountLabel setAttributedText:[@"<green><number>10,000</number></green> people loved it!!" attributedStringWithStyleBook:labelAttributeStyle1]];
    [theView addSubview:rankingNiceCountLabel];
    
    return cell;
}

- (void)buttonRepost_Pressed:(UIButton *)aButton {  // TODO: incomplete
    
    NSLog(@"REPOST: %ld", (long)aButton.tag);
}

- (void)buttonDelete_Pressed:(UIButton *)aButton {  // TODO: incomplete
    
    NSLog(@"DELETE: %ld", (long)aButton.tag);
}

#pragma mark - Label Attribute related
- (void)initLabelAttributes {
    
    labelAttributeStyle1 = @{ @"body":[UIFont fontWithName:@"HelveticaNeue-Light" size:15],
                              @"number":[UIFont fontWithName:@"HelveticaNeue-Bold" size:25],
                              @"green":[Colors_Modal getUIColorForMain_5],
                              @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:15] };
}

@end


