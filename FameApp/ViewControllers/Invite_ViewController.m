//
//  Invite_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/26/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Invite_ViewController.h"

@interface Invite_ViewController ()
@end

@implementation Invite_ViewController

@synthesize friendsInviteBonusInfoLabel, invitedContacts;
@synthesize infoLabel;
@synthesize popupStatus;


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initInviteFriendsBonusInfo];
    
    [CustomSegueHelper_Modal setCustomBackButton:self];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [Analytics_Modal trackScreen:self];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    [self.navigationController.navigationBar setTintColor:[Colors_Modal getUIColorForNavigationBar_tintColor]];
    self.navigationItem.title = @"INVITE";
    
    invitedContacts = [[NSMutableArray alloc] init];
    
    [self initSubViews];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    
    [self initInfoLabel];
}

- (void)initInfoLabel {
    
    NSDictionary *labelAttributeStyle1 = @{ @"body":[UIFont fontWithName:@"HelveticaNeue" size:17.0],
                                            @"one":@[ [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:25.0],
                                                      [UIColor blackColor]],
                                            @"two":@[ [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:22.0],
                                                      [Colors_Modal getUIColorForMain_8] ],
                                            @"three":@[ [UIFont fontWithName:@"HelveticaNeue" size:10.0],
                                                      [UIColor blackColor] ]
                                          };
    
    [infoLabel setTextAlignment:NSTextAlignmentCenter];
    [infoLabel setNumberOfLines:7];
    [infoLabel setAttributedText:[@"Want to boost your odds to get <one>PUBLISHED</one> to the masses?\n<three>(of course you do)</three>\n\nInvite friends\nto get <two>FREE BONUSES</two>" attributedStringWithStyleBook:labelAttributeStyle1]];
}

- (void)initInviteFriendsBonusInfo {
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSArray *postReqInfo = [AppAPI_Invite_Modal requestContruct_BonusInfo];
    
    NSLog(@"App API - Request: Invite Bonus Info");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSLog(@"App API - Reply: Invite Bonus Info [SUCCESS]");
               
               NSDictionary *repDict = [AppAPI_Invite_Modal processReply_BonusInfo:responseObject];
               
               AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
               if (appDelegateInst.myBiddingAndBonusInfo == nil) {
                   
                   appDelegateInst.myBiddingAndBonusInfo = [[BiddingAndBonusInfo alloc] init];
               }
               
               appDelegateInst.myBiddingAndBonusInfo.bonusForFriendInvite = [repDict objectForKey:@"inviteBonus"];
               appDelegateInst.myBiddingAndBonusInfo.bonusForShareToSN = [repDict objectForKey:@"shareBonus"];
               
               [friendsInviteBonusInfoLabel setText:[FormattingHelper formatLabelTextForBonusInfo:appDelegateInst.myBiddingAndBonusInfo.bonusForFriendInvite]];
               
               [friendsInviteBonusInfoLabel setAlpha:1.0f];
               CGAffineTransform transform_oddsLabel = friendsInviteBonusInfoLabel.transform;
               [UIView animateWithDuration:1.0 animations:^{
                   
                   friendsInviteBonusInfoLabel.transform = CGAffineTransformScale(friendsInviteBonusInfoLabel.transform, 1.3, 1.3);
               }
               completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.8 animations:^{
                    
                    friendsInviteBonusInfoLabel.transform = transform_oddsLabel;
                }];
           }];
               
               // TODO: LATER - need to use the 'shareBonus'
               
           } // End of Request 'Success'
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               NSLog(@"App API - Reply: Invite Bonus Info [FAILURE]");
               NSLog(@"%@", error);
               
           } // End of Request 'Failure'
     ];
}

- (IBAction)openContacts:(id)sender {
    
    KBContactsSelectionViewController *vc = [KBContactsSelectionViewController contactsSelectionViewControllerWithConfiguration:^(KBContactsSelectionConfiguration *configuration) {
        
        configuration.mode = KBContactsSelectionModeMessages;
        configuration.shouldShowNavigationBar = NO;
        configuration.title = @"YOUR CONTACTS";
        configuration.tintColor = [Colors_Modal getUIColorForMain_1];
        configuration.skipUnnamedContacts = YES;
        configuration.selectButtonTitle = @"";
        configuration.customSelectButtonHandler = ^(NSArray *contacts) {
        };
    }];
    
    // work around.
    // for some weird reason this overrides the issue
    // with tintColor configuration of the controller,
    // and uses the app's tintColor in the navigation bar. HOORAY!!!
    UILabel * instructionsLabel = [[UILabel alloc] init];
    instructionsLabel.text = @"";
    vc.additionalInfoView = instructionsLabel;
    
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)contactsSelection:(KBContactsSelectionViewController *)selection didSelectContact:(APContact *)contact {
    
    // ERROR - SMS is not supported on this device.
    if([MFMessageComposeViewController canSendText] == NO) {
        
        [self showStatusPopup:NO message:@"Not supported on this device.\nSorry."];
        return;
    }
    
    NSArray *recipents = [[NSMutableArray alloc] initWithObjects:((APPhoneWithLabel *)[contact.phonesWithLabels objectAtIndex:0]).phone, nil];
    
    NSString *fullName = @"";
    if (contact.firstName != nil) {
        fullName = contact.firstName;
    }
    if (contact.lastName != nil) {
        if ([fullName isEqualToString:@""]) {
            fullName = contact.lastName;
        }
        else {
            fullName = [NSString stringWithFormat:@"%@ %@", fullName, contact.lastName];
        }
    }
    NSString *phoneNumber = ((APPhoneWithLabel *)[contact.phonesWithLabels objectAtIndex:0]).phone;
    NSString *emailAddress = ([contact.emails count] > 0) ? [contact.emails objectAtIndex:0] : @"";
    
    [invitedContacts addObject:@[ fullName, phoneNumber, emailAddress ]];
    
    NSString *contactName = @"Hey there";
    if (contact.firstName != nil) {
        contactName = contact.firstName;
    }
    else if (contact.lastName != nil) {
        contactName = contact.lastName;
    }
    NSString *message = [FormattingHelper formatSMSInvitePersonalMessage:0 name:contactName];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result {
    
    // NOTE: there is no way to know to whom the user actually sent the SMS
    //       it's important since we give bonus points for every user invited.
    
    if (result == MessageComposeResultCancelled) {
        
        // cancelled: do nothing
    }
    else if (result == MessageComposeResultFailed) {
        
        // failed: do nothing
    }
    else if (result == MessageComposeResultSent) {
        
        NSLog(@"SMS sent");
        
        AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
        operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSArray *postReqInfo = [AppAPI_Invite_Modal requestContruct_FriendInvited:invitedContacts];
        
        NSLog(@"App API - Request: Friend Invited");
        [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"App API - Reply: Friend Invited [SUCCESS]");
                   
                   NSDictionary *repDict = [AppAPI_Invite_Modal processReply_FriendInvited:responseObject];
                   
                   // Success
                   if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                       
                       [self showStatusPopup:YES message:[repDict objectForKey:@"earnedBonusMessage"]];
                   }
                   // Failure
                   else {
                       
                       [self showStatusPopup:NO message:[repDict objectForKey:@"statusMsg"]];
                   }
                   
               } // End of Request 'Success'
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   NSLog(@"App API - Reply: Friend Invited [FAILURE]");
                   NSLog(@"%@", error);
                   
                   [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
                   
               } // End of Request 'Failure'
         ];
    }
    
    invitedContacts = [[NSMutableArray alloc] init];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom);
    popupStatus = [KLCPopup popupWithContentView:popupView
                                        showType:(KLCPopupShowType)KLCPopupShowTypeSlideInFromBottom
                                     dismissType:(KLCPopupDismissType)KLCPopupDismissTypeSlideOutToBottom
                                        maskType:(KLCPopupMaskType)KLCPopupMaskTypeNone
                        dismissOnBackgroundTouch:NO
                           dismissOnContentTouch:NO];
    
    [popupStatus showWithLayout:layout];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(dismissStatusPopup:) userInfo:nil repeats:NO];
}

- (void)dismissStatusPopup:(NSTimer *)aTimer {
    
    [popupStatus dismiss:YES];
}

@end

