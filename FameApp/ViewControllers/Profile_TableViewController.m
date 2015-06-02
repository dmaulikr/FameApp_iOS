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

@interface Profile_TableViewController ()
@end


@implementation Profile_TableViewController

@synthesize appDelegateInst;
@synthesize labelAttributeStyle1;
@synthesize userImageView, userDisplayNameLabel, userIdLabel;
@synthesize postsTableView, postsHistoryList;
@synthesize popup;

- (void)didReceiveMemoryWarning {
 
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [CustomSegueHelper_Modal setCustomBackButton:self];
    
    [self initSubViews];
    [self initLabelAttributes];
    
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    self.navigationItem.title = @"YOU";
    
    [URLHelper setImageWithDefaultCache:appDelegateInst.loginUser.userImageURL imageView:userImageView placeholderImageName:[PlaceholderImageHelper imageNameForUserProfileEdit]];
}

#pragma mark - Subviews init by device type
- (void)initSubViews {
    
    [UIHelper setRoundedCornersCircleToView:userImageView];
    
    if (((id)appDelegateInst.loginUser.userDisplayName != [NSNull null])
        && ([appDelegateInst.loginUser.userDisplayName isEqualToString:@""] == NO)) {
        
        [userDisplayNameLabel setText:appDelegateInst.loginUser.userDisplayName];
    }
    [userIdLabel setText:appDelegateInst.loginUser.userId];
    
    [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    [postsTableView setBackgroundColor:[Colors_Modal getUIColorForMain_6]];
    
    dt = [DeviceTypeHelper getDeviceType];
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
    
    // show posts
    if ([postsHistoryList count] > 0) {
        
        // regular cell
        if (indexPath.row < [postsHistoryList count]) {
            
            return (CELL_HEIGHT__THE_VIEW + CELL_HEIGHT__THE_SEPARATOR);
        }
        // footer padding cell
        else {
            
            return CELL_HEIGHT__THE_VIEW / 2;
        }
    }
    // nothing to see
    else {
        
        return CELL_HEIGHT__THE_VIEW;
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
                    NSString *rankingSeenCountString = [NSString stringWithFormat:@"Seen by <number>%@</number>.", [FormattingHelper formatNumberIntoString:aPost.countViews]];
                    [rankingSeenCountLabel setAttributedText:[rankingSeenCountString attributedStringWithStyleBook:labelAttributeStyle1]];
                    [theView addSubview:rankingSeenCountLabel];
                }
                
                // ranking info - how many have marked it as Nice
                if (aPost.countNices > 0) {
                    
                    UILabel *rankingNiceCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, imageView.frame.origin.x - 20, 50)];
                    [rankingNiceCountLabel setNumberOfLines:2];
                    NSString *rankingNiceCountString = [NSString stringWithFormat:@"<green><number>%@</number></green> people loved it!!", [FormattingHelper formatNumberIntoString:aPost.countNices]];
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
        
        UIActivityIndicatorView *mActivity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(aButton.center.x, aButton.center.y+30, 10, 10)];
        [aButton addSubview:mActivity];
        [mActivity startAnimating];
        [aButton setEnabled:NO];
        
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
    
    [postsTableView reloadData];
    [popup dismiss:YES];
}

- (void)rePostAction:(UIButton *)aButton {
    
    NSLog(@"REPOST: %ld", (long)aButton.tag);
    
    [popup dismiss:YES];
    
    long cellIndex = (aButton.tag - TAG_ID__BUTTON_REPOST);
    PostHistory *aPost = [postsHistoryList objectAtIndex:cellIndex];
    
    UIImage *imageToSave = [ImageStorageHelper loadImageFromLocalDirectory:aPost.contentFileName];
    
    // saving image locally - part 1/3
    PostHistory *currentPost = [[PostHistory alloc] init];
    currentPost.userId = appDelegateInst.loginUser.userId;
    currentPost.contentFileName = [ImageStorageHelper saveImageToLocalDirectory:imageToSave aUsername:appDelegateInst.loginUser.userId];
    currentPost.timerMSec = aPost.timerMSec;
    
    // re-posting
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSData *imageData = UIImageJPEGRepresentation(imageToSave, 1.0f);
    NSArray *postReqInfo = [AppAPI_Post_Modal requestContruct_PostImage:[NSString stringWithFormat:@"%ld", (unsigned long)imageData.length]];
    
    NSLog(@"App API - Request: (Re)Post Image");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
         constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         
             [formData appendPartWithFileData:imageData name:@"file" fileName:@"jim.jpg" mimeType:@"image/jpeg"];
             
         }
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSLog(@"App API - Reply: (Re)Post Image [SUCCESS]");
             
             [postsTableView reloadData];
             
             NSDictionary *repDict = [AppAPI_Post_Modal processReply_PostImage:responseObject];
             
             // Success
             if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                 
                 // post info
                 [self sendPostInfo:[repDict objectForKey:@"imageUrl"] timer:currentPost.timerMSec contentImageItself:imageToSave currentPost:currentPost];
                 
             }
             // Failure
             else {
                 
                 // delete locally stored image
                 [ImageStorageHelper deleteImageFromLocalDirectory:currentPost.contentFileName];
                 
                 [self.navigationItem stopAnimating];
                 
                 [self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"App API - Reply: (Re)Post Image [FAILURE]");
             NSLog(@"%@", error);
             
             [postsTableView reloadData];
             
             // delete locally stored image
             [ImageStorageHelper deleteImageFromLocalDirectory:currentPost.contentFileName];
             
             [self.navigationItem stopAnimating];
             
             [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
         }
     ];
}

- (void)sendPostInfo:(NSString *)imageURL timer:(int)timer contentImageItself:(UIImage *)contentImageItself currentPost:(PostHistory *)currentPost {
        
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSArray *postReqInfo = [AppAPI_Post_Modal requestContruct_PostInfo:imageURL timer:timer];
    
    NSLog(@"App API - Request: Post Info");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSLog(@"App API - Reply: Post Info [SUCCESS]");
               
               [postsTableView reloadData];
               
               NSDictionary *repDict = [AppAPI_Post_Modal processReply_PostInfo:responseObject];
               
               // Success
               if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                   
                   // saving image locally - part 2/3
                   currentPost.timestamp = [[NSDate alloc] init];
                   currentPost.postId = [repDict objectForKey:@"postId"];
                   
                   // show next screen
                   Post_ViewController *myViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PostScreen"];
                   myViewController.contentImage = contentImageItself;
                   myViewController.currentPost = currentPost;
                   
                   [self presentViewController:[[UINavigationController alloc] initWithRootViewController:myViewController] animated:YES completion:nil];
                   
               }
               // Failure
               else {
                   
                   // delete locally stored image
                   [ImageStorageHelper deleteImageFromLocalDirectory:currentPost.contentFileName];
                   
                   [self.navigationItem stopAnimating];
                   
                   [self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
               }
               
           } // End of Request 'Success'
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               NSLog(@"App API - Reply: Post Info [FAILURE]");
               NSLog(@"%@", error);
               
               [postsTableView reloadData];
               
               // delete locally stored image
               [ImageStorageHelper deleteImageFromLocalDirectory:currentPost.contentFileName];
               
               [self.navigationItem stopAnimating];
               
               [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
               
           } // End of Request 'Failure'
     ];
}

- (void)deletePostAction:(UIButton *)aButton {
    
    long cellIndex = (aButton.tag - TAG_ID__BUTTON_DELETE);
    PostHistory *aPost = [postsHistoryList objectAtIndex:cellIndex];
    
    [postsHistoryList removeObjectAtIndex:cellIndex];                           // remove from dataList
    [DataStorageHelper deletePostHistory:aPost.postId];                         // remove entry from db
    [ImageStorageHelper deleteImageFromLocalDirectory:aPost.contentFileName];   // remove the content file
    [popup dismiss:YES];
    [postsTableView reloadData];
    [self showStatusPopup:YES message:@"Post is gone forever."];
    
    
    // tell server the user deleted the post from the local device
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSArray *postReqInfo = [AppAPI_Profile_Modal requestContruct_DeletedPostHistory:aPost.postId];
    
    NSLog(@"App API - Request: Deleted Post History");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSLog(@"App API - Reply: Deleted Post History [SUCCESS]");
               
               NSDictionary *repDict = [AppAPI_Profile_Modal processReply_DeletedPostHistory:responseObject];
               
               // Success
               if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                   
                   // do nothing
               }
               // Failure
               else {
                   
                   //[self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
               }
               
           } // End of Request 'Success'
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               NSLog(@"App API - Reply: Deleted Post History [FAILURE]");
               NSLog(@"%@", error);
               
               //[self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
               
           } // End of Request 'Failure'
     ];
}

#pragma mark - Status Popup related
- (void)showStatusPopup:(BOOL)status message:(NSString *)message {
    
    // Generate content view to present
    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    popupView.translatesAutoresizingMaskIntoConstraints = NO;
    popupView.backgroundColor = (status) ? [Colors_Modal getUIColorForMain_5] : [Colors_Modal getUIColorForMain_4];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width-20, 35)];
    label1.text = message;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    label1.numberOfLines = 2;
    [popupView addSubview:label1];
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom);
    
    popup = [KLCPopup popupWithContentView:popupView
                                  showType:(KLCPopupShowType)KLCPopupShowTypeSlideInFromBottom
                               dismissType:(KLCPopupDismissType)KLCPopupDismissTypeSlideOutToBottom
                                  maskType:(KLCPopupMaskType)KLCPopupMaskTypeNone
                  dismissOnBackgroundTouch:NO
                     dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(dismissStatusPopup:) userInfo:nil repeats:NO];
}

- (void)dismissStatusPopup:(NSTimer *)aTimer {
    
    [popup dismiss:YES];
}

#pragma mark - Keyboard related
- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    // save User Display Name
    if (textField == userDisplayNameLabel) {
        
        AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
        operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSArray *postReqInfo = [AppAPI_Profile_Modal requestContruct_UpdateDisplayName:userDisplayNameLabel.text];
        
        NSLog(@"App API - Request: Update Display Name");
        [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"App API - Reply: Update Display Name [SUCCESS]");
                   
                   NSDictionary *repDict = [AppAPI_Profile_Modal processReply_UpdateDisplayName:responseObject];
                   
                   // Success
                   if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                       
                       appDelegateInst.loginUser.userDisplayName = userDisplayNameLabel.text;
                       [DataStorageHelper setLoginUserInfo:appDelegateInst.loginUser];
                       
                       [self showStatusPopup:YES message:@"Display name updated."];
                   }
                   // Failure
                   else {
                       
                       [self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
                   }
                   
               } // End of Request 'Success'
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   NSLog(@"App API - Reply: Update Display Name [FAILURE]");
                   NSLog(@"%@", error);
                   
                   [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
                   
               } // End of Request 'Failure'
         ];
    }
}

#pragma mark - Camera related
- (IBAction)openCamera:(id)sender {
    
    YCameraViewController *camController = [[YCameraViewController alloc] initForProfileWithNibName:@"YCameraViewController" bundle:nil];
    camController.delegate = self;
    
    [self.navigationController pushViewController:camController animated:YES];
}

-(void)didFinishPickingImage:(UIImage *)image {
    
//    [userImageView setImage:image];
    
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);
    NSArray *postReqInfo = [AppAPI_Profile_Modal requestContruct_UpdateProfileImage:[NSString stringWithFormat:@"%ld", (unsigned long)imageData.length]];
    
    NSLog(@"App API - Request: Update Profile Image");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
         constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         
             [formData appendPartWithFileData:imageData name:@"file" fileName:@"jim.jpg" mimeType:@"image/jpeg"];
             
         }
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSLog(@"App API - Reply: Update Profile Image [SUCCESS]");
             
             NSDictionary *repDict = [AppAPI_Profile_Modal processReply_UpdateProfileImage:responseObject];
             
             // Success
             if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                 
                 appDelegateInst.loginUser.userImageURL = [repDict objectForKey:@"imageUrl"];
                 [DataStorageHelper setLoginUserInfo:appDelegateInst.loginUser];
                 
                 [URLHelper setImageWithDefaultCache:appDelegateInst.loginUser.userImageURL imageView:userImageView placeholderImageName:[PlaceholderImageHelper imageNameForUserProfileEdit]];
                 
                 [self showStatusPopup:YES message:@"Profile image updated."];
             }
             // Failure
             else {
                 
                 [self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"App API - Reply: Update Profile Image [FAILURE]");
             NSLog(@"%@", error);
             
             [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
         }
     ];
}

-(void)yCameraControllerdidSkipped {
    // Called when user clicks on Skip button on YCameraViewController view
}

-(void)yCameraControllerDidCancel {
    // Called when user clicks on "X" button to close YCameraViewController
}

@end


