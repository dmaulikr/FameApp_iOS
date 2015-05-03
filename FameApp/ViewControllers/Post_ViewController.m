//
//  Post_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/28/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Post_ViewController.h"

@interface Post_ViewController () {
    
    // TODO: DEBUG - REMOVE
    float testPoint;
    int testCount;
}
@end

@implementation Post_ViewController

@synthesize isWin;
@synthesize biddingView, winView, loseView;
@synthesize mySlotMachine, slotIcons;
@synthesize winningOddsLabel, bonusOddsLabel;  // TODO: need to use
@synthesize winHeaderLabel, winImageView, winGraphView, winGraphNicesLabel, winGraphViewsLabel, labelAttributeStyle1;


- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

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
    self.navigationItem.title = @"POSTING YOUR FAME...";
    
    [self initSubViews];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self startSlotMachine];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [self initBiddingView];
}

- (void)initBiddingView {
    
    [biddingView setHidden:NO];
    [winView setHidden:YES];
    [loseView setHidden:YES];
    
    // TODO: set the labels.
    // TODO: hide 'bonus' view if user has none.
    
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
    mySlotMachine.backgroundColor = [Colors_Modal getUIColorForMain_6];
    mySlotMachine.coverImage = [UIImage imageNamed:@"SlotMachineCover"];
    
    mySlotMachine.delegate = self;
    mySlotMachine.dataSource = self;
    
    [biddingView addSubview:mySlotMachine];
    
    
    // TODO: DEBUG - REMOVE
    [NSTimer scheduledTimerWithTimeInterval:5.5 target:self selector:@selector(test:) userInfo:nil repeats:NO];  // TODO: DEBUG
}

// TOOD: DEBUG - REMOVE
- (void)test:(NSTimer *)timer {
     
     [mySlotMachine setFinalResults:[NSArray arrayWithObjects:
                                   [NSNumber numberWithInteger:0],
                                   [NSNumber numberWithInteger:0],
                                   [NSNumber numberWithInteger:0],
                                   [NSNumber numberWithInteger:0],
                                   nil]];
    
    
//        [self initWinViews];  // TODO: DEBUG - REMOVE
 }

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
    
    if (slotMachine.isReallyDone == YES) {
        
        if (isWin) {
            
            [self initWinViews];
        }
        else {
            
            [self initWinViews];
        }
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

#pragma mark - Winning related
- (void)initWinViews {  // TODO: incomplete
    
    [self showConfetti];
    
    // TODO: set winHeaderLabel
    // TODO: set winImageView
    // TODO: init the counters: nice & views
    
    
    [self initLabelStyles];
    [self initGraphView];
    
    // TODO: DEBUG - REMOVE
    testPoint = 0;
    testCount = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(test2:) userInfo:nil repeats:YES];  // TODO: DEBUG
    
    [winView setAlpha:0.0f];
    [winView setHidden:NO];
    
    [UIView animateWithDuration:3.0f animations:^{
        
        [winView setAlpha:1.0f];
        [biddingView setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        
        self.navigationItem.title = @"PUBLISHED !!!";
        [biddingView setHidden:YES];
    }];
}

- (void)showConfetti {
    
    // init confetti
    L360ConfettiArea *confettiView = [[L360ConfettiArea alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    confettiView.swayLength = 20.0;
    [self.view addSubview:confettiView];
    
    // blast confetti for victory!!
    confettiView.blastSpread = 0.3;
    [confettiView blastFrom:[self.view convertPoint:[self.view viewWithTag:2003].center toView:confettiView]
                         towards:M_PI / 2.0
                       withForce:700.0
                   confettiWidth:20.0
                numberOfConfetti:20.0];
    
    [confettiView blastFrom:[self.view convertPoint:[self.view viewWithTag:2001].center toView:confettiView]
                    towards:M_PI / 3.0
                  withForce:500.0
              confettiWidth:10.0
           numberOfConfetti:15.0];
    
    [confettiView blastFrom:[self.view convertPoint:[self.view viewWithTag:2002].center toView:confettiView]
                    towards:M_PI / 1.0
                  withForce:500.0
              confettiWidth:10.0
           numberOfConfetti:15.0];
}

- (void)initGraphView {
    
    CGRect aFrame = winImageView.frame;
    aFrame.size.width = 20;
    aFrame.size.height = 20;
    aFrame.origin.y += winImageView.frame.size.height - aFrame.size.height;
    
    winGraphView = [[GraphView alloc]initWithFrame:aFrame];
    [winGraphView setBackgroundColor:[UIColor clearColor]];
    [winGraphView setSpacing:20];
    [winGraphView setFill:NO];
    [winGraphView setStrokeColor:[UIColor whiteColor]];
    [winGraphView setZeroLineStrokeColor:[UIColor clearColor]];
    [winGraphView setLineWidth:4];
    [winGraphView setCurvedLines:NO];
    [winGraphView hideAxis:YES];
    
    [winView addSubview:winGraphView];
}

- (void)test2:(NSTimer *)timer {  // TODO: DEBUG - REMOVE
    
    testPoint += arc4random() % 10000;
    testCount++;
    
    [self updateWinningGraphAndLabels:testPoint niceCount:(testPoint/10) updateCount:testCount];
}

- (void)updateWinningGraphAndLabels:(int)viewsCount niceCount:(int)niceCount updateCount:(int)updateCount {
    
    [winGraphView setPoint:viewsCount];
    
    [winGraphView setNumberOfPointsInGraph:updateCount];
    CGRect aFrame = winGraphView.frame;
    if (aFrame.size.width < (winImageView.frame.size.width/1.2)) {
        aFrame.size.width += 20;
    }
    if (aFrame.size.height < (winImageView.frame.size.height/1.2)) {
        aFrame.size.height += 20;
        aFrame.origin.y -= 20;
    }
    winGraphView.frame = aFrame;
    
    
    NSString *niceLabelString = [NSString stringWithFormat:@"<niceNumber>%d</niceNumber> <niceText>loved it</niceText>", niceCount];
    [winGraphNicesLabel setAttributedText:[niceLabelString attributedStringWithStyleBook:labelAttributeStyle1]];
    
    NSString *viewsLabelString = [NSString stringWithFormat:@"<viewsText>seen by</viewsText> <viewsNumber>%d</viewsNumber>", viewsCount];
    [winGraphViewsLabel setAttributedText:[viewsLabelString attributedStringWithStyleBook:labelAttributeStyle1]];
}

- (void)initLabelStyles {
    
    labelAttributeStyle1 = @{
                           @"body":[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0],
                           @"niceNumber":@[[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:50.0], [Colors_Modal getUIColorForMain_5]],
                           @"niceText":@[[UIFont fontWithName:@"HelveticaNeue" size:20.0], [Colors_Modal getUIColorForMain_5]],
                           @"viewsNumber":@[[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:45.0], [UIColor whiteColor]],
                           @"viewsText":@[[UIFont fontWithName:@"HelveticaNeue" size:20.0], [UIColor whiteColor]],
                       };
}

#pragma mark - Losing related
- (void)initLoseViews {  // TODO: incomplete
    
}

@end

