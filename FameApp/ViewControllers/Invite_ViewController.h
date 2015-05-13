//
//  Invite_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/26/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegueHelper_Modal.h"
#import <MessageUI/MessageUI.h>
#import "NSString+WPAttributedMarkup.h"
#import "Colors_Modal.h"
#import "FormattingHelper.h"
#import "KBContactsSelectionViewController.h"
#import "APAddressBook.h"
#import "APPhoneWithLabel.h"
#import "KLCPopup.h"
#import "AFNetworking.h"
#import "AppAPI_Invite_Modal.h"

@interface Invite_ViewController : UIViewController <KBContactsSelectionViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *friendsInviteBonusInfoLabel;
@property (nonatomic, strong) NSMutableArray *invitedContacts;
@property (nonatomic, strong) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) KLCPopup *popupStatus;

@end

