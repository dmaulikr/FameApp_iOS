//
//  Post_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/28/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCSlotMachine.h"
#import "L360ConfettiArea.h"
#import "Colors_Modal.h"

@interface Post_ViewController : UIViewController <ZCSlotMachineDelegate, ZCSlotMachineDataSource>

@property (nonatomic) BOOL isWin;

@property (nonatomic, strong) IBOutlet UIView *biddingView;
@property (nonatomic, strong) ZCSlotMachine *mySlotMachine;
@property (nonatomic, strong) NSArray *slotIcons;
@property (nonatomic, strong) IBOutlet UILabel *winningOddsLabel;
@property (nonatomic, strong) IBOutlet UILabel *bonusOddsLabel;

@property (nonatomic, strong) IBOutlet UIView *winView;
@property (nonatomic, strong) IBOutlet UILabel *winHeaderLabel;
@property (nonatomic, strong) IBOutlet UIImageView *winImageView;

@property (nonatomic, strong) IBOutlet UIView *loseView;

@end

