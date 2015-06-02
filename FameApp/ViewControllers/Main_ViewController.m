//
//  Main_ViewController.m
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Main_ViewController.h"

static int const REASON_TO_SHOW_NEXT_CONTENT__SKIP__NICE = 0;
static int const REASON_TO_SHOW_NEXT_CONTENT__SKIP__NOT_NICE = 1;
static int const REASON_TO_SHOW_NEXT_CONTENT__REGULAR = 2;
int dt;

// FIXME: short cache is not released  ???

// FIXME: on reply from App API methods: each reply method should handle NSNull by replacing it with a value that the app can handle without crashing, or getting stuck.

@interface Main_ViewController ()
@end


@implementation Main_ViewController

@synthesize appDelegateInst;
@synthesize appTimeOffset, contentQueue_1, contentQueue_2, isMainQueue_1;
@synthesize labelAttributeStyle1, currentContent_postId;
@synthesize userImageView, userInfoLabel, contentImageView;
@synthesize niceButton, skipButton, bidPostButton;
@synthesize oddsLabel, oddsBonusLabel, inviteFriendsButton;
@synthesize timerController, timerPercentCount, timer, timerFinishSeconds;
@synthesize isReachedTimerOnLastMoments, reasonToShowNextContent, seenTimeBeforeSkipped_mSec;
@synthesize popup, radio1, reportMsgField, popupStatus;


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // init the content Queues
    contentQueue_1 = [[DKQueue alloc] init];
    contentQueue_2 = [[DKQueue alloc] init];
    isMainQueue_1 = YES;
    
    [self callGetContent];
    reasonToShowNextContent = REASON_TO_SHOW_NEXT_CONTENT__REGULAR;
    [self showNextContent:YES becauseType:reasonToShowNextContent];
    
    [self initLocationService];
    
    // logo image on top of the navigation bar
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,0,40)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = NO;
    imageView.image = [UIImage imageNamed:@"TextLogo_Black"];
    self.navigationItem.titleView = imageView;
    
    
    [self initSubViews];
    
    [self setSkipButtonStatus:NO];
    
    [self initVotingGestures];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

#pragma mark - Subviews init by device type
- (void)initSubViews {
    
    [self initBiddingAndBonusInfoViews];
    
    dt = [DeviceTypeHelper getDeviceType];
    
    if (dt == IPHONE_6PLUS) {
        
        [self initSubViews_iPhone6Plus];
    }
    else if (dt == IPHONE_6) {
        
        [self initSubViews_iPhone6];
    }
    else if (dt == IPHONE_5x) {
        
        [self initSubViews_iPhone5x];
    }
    else if (dt == IPHONE_4x) {
        
        [self initSubViews_iPhone4x];
    }
    
//    [UIHelper addShadowToView:niceButton];
//    [UIHelper addShadowToView:skipButton];
    
    if (dt != IPHONE_4x) {
        
        [UIHelper addShadowToView:bidPostButton];
    }
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [[self.view viewWithTag:2000] setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    [UIHelper setRoundedCornersCircleToView:userImageView];
    [((UILabel *)[self.view viewWithTag:3001]) setTextColor:[Colors_Modal getUIColorForNavigationBar_tintColor]];
    [((UILabel *)[self.view viewWithTag:3002]) setTextColor:[Colors_Modal getUIColorForNavigationBar_tintColor]];
    [((UILabel *)[self.view viewWithTag:3003]) setTextColor:[Colors_Modal getUIColorForNavigationBar_tintColor]];
    
    [niceButton setBackgroundColor:[Colors_Modal getUIColorForMain_5]];
    [UIHelper setRoundedCornersCircleToView:niceButton];
    [skipButton setBackgroundColor:[Colors_Modal getUIColorForMain_4]];
    [UIHelper setRoundedCornersCircleToView:skipButton];
    
    [bidPostButton setBackgroundColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    
    [self initUserInfoLabel];
    
    [self initTimerView];
    [self initViewForColorTransition];
    
    [self.view bringSubviewToFront:[self.view viewWithTag:2000]];
}

- (void)initSubViews_iPhone6Plus {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 414, 512);
    userImageView.frame = CGRectMake(20, 10, 70, 70);
    userInfoLabel.frame = CGRectMake(100, 30, 184, 42);
    [self.view viewWithTag:1001].frame = CGRectMake(319, 67, 87, 21);
    contentImageView.frame = CGRectMake(10, 87, 394, 394);
    niceButton.frame = CGRectMake(368, 234, 100, 100);
    skipButton.frame = CGRectMake(-53, 234, 100, 100);
    [self.view viewWithTag:1002].frame = CGRectMake(359, 97, 35, 35);
    
    [self.view viewWithTag:2000].frame = CGRectMake(0, 576-64, 414, 160);
    [self.view viewWithTag:2001].frame = CGRectMake(39, 95, 144, 58);
    [self.view viewWithTag:2002].frame = CGRectMake(205, 95, 175, 58);
    [self.view viewWithTag:2003].frame = CGRectMake(90, 20, 235, 62);
}

- (void)initSubViews_iPhone6 {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 375, 476);
    userImageView.frame = CGRectMake(20, 10, 50, 50);
    userInfoLabel.frame = CGRectMake(76, 16, 184, 42);
    [self.view viewWithTag:1001].frame = CGRectMake(280, 45, 87, 21);
    contentImageView.frame = CGRectMake(8, 65, 360, 360);
    niceButton.frame = CGRectMake(329, 195, 100, 100);
    skipButton.frame = CGRectMake(-53, 195, 100, 100);
    [self.view viewWithTag:1002].frame = CGRectMake(323, 75, 35, 35);
    
    [self.view viewWithTag:2000].frame = CGRectMake(0, 506-64, 375, 161);
    [self.view viewWithTag:2001].frame = CGRectMake(16, 98, 144, 58);
    [self.view viewWithTag:2002].frame = CGRectMake(190, 98, 175, 58);
    [self.view viewWithTag:2003].frame = CGRectMake(69, 25, 235, 62);
}

- (void)initSubViews_iPhone5x {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 320, 446);
    userImageView.frame = CGRectMake(20, 10, 50, 50);
    userInfoLabel.frame = CGRectMake(76, 16, 184, 42);
    [self.view viewWithTag:1001].frame = CGRectMake(225, 45, 87, 21);
    contentImageView.frame = CGRectMake(10, 65, 300, 300);
    niceButton.frame = CGRectMake(274, 165, 100, 100);
    skipButton.frame = CGRectMake(-53, 165, 100, 100);
    [self.view viewWithTag:1002].frame = CGRectMake(265, 75, 35, 35);
    
    [self.view viewWithTag:2000].frame = CGRectMake(0, 441-64, 320, 160);
    [self.view viewWithTag:2001].frame = CGRectMake(8, 72, 144, 58);
    [self.view viewWithTag:2002].frame = CGRectMake(146, 73, 175, 58);
    [self.view viewWithTag:2003].frame = CGRectMake(43, 8, 235, 62);
}

- (void)initSubViews_iPhone4x {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 320, 446);
    userImageView.frame = CGRectMake(6, 1, 30, 30);
    userInfoLabel.frame = CGRectMake(44, 2, 184, 26);
    [self.view viewWithTag:1001].frame = CGRectMake(225, 14, 87, 21);
    contentImageView.frame = CGRectMake(25, 33, 270, 270);
    niceButton.frame = CGRectMake(274, 118, 100, 100);
    skipButton.frame = CGRectMake(-53, 118, 100, 100);
    [self.view viewWithTag:1002].frame = CGRectMake(250, 43, 35, 35);
    
    [self.view viewWithTag:2000].frame = CGRectMake(0, 370-64, 320, 160);
    [self.view viewWithTag:2001].frame = CGRectMake(8, 59, 144, 58);
    [self.view viewWithTag:2002].frame = CGRectMake(146, 60, 175, 58);
    [self.view viewWithTag:2003].frame = CGRectMake(43, 4, 235, 62);
}

#pragma mark - Timer related
- (void)initTimerView {
    
    timerController = [[KKProgressTimer alloc] initWithFrame:[self.view viewWithTag:1002].frame];
    [[self.view viewWithTag:1000] addSubview:timerController];
    timerController.delegate = self;
}

- (void)startTimer:(NSInteger)startSeconds finishSeconds:(NSInteger)finishSeconds {
    
    if (timer != nil) {
        [timer invalidate];
    }
    seenTimeBeforeSkipped_mSec = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(contentTimerInverval:) userInfo:nil repeats:YES];
    timerFinishSeconds = finishSeconds;
    timerPercentCount = startSeconds / (CGFloat)finishSeconds * 100;
    [timerController startWithBlock:^CGFloat {
        
        return timerPercentCount / 100;
    }];
}

- (void)stopTimer {
    
    [timer invalidate];
    timer = nil;
    [timerController stop];
    
    isReachedTimerOnLastMoments = NO;
}

- (void)contentTimerInverval:(NSTimer *)aTimer {
    
    seenTimeBeforeSkipped_mSec += aTimer.timeInterval * 1000;
    
    timerPercentCount += 100/(CGFloat)timerFinishSeconds/10;
    
    if (timerPercentCount >= 100) {
        
        reasonToShowNextContent = REASON_TO_SHOW_NEXT_CONTENT__REGULAR;
        [self stopTimer];
    }
    
    if ((timerPercentCount > 25) && ([skipButton isEnabled] == NO)) {
        
        [self setSkipButtonStatus:YES];
    }
    
    if ((timerPercentCount > 75) && (isReachedTimerOnLastMoments == NO)) {
        
        isReachedTimerOnLastMoments = YES;
        
        // call only if we are currently on the last content
        DKQueue *mainQueue = (isMainQueue_1) ? contentQueue_1 : contentQueue_2;
        if ([mainQueue size] == 0) {
            [self callGetContent];
        }
    }
}

- (void)didUpdateProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    if (percentage >= 1) {
        
        [progressTimer stop];
    }
}

- (void)didStopProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    NSLog(@"TIMER DONE.");
    
    // continue the cycle only if there is a login user
    if (appDelegateInst.loginUser != nil) {
        
        [self showNextContent:NO becauseType:reasonToShowNextContent];
        reasonToShowNextContent = REASON_TO_SHOW_NEXT_CONTENT__REGULAR;
        
        [self setSkipButtonStatus:NO];
        [self getBiddingInfo];
    }
}


#pragma mark - Channel related
- (void)initBiddingAndBonusInfoViews {
    
    if (appDelegateInst.myBiddingAndBonusInfo == nil) {
        
        [[self.view viewWithTag:2001] setHidden:YES];
        [[self.view viewWithTag:2002] setHidden:YES];
    }
    else {
        
        [oddsLabel setText:appDelegateInst.myBiddingAndBonusInfo.winningOdds];
        [oddsBonusLabel setText:[FormattingHelper formatLabelTextForCurrentOddBonus:appDelegateInst.myBiddingAndBonusInfo.bonusOdds]];
        
        [[self.view viewWithTag:2001] setHidden:[appDelegateInst.myBiddingAndBonusInfo.winningOdds isEqualToString:@""]];
        [[self.view viewWithTag:2002] setHidden:[appDelegateInst.myBiddingAndBonusInfo.bonusOdds isEqualToString:@""]];
    }
    
    [self getBiddingInfo];
}

- (void)getBiddingInfo {
    
    // continue the cycle only if there is a login user
    if (appDelegateInst.loginUser != nil) {
    
        AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
        operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSArray *postReqInfo = [AppAPI_Channel_Modal requestContruct_BiddingInfo];
        
        NSLog(@"App API - Request: Channel Bidding Info");
        [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"App API - Reply: Channel Bidding Info [SUCCESS]");
                   
                   NSDictionary *repDict = [AppAPI_Channel_Modal processReply_BiddingInfo:responseObject];
                   
                   if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                       
                       BiddingAndBonusInfo *aBiddingAndBonusInfo = [DataStorageHelper getBiddingAndBonusInfo:appDelegateInst.loginUser.userId];
                       if (aBiddingAndBonusInfo == nil) {
                           
                           aBiddingAndBonusInfo = [[BiddingAndBonusInfo alloc] init];
                       }
                       aBiddingAndBonusInfo.winningOdds = [repDict objectForKey:@"winOdds"];
                       aBiddingAndBonusInfo.bonusOdds = [repDict objectForKey:@"bonusOdds"];
                       
                       [DataStorageHelper setBiddingAndBonusInfo:aBiddingAndBonusInfo];
                       
                       [[self.view viewWithTag:2001] setHidden:[aBiddingAndBonusInfo.winningOdds isEqualToString:@""]];
                       [[self.view viewWithTag:2002] setHidden:[aBiddingAndBonusInfo.bonusOdds isEqualToString:@""]];
                       
                       if ([oddsLabel.text isEqualToString:aBiddingAndBonusInfo.winningOdds] == NO) {
                           
                           [oddsLabel setText:appDelegateInst.myBiddingAndBonusInfo.winningOdds];
                           
                           CGAffineTransform transform_oddsLabel = oddsLabel.transform;
                           [UIView animateWithDuration:1.0 animations:^{
                               
                               oddsLabel.transform = CGAffineTransformScale(oddsLabel.transform, 1.3, 1.3);
                           }
                           completion:^(BOOL finished) {
                               
                               [UIView animateWithDuration:0.8 animations:^{
                                   
                                   oddsLabel.transform = transform_oddsLabel;
                               }];
                           }];
                       }
                       
                       if ([oddsBonusLabel.text isEqualToString:aBiddingAndBonusInfo.bonusOdds] == NO) {
                           
                           [oddsBonusLabel setText:appDelegateInst.myBiddingAndBonusInfo.bonusOdds];
                           
                           CGAffineTransform transform_oddsBonusLabel = oddsBonusLabel.transform;
                           [UIView animateWithDuration:1.0 animations:^{
                               
                               oddsBonusLabel.transform = CGAffineTransformScale(oddsBonusLabel.transform, 1.3, 1.3);
                           }
                           completion:^(BOOL finished) {
                               
                               [UIView animateWithDuration:0.8 animations:^{
                                   
                                   oddsBonusLabel.transform = transform_oddsBonusLabel;
                               }];
                           }];
                       }
                       
                   }
                   
               } // End of Request 'Success'
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   NSLog(@"App API - Reply: Channel Bidding Info [FAILURE]");
                   NSLog(@"%@", error);
                   
                   // do nothing
                   
               } // End of Request 'Failure'
        ];
    }
}

- (void)callGetContent {
    
    // continue the cycle only if there is a login user
    if (appDelegateInst.loginUser != nil) {
        
        AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
        operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSArray *postReqInfo = [AppAPI_Channel_Modal requestContruct_GetContent];
        
        NSLog(@"App API - Request: Channel Get Content");
        [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"App API - Reply: Channel Get Content [SUCCESS]");
                   
                   NSDictionary *repDict = [AppAPI_Channel_Modal processReply_GetContent:responseObject];
                   
                   if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                       
                       // empty the skipQueue
                       DKQueue *skipQueue = (isMainQueue_1 == NO) ? contentQueue_1 : contentQueue_2;
                       [skipQueue clear];
                       
                       [self setAppTimeOffset:[[repDict objectForKey:@"serverTime"] integerValue]];
                       
                       [self pushContentsListsToQueuesAndCacheImages:[repDict objectForKey:@"biddingsMain"] skipContentList:[repDict objectForKey:@"biddingsSkip"]];
                   }
                   else {
                       
                       // TODO: what to do with the ERROR ??
                   }
                   
               } // End of Request 'Success'
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   NSLog(@"App API - Reply: Channel Get Content [FAILURE]");
                   NSLog(@"%@", error);
                   
                   // TODO: what to do with the ERROR ??
                   
               } // End of Request 'Failure'
        ];
    }
}

- (void)callSkipWithActionType:(int)actionType timerPoint:(long)timerPoint postId:(NSString *)postId {
    
    // continue the cycle only if there is a login user
    if (appDelegateInst.loginUser != nil) {
        
        AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
        operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSArray *postReqInfo = [AppAPI_Channel_Modal requestContruct_Skip:postId timerPoint:timerPoint actionType:actionType];
        
        NSLog(@"App API - Request: Channel Skip");
        [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"App API - Reply: Channel Skip [SUCCESS]");
                   
                   NSDictionary *repDict = [AppAPI_Channel_Modal processReply_Skip:responseObject];
                   
                   if ([[repDict objectForKey:@"statusCode"] intValue] == 0) {
                       
                       [self setAppTimeOffset:[[repDict objectForKey:@"serverTime"] integerValue]];
                       
                       [self pushContentsListsToQueuesAndCacheImages:[repDict objectForKey:@"biddingsMain"] skipContentList:[repDict objectForKey:@"biddingsSkip"]];
                   }
                   else {
                       
                       // TODO: what to do with the ERROR ??
                   }
                   
               } // End of Request 'Success'
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   NSLog(@"App API - Reply: Channel Skip [FAILURE]");
                   NSLog(@"%@", error);
                   
                   // TODO: what to do with the ERROR ??
                   
               } // End of Request 'Failure'
        ];
    }
}

- (void)pushContentsListsToQueuesAndCacheImages:(NSArray *)mainContentList skipContentList:(NSArray *)skipContentList {
    
    DKQueue *mainQueue = (isMainQueue_1 == YES) ? contentQueue_1 : contentQueue_2;
    DKQueue *skipQueue = (isMainQueue_1 == NO) ? contentQueue_1 : contentQueue_2;
    
    for (int i=0; i<[mainContentList count]; i++) {
    
        NSDictionary *aContentObj = [mainContentList objectAtIndex:i];
        [mainQueue enqueue:aContentObj];
        
        [URLHelper preloadImageWithShortCache:[aContentObj objectForKey:@"userImageUrl"]];
        [URLHelper preloadImageWithShortCache:[aContentObj objectForKey:@"contentUrl"]];
    }
    
    for (int i=0; i<[skipContentList count]; i++) {
    
        NSDictionary *aContentObj = [skipContentList objectAtIndex:i];
        [skipQueue enqueue:aContentObj];
        
        [URLHelper preloadImageWithShortCache:[aContentObj objectForKey:@"userImageUrl"]];
        [URLHelper preloadImageWithShortCache:[aContentObj objectForKey:@"contentUrl"]];
    }
}

- (void)setAppTimeOffset:(NSInteger)serverTime_msec {
    
    NSInteger nowTime_msec = (NSInteger)([[NSDate date] timeIntervalSince1970] * 1000);
    appTimeOffset = nowTime_msec - serverTime_msec;
    
//    NSLog(@">>>>>OFFSET: %ld", (long)appTimeOffset);  // TODO: DEBUG - REMOVE
}

- (NSInteger)getAdjustedAppTime {
    
    NSInteger nowTime_msec = (NSInteger)([[NSDate date] timeIntervalSince1970] * 1000);
    return (nowTime_msec - appTimeOffset);
}

- (void)showNextContent:(BOOL)isFirstUse becauseType:(int)becauseType {
    
    // open & then close, transitions
    if (isFirstUse == NO) {
        
        [self colorTransitionBetweenContents_CloseType:becauseType completion:^(void) {
            
            [self setContentViews:YES becauseType:becauseType attemptCount:0];
        }];
    }
    // only the open transition
    else {
        
        [self setContentViews:YES becauseType:becauseType attemptCount:0];
    }
}

- (void)setContentViews:(BOOL)animated becauseType:(int)becauseType attemptCount:(int)attemptCount {
    
    NSLog(@"SET CONTENT VIEWS");  // TODO: DEBUG - REMOVE
    
    
    // for when the logout was called
    if (appDelegateInst.loginUser == nil) {
        
        [timer invalidate];
        timer = nil;
        
        return;
    }
    
    NSDictionary *currentContent = nil;
    
    // use main Queue
    if (becauseType == REASON_TO_SHOW_NEXT_CONTENT__REGULAR) {
        
        DKQueue *mainQueue = (isMainQueue_1) ? contentQueue_1 : contentQueue_2;
        currentContent = [mainQueue dequeue];
    }
    // use the other Queue, and swap their roles
    else {
        
        DKQueue *mainQueue = (isMainQueue_1) ? contentQueue_1 : contentQueue_2;
        [mainQueue clear];
        
        isMainQueue_1 = !isMainQueue_1;
        
        mainQueue = (isMainQueue_1) ? contentQueue_1 : contentQueue_2;
        currentContent = [mainQueue dequeue];
    }
    
    // verify 'currentContent' is not nil.
    if (currentContent == nil) {
        
        // if after 5 retries there is nothing in the queue, call get content
        if (attemptCount == 5) {
            
            attemptCount = -1;
            [self callGetContent];
        }
        
        int64_t delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self setContentViews:animated becauseType:becauseType attemptCount:attemptCount+1];
        });
        
        return;
    }
    
//    // TODO: DEBUG - REMOVE
//    NSLog(@"NOW POST_ID:  %@", currentContent_postId);
//    NSLog(@"NEXT POST_ID: %@", [currentContent objectForKey:@"postId"]);
    
    
    currentContent_postId = [currentContent objectForKey:@"postId"];
    NSString *currentContent_imageURL = [currentContent objectForKey:@"contentUrl"];
    NSString *currentContent_userId = [currentContent objectForKey:@"userId"];
    NSString *currentContent_userDisplayName = [currentContent objectForKey:@"userDisplayName"];
    NSString *currentContent_userImageURL = [currentContent objectForKey:@"userImageUrl"];
    
    NSLog(@"\t\t\tUSER_ID: %@", currentContent_userId);
    NSLog(@"\t\t\tPOST:    %@", currentContent_postId);
    NSLog(@"\t\t\tCONTENT: %@", currentContent_imageURL);
    
    
    // adjust start time to match elapse time since we queued the content to nowTime.
    long nowTime_msec = [self getAdjustedAppTime];
    NSInteger currentContent_timerStart_msec = nowTime_msec - [[currentContent objectForKey:@"timerStart"] integerValue];
    NSInteger currentContent_timerDuration_msec = [[currentContent objectForKey:@"timerDuration"] integerValue];
    
//    // TODO: DEBUG - REMOVE
//    NSLog(@"NOW APP:  %ld", (long)([[NSDate date] timeIntervalSince1970] * 1000));
//    NSLog(@"NOW REAL: %ld", [self getAdjustedAppTime]);
//    NSLog(@"START:    %ld", [[currentContent objectForKey:@"timerStart"] integerValue]);
//    NSLog(@"START:    %ld", currentContent_timerStart_msec);
//    NSLog(@"DURATION: %ld", currentContent_timerDuration_msec);
//    
    // protection against irrelevant content
    if (currentContent_timerStart_msec >= currentContent_timerDuration_msec) {
        
        NSLog(@"IRRELEVANT CONTENT!!! FLUSHING QUEUES... CALLING GET CONTENT...");  // TODO: DEBUG - REMOVE
        
        [contentQueue_1 clear];
        [contentQueue_2 clear];
        
        [self callGetContent];
        
        int64_t delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self setContentViews:animated becauseType:becauseType attemptCount:0];
        });
        
        return;
    }
    
    
    [URLHelper setImageWithShortCache:currentContent_imageURL imageView:contentImageView placeholderImageName:nil];
    [URLHelper setImageWithShortCache:currentContent_userImageURL imageView:userImageView placeholderImageName:[PlaceholderImageHelper imageNameForUserProfile]];
    
    [self setUserInfoLabel:currentContent_userId userDisplayName:currentContent_userDisplayName];
    
    [self startTimer:currentContent_timerStart_msec/1000 finishSeconds:currentContent_timerDuration_msec/1000];
    
    // delay
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self colorTransitionBetweenContents_OpenType:becauseType completion:nil];
    });
}

- (void)setSkipButtonStatus:(BOOL)newStatus {
    
    if (newStatus) {
        
        [skipButton setEnabled:YES];
        [skipButton setAlpha:1.0f];
        
        [niceButton setEnabled:YES];
        [niceButton setAlpha:1.0f];
    }
    else {
        
        [skipButton setEnabled:NO];
//        [skipButton setAlpha:0.6f];  // TODO: what should be done when the button is disabled ???
        
        [niceButton setEnabled:NO];
//        [niceButton setAlpha:0.6f];  // TODO: what should be done when the button is disabled ???
    }
}

- (IBAction)niceButtonPressed:(id)sender {
    
    NSLog(@"NICE PRESSED.");
    
    reasonToShowNextContent = REASON_TO_SHOW_NEXT_CONTENT__SKIP__NICE;
    
    [self animateSkipAction:reasonToShowNextContent];
    
    // once the timerController stops
    // it triggers the 'didStopProgressTimer' method.
    [self stopTimer];
    
    [self callSkipWithActionType:REASON_TO_SHOW_NEXT_CONTENT__SKIP__NICE timerPoint:seenTimeBeforeSkipped_mSec postId:currentContent_postId];
}

- (IBAction)skipButtonPressed:(id)sender {
    
    NSLog(@"NOT NICE PRESSED.");
    
    reasonToShowNextContent = REASON_TO_SHOW_NEXT_CONTENT__SKIP__NOT_NICE;
    
    [self animateSkipAction:reasonToShowNextContent];
    
    // once the timerController stops
    // it triggers the 'didStopProgressTimer' method.
    [self stopTimer];
    
    [self callSkipWithActionType:REASON_TO_SHOW_NEXT_CONTENT__SKIP__NOT_NICE timerPoint:seenTimeBeforeSkipped_mSec postId:currentContent_postId];
}

#pragma mark - Color Transition related
- (void)initViewForColorTransition {
    
    UIView *aboveAllView = [[UIView alloc] initWithFrame:[self.view viewWithTag:1000].frame];
    aboveAllView.tag = 1234;
    [aboveAllView setUserInteractionEnabled:NO];
    [aboveAllView setBackgroundColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    [[self.view viewWithTag:1000] addSubview:aboveAllView];
    [[self.view viewWithTag:1000] bringSubviewToFront:aboveAllView];
}

/*!
 @param - type<br/>
 0 = close: skip with nice.<br/>
 1 = close: skip with not nice.<br/>
 2 = close: regular.
 */
- (void)colorTransitionBetweenContents_CloseType:(int)type completion:(void (^)(void))block {
    
    // close: skip with Nice
    if (type == REASON_TO_SHOW_NEXT_CONTENT__SKIP__NICE) {
        
        [[self.view viewWithTag:1000] bringSubviewToFront:[self.view viewWithTag:1234]];
        [[self.view viewWithTag:1000] bringSubviewToFront:niceButton];
        
        [[self.view viewWithTag:1234] mdInflateAnimatedFromPoint:niceButton.center backgroundColor:[Colors_Modal getUIColorForMain_5] duration:1.0 completion:block];
    }
    // close: skip with Not Nice
    else if (type == REASON_TO_SHOW_NEXT_CONTENT__SKIP__NOT_NICE) {
        
        [[self.view viewWithTag:1000] bringSubviewToFront:[self.view viewWithTag:1234]];
        [[self.view viewWithTag:1000] bringSubviewToFront:skipButton];
        
        [[self.view viewWithTag:1234] mdInflateAnimatedFromPoint:skipButton.center backgroundColor:[Colors_Modal getUIColorForMain_4] duration:1.0 completion:block];
    }
    // close: regular
    else if (type == REASON_TO_SHOW_NEXT_CONTENT__REGULAR) {
        
        [[self.view viewWithTag:1000] bringSubviewToFront:[self.view viewWithTag:1234]];
        
        [[self.view viewWithTag:1234] mdInflateAnimatedFromPoint:timerController.center backgroundColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor] duration:1.0 completion:block];
    }
}

/*!
 @param - type<br/>
 0 OR 1 = open: all skip related.<br/>
 2 = open: regular.
 */
- (void)colorTransitionBetweenContents_OpenType:(int)type completion:(void (^)(void))block {
    
    // open: skip with Nice
    if (type == REASON_TO_SHOW_NEXT_CONTENT__SKIP__NICE) {
        
        [[self.view viewWithTag:1234] mdDeflateAnimatedToPoint:niceButton.center backgroundColor:[UIColor clearColor] duration:0.5 completion:block];
    }
    // open: skip with Not Nice
    else if (type == REASON_TO_SHOW_NEXT_CONTENT__SKIP__NOT_NICE) {
        
        [[self.view viewWithTag:1234] mdDeflateAnimatedToPoint:skipButton.center backgroundColor:[UIColor clearColor] duration:0.5 completion:block];
    }
    // open: regular
    else if (type == REASON_TO_SHOW_NEXT_CONTENT__REGULAR) {
        
        [[self.view viewWithTag:1234] mdDeflateAnimatedToPoint:timerController.center backgroundColor:[UIColor clearColor] duration:0.5 completion:block];
    }
}

- (void)animateSkipAction:(int)type {
    
    if (type != REASON_TO_SHOW_NEXT_CONTENT__REGULAR) {
        
        UIButton *aButton = (type == REASON_TO_SHOW_NEXT_CONTENT__SKIP__NICE) ? niceButton : skipButton;
        
        CGAffineTransform saveTransform = aButton.transform;
        CGAffineTransform transform = CGAffineTransformMakeScale(2.5, 2.5);
        aButton.transform = transform;
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.35f initialSpringVelocity:0.3f options:UIViewAnimationOptionCurveEaseInOut
            animations:^{
                
                aButton.transform = saveTransform;
                
        } completion:nil];
    }
    
    
    
//    [UIView animateWithDuration:0.5f
//         animations:^{
//             
//             // move to the middle & grow
//             aButton.frame = CGRectOffset(aButton.frame, -100, 0);
//             aButton.transform = CGAffineTransformMakeScale(2, 2);
//             
//         }
//         completion:^(BOOL completed) {
//             
//             
//             
////             CGPoint origin = aButton.center;
////             CGPoint target = CGPointMake(aButton.center.x-10, aButton.center.y);
////             CABasicAnimation *bounce = [CABasicAnimation animationWithKeyPath:@"position.x"];
////             bounce.duration = 0.1f;
////             bounce.fromValue = [NSNumber numberWithInt:origin.x];
////             bounce.toValue = [NSNumber numberWithInt:target.x];
////             bounce.repeatCount = 3;
////             bounce.autoreverses = YES;
////             [niceButton.layer addAnimation:bounce forKey:@"position"];
//         }
//    ];

    
    
    
    
    
//    CGPoint origin = aButton.center;
//    CGPoint target = CGPointMake(aButton.center.x-10, aButton.center.y);
//    CABasicAnimation *bounce = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    bounce.duration = 0.05f;
//    bounce.fromValue = [NSNumber numberWithInt:origin.x];
//    bounce.toValue = [NSNumber numberWithInt:target.x];
//    bounce.repeatCount = 3;
//    bounce.autoreverses = YES;
//    [niceButton.layer addAnimation:bounce forKey:@"position"];
}

#pragma mark - User Info Label related
- (void)initUserInfoLabel {
    
    labelAttributeStyle1 = @{
        @"body":@[ [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0], [Colors_Modal getUIColorForNavigationBar_tintColor] ],
        @"userId":@[ [UIFont fontWithName:@"HelveticaNeue-Thin" size:13.0], [Colors_Modal getUIColorForNavigationBar_tintColor] ]
    };
    
    [userInfoLabel setTextAlignment:NSTextAlignmentLeft];
    [userInfoLabel setNumberOfLines:2];
}

- (void)setUserInfoLabel:(NSString *)userId userDisplayName:(NSString *)userDisplayName {
    
    if ([userDisplayName isEqualToString:@""]) {
        
        NSString *labelString = [NSString stringWithFormat:@"%@", userId];
        [userInfoLabel setAttributedText:[labelString attributedStringWithStyleBook:labelAttributeStyle1]];
    }
    else {
        
        NSString *labelString = [NSString stringWithFormat:@"%@\n<userId>%@</userId>", userDisplayName, userId];
        [userInfoLabel setAttributedText:[labelString attributedStringWithStyleBook:labelAttributeStyle1]];
    }
}

#pragma mark - Gesture related
- (void)initVotingGestures {
    
    // nice related swipes
    SHGestureRecognizerBlock niceSwipeBlock = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        NSLog(@"NICE SWIPE");
        
        [self niceButtonPressed:niceButton];
    };
    UISwipeGestureRecognizer *swipeNice_fromButton = [UISwipeGestureRecognizer SH_gestureRecognizerWithBlock:niceSwipeBlock];
    [swipeNice_fromButton setDirection:UISwipeGestureRecognizerDirectionLeft];
    [niceButton addGestureRecognizer:swipeNice_fromButton];
    
    UISwipeGestureRecognizer *swipeNice_fromContentImageView = [UISwipeGestureRecognizer SH_gestureRecognizerWithBlock:niceSwipeBlock];
    [swipeNice_fromContentImageView setDirection:UISwipeGestureRecognizerDirectionLeft];
    [contentImageView addGestureRecognizer:swipeNice_fromContentImageView];
    
    
    // skip related swipes
    SHGestureRecognizerBlock skipSwipeBlock = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        NSLog(@"NOT NICE SWIPE");
        
        [self skipButtonPressed:skipButton];
    };
    UISwipeGestureRecognizer *swipeSkip_fromButton = [UISwipeGestureRecognizer SH_gestureRecognizerWithBlock:skipSwipeBlock];
    [swipeSkip_fromButton setDirection:UISwipeGestureRecognizerDirectionRight];
    [skipButton addGestureRecognizer:swipeSkip_fromButton];
    
    UISwipeGestureRecognizer *swipeSkip_fromContentImageView = [UISwipeGestureRecognizer SH_gestureRecognizerWithBlock:skipSwipeBlock];
    [swipeSkip_fromContentImageView setDirection:UISwipeGestureRecognizerDirectionRight];
    [contentImageView addGestureRecognizer:swipeSkip_fromContentImageView];
}

#pragma mark - Camera related
- (IBAction)openCamera:(id)sender {
    
    YCameraViewController *camController = [[YCameraViewController alloc] initWithNibName:@"YCameraViewController" bundle:nil];
    camController.delegate = self;
    
    [self.navigationController pushViewController:camController animated:YES];
}

-(void)didFinishPickingImage:(UIImage *)image {  // NEVER USED
    // Use image as per your need
}

-(void)yCameraControllerdidSkipped {
    // Called when user clicks on Skip button on YCameraViewController view
}

-(void)yCameraControllerDidCancel {
    // Called when user clicks on "X" button to close YCameraViewController
}

#pragma mark - 'Report This?' related
- (IBAction)showReportThisPopup:(UIButton *)aButton {
    
    // stop timer on report. flush the queues.
    [timer invalidate];
    timer = nil;
    [contentQueue_1 clear];
    [contentQueue_2 clear];
    
    // Generate content view to present
    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 300 / 2, 50, 300, 370)];
    popupView.translatesAutoresizingMaskIntoConstraints = NO;
    popupView.backgroundColor = [Colors_Modal getUIColorForMain_1];
    popupView.layer.borderColor = [UIColor whiteColor].CGColor;
    popupView.layer.borderWidth = 3.0;
    popupView.layer.cornerRadius = 8.0;
    popupView.tag = 666;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280, 30)];
    label1.text = @"Report this post, because:";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    [popupView addSubview:label1];
    
    // radio buttons
    radio1 = [[DLRadioButton alloc] initWithFrame:CGRectMake(15, 65, 280, 30)];
    radio1.buttonSideLength = 30;
    radio1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    [radio1 setTitle:@"Illegal content\n(drugs, underage nudity, etc.)" forState:UIControlStateNormal];
    radio1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [radio1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    radio1.circleColor = [UIColor whiteColor];
    radio1.indicatorColor = [UIColor whiteColor];
    radio1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    radio1.tag = 66601;
    [popupView addSubview:radio1];
    
    DLRadioButton *radio2 = [[DLRadioButton alloc] initWithFrame:CGRectMake(15, 105, 280, 30)];
    radio2.buttonSideLength = 30;
    radio2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    [radio2 setTitle:@"Pornography" forState:UIControlStateNormal];
    [radio2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    radio2.circleColor = [UIColor whiteColor];
    radio2.indicatorColor = [UIColor whiteColor];
    radio2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    radio2.tag = 66602;
    [popupView addSubview:radio2];
    
    DLRadioButton *radio3 = [[DLRadioButton alloc] initWithFrame:CGRectMake(15, 145, 280, 30)];
    radio3.buttonSideLength = 30;
    radio3.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    [radio3 setTitle:@"It's Spam !!" forState:UIControlStateNormal];
    [radio3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    radio3.circleColor = [UIColor whiteColor];
    radio3.indicatorColor = [UIColor whiteColor];
    radio3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    radio3.tag = 66603;
    [popupView addSubview:radio3];
    
    DLRadioButton *radio4 = [[DLRadioButton alloc] initWithFrame:CGRectMake(15, 185, 280, 30)];
    radio4.buttonSideLength = 30;
    radio4.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    [radio4 setTitle:@"Something else (tell us more)" forState:UIControlStateNormal];
    [radio4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    radio4.circleColor = [UIColor whiteColor];
    radio4.indicatorColor = [UIColor whiteColor];
    radio4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radio4 setSelected:YES];
    radio4.tag = 66604;
    [popupView addSubview:radio4];
    
    NSMutableArray *otherRadioButtons = [[NSMutableArray alloc] init];
    [otherRadioButtons addObject:radio2];
    [otherRadioButtons addObject:radio3];
    [otherRadioButtons addObject:radio4];
    radio1.otherButtons = otherRadioButtons;
    
    
    // message from user
    reportMsgField = [[UITextView alloc] initWithFrame:CGRectMake(30, 225, 240, 50)];
    reportMsgField.delegate = self;
    [popupView addSubview:reportMsgField];
    
    
    // action buttons
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 310, 120, 40)];
    cancelButton.backgroundColor = [Colors_Modal getUIColorForMain_7];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    [cancelButton setTitle:@"Never Mind" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed_reportThis:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:cancelButton];
    
    UIButton *reportButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 310, 120, 40)];
    reportButton.backgroundColor = [Colors_Modal getUIColorForMain_4];
    reportButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
    [reportButton setTitle:@"Report Now!!" forState:UIControlStateNormal];
    [reportButton addTarget:self action:@selector(reportButtonPressed_reportThis:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:reportButton];
    
    
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

- (void)cancelButtonPressed_reportThis:(UIButton *)aButton {
    
    [popup dismiss:YES];
    
    // getContent. restart.
    [self callGetContent];
    [self stopTimer];
}

- (void)reportButtonPressed_reportThis:(UIButton *)aButton {
    
    [popup dismiss:YES];
    
    // getContent. restart.
    [self callGetContent];
    [self stopTimer];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *reasonString = radio1.selectedButton.titleLabel.text;
    NSString *msgFromUser = reportMsgField.text;
    
    NSArray *postReqInfo = [AppAPI_Report_Modal requestContruct_ReportContent:currentContent_postId reportReason:reasonString msg:msgFromUser];
    
    NSLog(@"App API - Request: Report Content");
    [operationManager POST:[postReqInfo objectAtIndex:0] parameters:[postReqInfo objectAtIndex:1]
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSLog(@"App API - Reply: Report Content [SUCCESS]");
               
               [self showStatusPopup:YES message:@"Content Reported.\nThank you."];
               
           } // End of Request 'Success'
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               NSLog(@"App API - Reply: Report Content [FAILURE]");
               NSLog(@"%@", error);
               
               [self showStatusPopup:YES message:@"Content Reported.\nThank you."];
               
           } // End of Request 'Failure'
    ];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect frame = popup.bounds;
    frame.origin.y += 130;
    popup.bounds = frame;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    CGRect frame = popup.bounds;
    frame.origin.y -= 130;
    popup.bounds = frame;
    [textView resignFirstResponder];
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

#pragma mark - Location Service related
- (void)initLocationService {
    
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.0 delayUntilAuthorized:YES
        block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            
            if (status == INTULocationStatusSuccess) {
                // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                // currentLocation contains the device's current location.
                
                // got a new location. save it.
                appDelegateInst.lastLocation = currentLocation;
            }
            else if (status == INTULocationStatusTimedOut) {
                // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                // However, currentLocation contains the best location available (if any) as of right now,
                // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
            }
            else {
                // An error occurred, more info is available by looking at the specific status returned.
                
                NSLog(@"LOC ERROR 2");  // TODO: LATER - need to try again, next time the app opens
            }
        }];
}

@end


