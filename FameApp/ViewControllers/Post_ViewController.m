//
//  Post_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/28/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Post_ViewController.h"

const NSTimeInterval POST_STATUS__SAMPLE_INTERVAL_SECONDS = 1;

@interface Post_ViewController () {
    
    UIColor *restoreNavBar_barTintColor;
    UIColor *restoreNavBar_tintColor;
    NSDictionary *restoreNavBar_titleTextAttributes;
}
@end


// TODO: update server on bonus earned ? (or the server already knows???)

// TODO: adjust to all iPhone types

// TODO: better looking screen design - more like the main screen maybe ?


@implementation Post_ViewController

@synthesize contentImage;
@synthesize currentPost;
@synthesize appDelegateInst;
@synthesize isWin;
@synthesize closeButton;
@synthesize sampleTimer_postStatus;
@synthesize biddingView, winView;
@synthesize mySlotMachine, slotIcons;
@synthesize isBeingPublished;
@synthesize winningOddsLabel, bonusOddsLabel;
@synthesize winHeaderLabel, winImageView, winGraphView, winGraphNicesLabel, winGraphViewsLabel;
@synthesize loseLabel, loseWantMoreLabel;
@synthesize labelAttributeStyle1;
@synthesize winTimer, winTimerController, winTimerPercentCount, winTimerFinishSeconds, sampleCount;


- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    restoreNavBar_barTintColor = self.navigationController.navigationBar.barTintColor;
    restoreNavBar_tintColor = self.navigationController.navigationBar.tintColor;
    restoreNavBar_titleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForMain_3]];
    [self.navigationController.navigationBar setTintColor:[Colors_Modal getUIColorForNavigationBar_tintColor_1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [Colors_Modal getUIColorForNavigationBar_tintColor_1], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:22.0], NSFontAttributeName, nil]];
    self.navigationItem.title = @"POSTING YOUR FAME...";
    
    [self setStateForCloseButton:NO];
    [self initLabelStyles];
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self startSlotMachine];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:restoreNavBar_barTintColor];
    [self.navigationController.navigationBar setTintColor:restoreNavBar_tintColor];
    [self.navigationController.navigationBar setTitleTextAttributes:restoreNavBar_titleTextAttributes];
}

- (void)setStateForCloseButton:(BOOL)isVisible {
    
    if (isVisible) {
        
        [self.navigationItem setLeftBarButtonItems:@[closeButton] animated:YES];
    }
    else {
        
        [self.navigationItem setLeftBarButtonItems:nil animated:NO];
    }
}

- (IBAction)closeButtonPressed:(id)sender {
    
    UINavigationController *myNavigationController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MainNav"];
    [self presentViewController:myNavigationController animated:YES completion:nil];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [self initBiddingView];
}

- (void)initBiddingView {
    
    [biddingView setHidden:NO];
    [winView setHidden:YES];
    [loseWantMoreLabel setHidden:YES];
    [loseLabel setHidden:YES];
    
    [self initBiddingAndBonusInfoViews];
    [self initSlotMachine];
}

- (void)initBiddingAndBonusInfoViews {
    
    if (appDelegateInst.myBiddingAndBonusInfo == nil) {
        
        [[self.view viewWithTag:2001] setHidden:YES];
        [[self.view viewWithTag:2002] setHidden:YES];
    }
    else {
        
        [winningOddsLabel setText:appDelegateInst.myBiddingAndBonusInfo.winningOdds];
        [bonusOddsLabel setText:[FormattingHelper formatLabelTextForCurrentOddBonus:appDelegateInst.myBiddingAndBonusInfo.bonusOdds]];
        
        [[self.view viewWithTag:2001] setHidden:[appDelegateInst.myBiddingAndBonusInfo.winningOdds isEqualToString:@""]];
        [[self.view viewWithTag:2002] setHidden:[appDelegateInst.myBiddingAndBonusInfo.bonusOdds isEqualToString:@""]];
    }
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
    
    // Sample for post status
    sampleCount = 0;
    sampleTimer_postStatus = [NSTimer scheduledTimerWithTimeInterval:POST_STATUS__SAMPLE_INTERVAL_SECONDS target:self selector:@selector(samplePostStatus:) userInfo:nil repeats:YES];
}

- (void)samplePostStatus:(NSTimer *)timer {
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSArray *postReqInfo = [AppAPI_Post_Modal requestContruct_PostStatus:currentPost.postId];
    
    NSLog(@"App API - Request: Post Status");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSLog(@"App API - Reply: Post Status [SUCCESS]");
               
               NSDictionary *repDict = [AppAPI_Post_Modal processReply_PostStatus:responseObject];
               
               // Success
               if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                   
                   // LIMBO: waiting
                   if ([[repDict objectForKey:@"postStatus"] intValue] == 0) {
                       
                       // do nothing for now
                   }
                   // WIN: published. WEEEE!!
                   else if ([[repDict objectForKey:@"postStatus"] intValue] == 2) {
                       
                       if (isBeingPublished == NO) {
                           
                           isWin = YES;
                           isBeingPublished = YES;
                           
                           // set slotmachine to win
                           [mySlotMachine setFinalResults:[NSArray arrayWithObjects:
                                                           [NSNumber numberWithInteger:0],
                                                           [NSNumber numberWithInteger:0],
                                                           [NSNumber numberWithInteger:0],
                                                           [NSNumber numberWithInteger:0],
                                                           nil]];
                           
                           currentPost.isPublished = true;
                       }
                       
                       currentPost.countViews = [[repDict objectForKey:@"totalViewsCount"] intValue];
                       currentPost.countNices = [[repDict objectForKey:@"totalNiceCount"] intValue];
                       
                       [self updateWinningGraphAndLabels:currentPost.countViews niceCount:currentPost.countNices updateCount:sampleCount++];
                   }
                   // LOSE: will not be published
                   else {
                       
                       isWin = NO;
                       
                       [sampleTimer_postStatus invalidate];
                       sampleTimer_postStatus = nil;
                       
                       // set slotmachine to lose
                       [mySlotMachine setFinalResults:[NSArray arrayWithObjects:
                                                       [NSNumber numberWithInteger:0],  // TODO: incomplete - lose values are to be set by the server
                                                       [NSNumber numberWithInteger:0],
                                                       [NSNumber numberWithInteger:0],
                                                       [NSNumber numberWithInteger:0],
                                                       nil]];
                       
                       currentPost.isPublished = false;
                       currentPost.countViews = 0;
                       currentPost.countNices = 0;
                       
                       // saving image locally - part 3/3 (for lose)
                       [DataStorageHelper addPostHistory:currentPost];
                   }
               }
               // Failure
               else {
                   
                   // for error, make it look like the user lost
                   isWin = NO;
                   
                   [sampleTimer_postStatus invalidate];
                   sampleTimer_postStatus = nil;
                   
                   // set slotmachine to win
                   [mySlotMachine setFinalResults:[NSArray arrayWithObjects:
                                                   [NSNumber numberWithInteger:3],
                                                   [NSNumber numberWithInteger:3],
                                                   [NSNumber numberWithInteger:3],
                                                   [NSNumber numberWithInteger:3],
                                                   nil]];
                   // TODO: for lose, slotmachine values are set by the server
                   
                   currentPost.isPublished = false;
                   currentPost.countViews = 0;
                   currentPost.countNices = 0;
                   
                   // saving image locally - part 3/3 (for lose)
                   [DataStorageHelper addPostHistory:currentPost];
               }
               
           } // End of Request 'Success'
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               NSLog(@"App API - Reply: Post Status [FAILURE]");
               NSLog(@"%@", error);
               
               // for error, make it look like the user lost
               isWin = NO;
               
               [sampleTimer_postStatus invalidate];
               sampleTimer_postStatus = nil;
               
               // set slotmachine to win
               [mySlotMachine setFinalResults:[NSArray arrayWithObjects:
                                               [NSNumber numberWithInteger:3],
                                               [NSNumber numberWithInteger:3],
                                               [NSNumber numberWithInteger:3],
                                               [NSNumber numberWithInteger:3],
                                               nil]];
               
               currentPost.isPublished = false;
               currentPost.countViews = 0;
               currentPost.countNices = 0;
               
               // saving image locally - part 3/3 (for lose)
               [DataStorageHelper addPostHistory:currentPost];
               
           } // End of Request 'Failure'
     ];
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
            
            [self initLoseViews];
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
- (void)initWinViews {
    
    [self showConfetti];
    
    // TODO: should the winHeaderLabel contain changing custom messages???
    
    [winImageView setImage:contentImage];
    
    [self initGraphView];
    [self initTimerView];
    [self startTimer:0 finishSeconds:currentPost.timerMSec];
    
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
    aFrame.size.width = 15;
    aFrame.size.height = 15;
    aFrame.origin.y += winImageView.frame.size.height - aFrame.size.height;
    
    winGraphView = [[GraphView alloc]initWithFrame:aFrame];
    [winGraphView setBackgroundColor:[UIColor clearColor]];
    [winGraphView setSpacing:15];
    [winGraphView setFill:NO];
    [winGraphView setStrokeColor:[UIColor whiteColor]];
    [winGraphView setZeroLineStrokeColor:[UIColor clearColor]];
    [winGraphView setLineWidth:4];
    [winGraphView setCurvedLines:NO];
    [winGraphView hideAxis:YES];
    
    [winView addSubview:winGraphView];
}

- (void)updateWinningGraphAndLabels:(int)viewsCount niceCount:(int)niceCount updateCount:(int)updateCount {
    
    [winGraphView setPoint:viewsCount];
    
    [winGraphView setNumberOfPointsInGraph:updateCount];
    CGRect aFrame = winGraphView.frame;
    if (aFrame.size.width < (winImageView.frame.size.width/1.2)) {
        aFrame.size.width += 15;
    }
    if (aFrame.size.height < (winImageView.frame.size.height/1.2)) {
        aFrame.size.height += 15;
        aFrame.origin.y -= 15;
    }
    winGraphView.frame = aFrame;
    
    
    NSString *niceLabelString = [NSString stringWithFormat:@"<niceNumber>%d</niceNumber> <niceText>loved it</niceText>", niceCount];
    [winGraphNicesLabel setAttributedText:[niceLabelString attributedStringWithStyleBook:labelAttributeStyle1]];
    
    NSString *viewsLabelString = [NSString stringWithFormat:@"<viewsText>seen by</viewsText> <viewsNumber>%d</viewsNumber>", viewsCount];
    [winGraphViewsLabel setAttributedText:[viewsLabelString attributedStringWithStyleBook:labelAttributeStyle1]];
}

- (void)showWinFinalScore {
    
    [UIView animateWithDuration:1.0f animations:^{
        
        winGraphNicesLabel.frame = CGRectOffset(winGraphNicesLabel.frame, 0, winGraphNicesLabel.frame.size.height);
        winGraphViewsLabel.frame = CGRectOffset(winGraphViewsLabel.frame, 0, -winGraphViewsLabel.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [loseWantMoreLabel setHidden:NO];
        [self setStateForCloseButton:YES];
        
        // TODO: do I need to get status one more time to get the FINAL SCORE?
        
        // TODO: Show a really cool message that the user is a fucking mega star!!!!
        
        // TODO: LATER - allow the user to share the score to SN.
    }];
}

#pragma mark - Win Timer related
- (void)initTimerView {
    
    CGRect aFrame = CGRectMake(winImageView.frame.origin.x + winImageView.frame.size.width - 50,
                               winImageView.frame.origin.y + 15, 35, 35);
    winTimerController = [[KKProgressTimer alloc] initWithFrame:aFrame];
    [winView addSubview:winTimerController];
    winTimerController.delegate = self;
}

- (void)startTimer:(NSInteger)startSeconds finishSeconds:(NSInteger)finishSeconds {
    
    if (winTimer != nil) {
        [winTimer invalidate];
    }
    winTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(timerInverval:) userInfo:nil repeats:YES];
    winTimerFinishSeconds = finishSeconds;
    winTimerPercentCount = startSeconds;
    [winTimerController startWithBlock:^CGFloat {
        
        return winTimerPercentCount / 100;
    }];
}

- (void)timerInverval:(NSTimer *)aTimer {
    
    winTimerPercentCount += 100/(CGFloat)winTimerFinishSeconds/10;
    
    if (winTimerPercentCount >= 100) {
        
        [winTimer invalidate];
        winTimer = nil;
    }
}

- (void)didUpdateProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    if (percentage >= 1) {
        
        [progressTimer stop];
    }
}

- (void)didStopProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    NSLog(@"TIMER DONE.");
    
    [sampleTimer_postStatus invalidate];
    sampleTimer_postStatus = nil;
    
    [self showWinFinalScore];
    
    // saving image locally - part 3/3 (for win)
    [DataStorageHelper addPostHistory:currentPost];
}

#pragma mark - Losing related
- (void)initLoseViews {
    
    self.navigationItem.title = @"NOT PUBLISHED :(";
    
    BOOL isEarnedBonus = YES;  // TODO: need to set the value using real results
    NSString *earnedBonusString = @"1.5%";  // TODO: need to set from real result
    
    NSString *loseLabelString = @"";
    NSString *loseWantMoreLabelString = @"";
    if (isEarnedBonus == YES) {
        
        loseLabelString = [NSString stringWithFormat:@"You didn't win.\nBut you've earned a bonus for next time: <bonusOddsNumber>%@</bonusOddsNumber>", earnedBonusString];
        loseWantMoreLabelString = @"<wantMoreLink>WANT MORE?</wantMoreLink>";
    }
    else {
        
        loseLabelString = [NSString stringWithFormat:@"So close...But no."];
        loseWantMoreLabelString = @"<wantMoreLink>BOOST YOUR ODDS TO WIN NEXT TIME !!</wantMoreLink>";
    }
    [loseLabel setAttributedText:[loseLabelString attributedStringWithStyleBook:labelAttributeStyle1]];
    [loseWantMoreLabel setAttributedText:[loseWantMoreLabelString attributedStringWithStyleBook:labelAttributeStyle1]];
    
    [loseLabel setHidden:NO];
    
    [UIView animateWithDuration:1.0f animations:^{
        
        mySlotMachine.frame = CGRectOffset(mySlotMachine.frame, 0, 200);
        [[self.view viewWithTag:2001] setAlpha:0.0f];
        [[self.view viewWithTag:2002] setAlpha:0.0f];
        [[self.view viewWithTag:2003] setAlpha:0.0f];
    } completion:^(BOOL finished) {
        
        [loseWantMoreLabel setHidden:NO];
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(showLoseViewWantMore:) userInfo:nil repeats:NO];
}

- (void)showLoseViewWantMore:(NSTimer *)timer {

    [UIView animateWithDuration:1.0f animations:^{
        
        mySlotMachine.frame = CGRectOffset(mySlotMachine.frame, 0, 200);
    } completion:^(BOOL finished) {
        
        [self setStateForCloseButton:YES];
    }];
}

#pragma mark - Label style related
- (void)initLabelStyles {
    
    labelAttributeStyle1 = @{
                             @"body":[UIFont fontWithName:@"HelveticaNeue" size:30.0],
                             @"niceNumber":@[[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:50.0], [Colors_Modal getUIColorForMain_5]],
                             @"niceText":@[[UIFont fontWithName:@"HelveticaNeue" size:20.0], [Colors_Modal getUIColorForMain_5]],
                             @"viewsNumber":@[[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:45.0], [UIColor whiteColor]],
                             @"viewsText":@[[UIFont fontWithName:@"HelveticaNeue" size:20.0], [UIColor whiteColor]],
                             
                             @"bonusOddsNumber":@[[UIFont fontWithName:@"HelveticaNeue-Bold" size:50.0], [Colors_Modal getUIColorForContentLabel_1]],
                             @"wantMoreLink":[WPAttributedStyleAction styledActionWithAction:^{
                                 
                                 UIViewController *myViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"InviteScreen"];
                                 [self.navigationController pushViewController:myViewController animated:YES];
                             }],
                             @"link":@[ [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:40.0], @{NSUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle|kCTUnderlinePatternSolid)}]
                            };
}

@end

