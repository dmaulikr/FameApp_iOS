//
//  Post_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/28/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Post_ViewController.h"

@interface Post_ViewController ()
@end

@implementation Post_ViewController

@synthesize mySlotMachine, slotIcons;


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    self.navigationItem.title = @"POSTING...";
    
    [self initSubViews];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self startSlotMachine];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    
    [self initSlotMachine];
}

#pragma mark - Slot Machine related
- (void)initSlotMachine {
    
    slotIcons = [NSArray arrayWithObjects:[UIImage imageNamed:@"SlotMachine_Win"],
                                          [UIImage imageNamed:@"SlotMachine_Lose1"],
                                          [UIImage imageNamed:@"SlotMachine_Lose2"],
                                          [UIImage imageNamed:@"SlotMachine_Lose3"], nil];
    
    mySlotMachine = [[ZCSlotMachine alloc] initWithFrame:CGRectMake(0, 0, 291, 193)];
    mySlotMachine.center = CGPointMake(self.view.frame.size.width / 2, 120);
    mySlotMachine.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    mySlotMachine.contentInset = UIEdgeInsetsMake(5, 8, 5, 8);
//    mySlotMachine.backgroundImage = [UIImage imageNamed:@"SlotMachineBG1"];  // TODO:
    mySlotMachine.backgroundColor = [Colors_Modal getUIColorForMain_2];
    mySlotMachine.coverImage = [UIImage imageNamed:@"SlotMachineCover"];
    
    mySlotMachine.delegate = self;
    mySlotMachine.dataSource = self;
    
    [self.view addSubview:mySlotMachine];
    
    
    // TODO: DEBUG - REMOVE
//    [NSTimer scheduledTimerWithTimeInterval:5.5 target:self selector:@selector(test:) userInfo:nil repeats:NO];  // TODO: DEBUG
}

// TOOD: DEBUG - REMOVE
//- (void)test:(NSTimer *)timer {
//     
//     [mySlotMachine setFinalResults:[NSArray arrayWithObjects:
//                                   [NSNumber numberWithInteger:0],
//                                   [NSNumber numberWithInteger:0],
//                                   [NSNumber numberWithInteger:0],
//                                   [NSNumber numberWithInteger:0],
//                                   nil]];
// }

- (void)startSlotMachine {
    
    mySlotMachine.slotResults = [NSArray arrayWithObjects:
                              [NSNumber numberWithInteger:0],
                              [NSNumber numberWithInteger:0],
                              [NSNumber numberWithInteger:0],
                              [NSNumber numberWithInteger:0],
                              nil];
    
    [mySlotMachine startSliding:0];
}

- (void)slotMachineWillStartSliding:(ZCSlotMachine *)slotMachine {
}

- (void)slotMachineDidEndSliding:(ZCSlotMachine *)slotMachine {
    
//    // TODO: DEBUG - REMOVE
//    NSLog(@"%@", (slotMachine.isReallyDone ? @"YES" : @"NO"));
    
    if (slotMachine.isReallyDone == YES) {
        
        // TODO: show for winning
        
        // TOOD: -OR-
        
        // TODO: show for losing
    }
}

- (NSArray *)iconsForSlotsInSlotMachine:(ZCSlotMachine *)slotMachine {
    
    return slotIcons;
}

- (NSUInteger)numberOfSlotsInSlotMachine:(ZCSlotMachine *)slotMachine {
    
    return 4;
}

- (CGFloat)slotWidthInSlotMachine:(ZCSlotMachine *)slotMachine {
    
    return 65.0f;
}

- (CGFloat)slotSpacingInSlotMachine:(ZCSlotMachine *)slotMachine {
    
    return 5.0f;
}

@end

