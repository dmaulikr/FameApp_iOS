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


// TODO: tap on cell is the same as swipe left.

// TODO: BUG - Swipe right issue: https://github.com/alexbumbu/ABMenuTableViewCell/issues/1


@interface Profile_TableViewController ()
@end


@implementation Profile_TableViewController

@synthesize labelAttributeStyle1;
@synthesize userImageView, userDisplayNameLabel, userIdLabel;
@synthesize postsTableView, postsHistoryList;
@synthesize popup;

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
    
    [self initTableView];
}

#pragma mark - Subviews init by device type
- (void)initSubViews {
    
    // TODO: set userId, display name, and load from ImageURL
    UserInfo *loginUser = [DataStorageHelper getLoginUserInfo];
    [userDisplayNameLabel setText:loginUser.userDisplayName];
    [userIdLabel setText:loginUser.userId];
    // TODO: set user's 'imageURL' (with cache!! and maybe fade-in animation)
    
    [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    [postsTableView setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    
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
- (void)initTableView {
    
    postsHistoryList = [DataStorageHelper getAllPostHistory];
    [postsTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // show posts
    if ([postsHistoryList count] > 0) {
        
        return [postsHistoryList count] + 1;
    }
    // nothing to see
    else {
        
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < [postsHistoryList count]) {
        
        return (CELL_HEIGHT__THE_VIEW + CELL_HEIGHT__THE_SEPARATOR);
    }
    else {
        
        return CELL_HEIGHT__THE_VIEW / 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // show posts
    if ([postsHistoryList count] > 0) {
        
        // regular cell
        if (indexPath.row < [postsHistoryList count]) {
            
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
            [buttonRepost addTarget:self action:@selector(showAreYouSurePopup:) forControlEvents:UIControlEventTouchUpInside];
            [buttonRepost setBackgroundColor:[Colors_Modal getUIColorForMain_5]];
            [buttonRepost.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:30]];
            [buttonRepost setTitle:@"Re-Post" forState:UIControlStateNormal];
            [buttonRepost setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buttonRepost setTag:(TAG_ID__BUTTON_REPOST + indexPath.row)];
            [sideMenuView_inside addSubview:buttonRepost];
            
            UIButton *buttonDelete = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 200, 50)];
            [buttonDelete addTarget:self action:@selector(showAreYouSurePopup:) forControlEvents:UIControlEventTouchUpInside];
            [buttonDelete.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
            [buttonDelete setTitle:@"Delete" forState:UIControlStateNormal];
            [buttonDelete setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
            [buttonDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buttonDelete setTag:(TAG_ID__BUTTON_DELETE + indexPath.row)];
            [sideMenuView_inside addSubview:buttonDelete];
            
            cell.rightMenuView = sideMenuView;
            
            // view itself
            [cell.contentView setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
            
            UIView *theView = theView = [[UIView alloc] initWithFrame:CGRectMake(CELL_HEIGHT__THE_SEPARATOR, CELL_HEIGHT__THE_SEPARATOR*1.5, tableView.bounds.size.width - CELL_HEIGHT__THE_SEPARATOR, CELL_HEIGHT__THE_VIEW)];
            [theView setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
            [cell.contentView addSubview:theView];
            
            PostHistory *aPost = [postsHistoryList objectAtIndex:indexPath.row];
            
            // content image
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(theView.bounds.size.width - 160, 10, 150, 150)];
            [imageView setImage:[ImageStorageHelper loadImageFromLocalDirectory:aPost.contentFileName]];
            [theView addSubview:imageView];
            
            // date
            int adjustment_smallDevice = ((dt==IPHONE_4x) || (dt==IPHONE_5x)) ? 20 : 0;
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x - 50, 10+adjustment_smallDevice, 40, 20)];
            [dateLabel setText:[FormattingHelper formatDateString:aPost.timestamp]];
            [dateLabel setTextColor:[UIColor blackColor]];
            [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10]];
            [dateLabel setTextAlignment:NSTextAlignmentRight];
            [theView addSubview:dateLabel];
            
            
            // post status: Published
            if (aPost.isPublished == true) {
                
                UILabel *publishStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
                [publishStatusLabel setText:@"PUBLISHED"];
                [publishStatusLabel setTextColor:[UIColor blackColor]];
                [publishStatusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20]];
                [theView addSubview:publishStatusLabel];
                
                // ranking info - how many have seen it
                if (aPost.countViews > 0) {
                    
                    UILabel *rankingSeenCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, imageView.frame.origin.x - 20, 50)];
                    [rankingSeenCountLabel setNumberOfLines:2];
                    NSString *rankingSeenCountString = [NSString stringWithFormat:@"Seen by <number>%d</number>.", aPost.countViews];  // TODO: need to format the number into 100,000
                    [rankingSeenCountLabel setAttributedText:[rankingSeenCountString attributedStringWithStyleBook:labelAttributeStyle1]];
                    [theView addSubview:rankingSeenCountLabel];
                }
                
                // ranking info - how many have marked it as Nice
                if (aPost.countNices > 0) {
                    
                    UILabel *rankingNiceCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, imageView.frame.origin.x - 20, 50)];
                    [rankingNiceCountLabel setNumberOfLines:2];
                    NSString *rankingNiceCountString = [NSString stringWithFormat:@"<green><number>%d</number></green> people loved it!!", aPost.countNices];
                    [rankingNiceCountLabel setAttributedText:[rankingNiceCountString attributedStringWithStyleBook:labelAttributeStyle1]];
                    [theView addSubview:rankingNiceCountLabel];
                }
            }
            // post status: Not Published
            else {
                
                UILabel *publishStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
                [publishStatusLabel setText:@"NOT PUBLISHED"];
                [publishStatusLabel setTextColor:[Colors_Modal getUIColorForMain_4]];
                [publishStatusLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20]];
                [theView addSubview:publishStatusLabel];
                
                // message for 'not published'
                UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, theView.center.y/2+10, imageView.frame.origin.x - 20, 50)];
                [msgLabel setNumberOfLines:2];
                [msgLabel setAttributedText:[@"Want to try again?\n      <bold>⇐ Swipe left</bold>" attributedStringWithStyleBook:labelAttributeStyle1]];
                [theView addSubview:msgLabel];
            }
            
            return cell;
        }
        // this is the footer padding cell
        else {
            
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, CELL_HEIGHT__THE_VIEW/2)];
            [footerView setBackgroundColor:[UIColor clearColor]];
            
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            [cell.contentView setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
            [cell.contentView addSubview:footerView];
            
            return cell;
        }
    }
    // nothing to see label
    else {
        
        UILabel *nothingToSeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-75, 10, 150, 150)];
        [nothingToSeeLabel setText:@"You haven't posted anything yet"];
        [nothingToSeeLabel setNumberOfLines:2];
        [nothingToSeeLabel setTextColor:[Colors_Modal getUIColorForMain_7]];
        [nothingToSeeLabel setTextAlignment:NSTextAlignmentCenter];
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        [cell.contentView setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
        [cell.contentView addSubview:nothingToSeeLabel];
        
        return cell;
    }
}

#pragma mark - Label Attribute related
- (void)initLabelAttributes {
    
    labelAttributeStyle1 = @{ @"body":[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0],
                              @"number":[UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0],
                              @"green":[Colors_Modal getUIColorForMain_5],
                              @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0] };
}

#pragma mark - Alert Popup related
- (void)showAreYouSurePopup:(UIButton *)aButton {
    
    BOOL isRePostButton = ((aButton.tag - TAG_ID__BUTTON_DELETE) < 0);
    
    // Generate content view to present
    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    popupView.translatesAutoresizingMaskIntoConstraints = NO;
    popupView.backgroundColor = [Colors_Modal getUIColorForMain_1];
    popupView.layer.borderColor = [UIColor whiteColor].CGColor;
    popupView.layer.borderWidth = 3.0;
    popupView.layer.cornerRadius = 8.0;
    popupView.tag = 666;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 300, 50)];
    label1.text = (isRePostButton) ? @"Are you sure\nyou want to Re-Post?" : @"Are you sure\n you want to Delete?";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0];
    label1.numberOfLines = 2;
    [popupView addSubview:label1];
    
    // action buttons
    UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, 120, 40)];
    noButton.backgroundColor = [Colors_Modal getUIColorForMain_7];
    noButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    [noButton setTitle:@"No" forState:UIControlStateNormal];
    [noButton addTarget:self action:@selector(noButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:noButton];
    
    UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 90, 120, 40)];
    yesButton.backgroundColor = (isRePostButton) ? [Colors_Modal getUIColorForMain_5] : [Colors_Modal getUIColorForMain_4];
    yesButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    [yesButton setTitle:@"Yes" forState:UIControlStateNormal];
    [yesButton setTag:aButton.tag];
    
    // bind Re-Post action
    if (isRePostButton) {
        
        [yesButton addTarget:self action:@selector(rePostAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    // bind Delete action
    else {
        
        [yesButton addTarget:self action:@selector(deletePostAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [popupView addSubview:yesButton];
    
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter);
    
    popup = [KLCPopup popupWithContentView:popupView
                                  showType:(KLCPopupShowType)KLCPopupShowTypeBounceIn
                               dismissType:(KLCPopupDismissType)KLCPopupDismissTypeBounceOutToTop
                                  maskType:(KLCPopupMaskType)KLCPopupMaskTypeDimmed
                  dismissOnBackgroundTouch:NO
                     dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
}

- (void)noButtonPressed:(UIButton *)aButton {
    
    [popup dismiss:YES];
}

- (void)rePostAction:(UIButton *)aButton {  // TODO: incomplete
    
    // TODO: need to bind the tag of the button with the right PostHistory object.
    
    NSLog(@"REPOST: %ld", (long)aButton.tag);
    
    [popup dismiss:YES];
}

- (void)deletePostAction:(UIButton *)aButton {
    
    long cellIndex = (aButton.tag - TAG_ID__BUTTON_DELETE);
    PostHistory *aPost = [postsHistoryList objectAtIndex:cellIndex];
    
    [postsHistoryList removeObjectAtIndex:cellIndex];
    [DataStorageHelper deletePostHistory:aPost.postId];
    
    [popup dismiss:YES];
    
    [postsTableView reloadData];
}

@end


