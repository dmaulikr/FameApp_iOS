//
//  Post_ViewController.h
//  FameApp
//
//  Created by Eldar on 4/28/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCSlotMachine.h"
#import "Colors_Modal.h"

@interface Post_ViewController : UIViewController <ZCSlotMachineDelegate, ZCSlotMachineDataSource>

@property (nonatomic, strong) ZCSlotMachine *mySlotMachine;
@property (nonatomic, strong) NSArray *slotIcons;

@end

