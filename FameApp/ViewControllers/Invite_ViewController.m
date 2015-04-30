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


// TODO: allow the user to share the


@implementation Invite_ViewController

@synthesize infoLabel;
@synthesize popupStatus;


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
    self.navigationItem.title = @"INVITE";
    
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
    
    // TODO: there is no way to know to whom the user actually sent the SMS
    // TODO: it's important since we give bonus points for every user invited.
    
    if (result == MessageComposeResultCancelled) {
        
        // cancelled: do nothing
    }
    else if (result == MessageComposeResultFailed) {
        
        // failed: do nothing
    }
    else if (result == MessageComposeResultSent) {
        
        NSLog(@"SMS sent");
        
        // TODO: incomplete
        // TODO:    1. send to server.
        // TODO:    2. show status popup
    }
    
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

