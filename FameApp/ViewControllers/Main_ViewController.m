//
//  Main_ViewController.m
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Main_ViewController.h"

int dt;


@interface Main_ViewController ()
@end


@implementation Main_ViewController

@synthesize userImageView, userDisplayName, contentView;
@synthesize niceButton, skipButton, bidPostButton;
@synthesize oddsLabel, oddsBonusLabel, inviteFriendsButton;  // TODO: need to use 'oddsBonusLabel' & 'oddsLabel' with reply from server
@synthesize timerController, timerPercentCount, timer, timerFinishSeconds;
@synthesize popup, popupStatus;


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initLocationService];
    
    // logo image on top of the navigation bar
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,0,40)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = NO;
    imageView.image = [UIImage imageNamed:@"Logo"];
    self.navigationItem.titleView = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    
    [self setSkipButtonStatus:NO];
    
    [self initSubViews];
    [self initTimerView];
}

- (void)viewDidAppear:(BOOL)animated {  // TODO: DEBUG - REMOVE
    
    [super viewDidAppear:animated];
    
    [self startTimer:0 finishSeconds:15];  // TODO: DEBUG - REMOVE
}

#pragma mark - Subviews init by device type
- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [[self.view viewWithTag:2000] setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    
    [niceButton setBackgroundColor:[Colors_Modal getUIColorForMain_5]];
    [bidPostButton setBackgroundColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    
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
    
    [UIHelper addShadowToView:niceButton];
    [UIHelper addShadowToView:skipButton];
    
    if (dt != IPHONE_4x) {
        
        [UIHelper addShadowToView:bidPostButton];
    }
}

- (void)initSubViews_iPhone6Plus {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 414, 512);
    userImageView.frame = CGRectMake(20, 10, 70, 70);
    userDisplayName.frame = CGRectMake(100, 30, 184, 42);
    [self.view viewWithTag:1001].frame = CGRectMake(319, 67, 87, 21);
    contentView.frame = CGRectMake(10, 87, 394, 394);
    niceButton.frame = CGRectMake(40, 431, 150, 40);
    skipButton.frame = CGRectMake(224, 431, 150, 40);
    [self.view viewWithTag:1002].frame = CGRectMake(238, 433, 35, 35);
    
    [self.view viewWithTag:2000].frame = CGRectMake(0, 576-64, 414, 160);
    [self.view viewWithTag:2001].frame = CGRectMake(39, 95, 144, 58);
    [self.view viewWithTag:2002].frame = CGRectMake(205, 95, 175, 58);
    [self.view viewWithTag:2003].frame = CGRectMake(90, 20, 235, 62);
}

- (void)initSubViews_iPhone6 {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 375, 476);
    userImageView.frame = CGRectMake(20, 10, 50, 50);
    userDisplayName.frame = CGRectMake(76, 16, 184, 42);
    [self.view viewWithTag:1001].frame = CGRectMake(280, 45, 87, 21);
    contentView.frame = CGRectMake(8, 65, 360, 360);
    niceButton.frame = CGRectMake(40, 378, 130, 40);
    skipButton.frame = CGRectMake(207, 378, 130, 40);
    [self.view viewWithTag:1002].frame = CGRectMake(217, 381, 35, 35);
    
    [self.view viewWithTag:2000].frame = CGRectMake(0, 506-64, 375, 161);
    [self.view viewWithTag:2001].frame = CGRectMake(16, 98, 144, 58);
    [self.view viewWithTag:2002].frame = CGRectMake(190, 98, 175, 58);
    [self.view viewWithTag:2003].frame = CGRectMake(69, 25, 235, 62);
}

- (void)initSubViews_iPhone5x {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 320, 446);
    userImageView.frame = CGRectMake(20, 10, 50, 50);
    userDisplayName.frame = CGRectMake(76, 16, 184, 42);
    [self.view viewWithTag:1001].frame = CGRectMake(225, 45, 87, 21);
    contentView.frame = CGRectMake(10, 65, 300, 300);
    niceButton.frame = CGRectMake(20, 320, 130, 40);
    skipButton.frame = CGRectMake(170, 320, 130, 40);
    [self.view viewWithTag:1002].frame = CGRectMake(178, 323, 35, 35);
    
    [self.view viewWithTag:2000].frame = CGRectMake(0, 441-64, 320, 160);
    [self.view viewWithTag:2001].frame = CGRectMake(8, 72, 144, 58);
    [self.view viewWithTag:2002].frame = CGRectMake(146, 73, 175, 58);
    [self.view viewWithTag:2003].frame = CGRectMake(43, 8, 235, 62);
}

- (void)initSubViews_iPhone4x {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 320, 446);
    userImageView.frame = CGRectMake(6, 1, 30, 30);
    userDisplayName.frame = CGRectMake(44, 2, 184, 26);
    [self.view viewWithTag:1001].frame = CGRectMake(225, 14, 87, 21);
    contentView.frame = CGRectMake(25, 33, 270, 270);
    niceButton.frame = CGRectMake(29, 258, 116, 40);
    skipButton.frame = CGRectMake(174, 258, 116, 40);
    [self.view viewWithTag:1002].frame = CGRectMake(182, 261, 35, 35);
    
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
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(timerInverval:) userInfo:nil repeats:YES];
    timerFinishSeconds = finishSeconds;
    timerPercentCount = startSeconds;
    [timerController startWithBlock:^CGFloat {
        
        return timerPercentCount / 100;
    }];
}

- (void)timerInverval:(NSTimer *)aTimer {
    
    timerPercentCount += 100/(CGFloat)timerFinishSeconds/10;
    
    if (timerPercentCount >= 100) {
        [timer invalidate];
        timer = nil;
    }
    else if ((timerPercentCount > 25) && ([skipButton isEnabled] == NO)) {
        
        [self setSkipButtonStatus:YES];
    }
}

- (void)didUpdateProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    if (percentage >= 1) {
        
        [progressTimer stop];
    }
}

- (void)didStopProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    NSLog(@"TIMER DONE.");
    
    // TODO: need to prepare new data before the TIMER is DONE.
    
    
    [self setSkipButtonStatus:NO];
    [self nextContent];
}

-(void)nextContent {  // TODO: incomplete
    
    UIView *aView = [self.view viewWithTag:1000];
    
    //fade out
    [UIView animateWithDuration:1.5f animations:^{
        
        [aView setAlpha:0.2f];
        
    } completion:^(BOOL finished) {
        
        // TODO: set next content and related info:
        // TODO:    1. content image (pre-loaded)
        // TODO:    2. user image (pre-loaded)
        // TODO:    3. user displayname.
        
        [contentView setImage:[UIImage imageNamed:@"Tests"]];  // TODO: DEBUG value
        
        // TODO: restart the TIMER
        [self startTimer:0 finishSeconds:15];  // TODO: DEBUG - example - need to use real values
        
        //fade in
        [UIView animateWithDuration:0.5f animations:^{
            
            [aView setAlpha:1.0f];
            
        } completion:nil];
        
    }];
}

- (void)setSkipButtonStatus:(BOOL)newStatus {
    
    if (newStatus) {
        
        [skipButton setEnabled:YES];
        [skipButton setAlpha:1.0f];
    }
    else {
        
        [skipButton setEnabled:NO];
        [skipButton setAlpha:0.7f];
    }
}

- (IBAction)skipButtonPressed:(id)sender {
    
    NSLog(@"SKIP PRESSED.");
    
    // once the timerController stops
    // it triggers the 'didStopProgressTimer' method.
    [timer invalidate];
    timer = nil;
    [timerController stop];

}

- (IBAction)niceButtonPressed:(id)sender {  // TODO: incomplete
    
    NSLog(@"NICE PRESSED.");
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
    DLRadioButton *radio1 = [[DLRadioButton alloc] initWithFrame:CGRectMake(15, 65, 280, 30)];
    radio1.buttonSideLength = 30;
    radio1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    [radio1 setTitle:@"Illegal content\n(drugs, underage nudity, etc.)" forState:UIControlStateNormal];
    radio1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [radio1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    radio1.circleColor = [UIColor whiteColor];
    radio1.indicatorColor = [UIColor whiteColor];
    radio1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [popupView addSubview:radio1];
    
    DLRadioButton *radio2 = [[DLRadioButton alloc] initWithFrame:CGRectMake(15, 105, 280, 30)];
    radio2.buttonSideLength = 30;
    radio2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    [radio2 setTitle:@"Pornography" forState:UIControlStateNormal];
    [radio2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    radio2.circleColor = [UIColor whiteColor];
    radio2.indicatorColor = [UIColor whiteColor];
    radio2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [popupView addSubview:radio2];
    
    DLRadioButton *radio3 = [[DLRadioButton alloc] initWithFrame:CGRectMake(15, 145, 280, 30)];
    radio3.buttonSideLength = 30;
    radio3.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    [radio3 setTitle:@"It's Spam !!" forState:UIControlStateNormal];
    [radio3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    radio3.circleColor = [UIColor whiteColor];
    radio3.indicatorColor = [UIColor whiteColor];
    radio3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
    [popupView addSubview:radio4];
    
    NSMutableArray *otherRadioButtons = [[NSMutableArray alloc] init];
    [otherRadioButtons addObject:radio2];
    [otherRadioButtons addObject:radio3];
    [otherRadioButtons addObject:radio4];
    radio1.otherButtons = otherRadioButtons;
    
    
    // message from user
    UITextView *msgField = [[UITextView alloc] initWithFrame:CGRectMake(30, 225, 240, 50)];
    msgField.delegate = self;
    [popupView addSubview:msgField];
    
    
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
}

- (void)reportButtonPressed_reportThis:(UIButton *)aButton {
    
    [popup dismiss:YES];
    
    
    // TODO: collect:
    // TODO:    1. selected radio button value.
    // TODO:    2. msg from user
    // TODO:    3. reported content ID.
    
    // TODO: send to server
    // TODO:    - once the server replies show PopupStatus:
    [self showStatusPopup:YES message:@"Content reported.\nThank you."];
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
                AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appDelegateInst.lastLocation = currentLocation;
            }
            else if (status == INTULocationStatusTimedOut) {
                // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                // However, currentLocation contains the best location available (if any) as of right now,
                // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
            }
            else {
                // An error occurred, more info is available by looking at the specific status returned.
                
                NSLog(@"LOC ERROR 2");  // TODO: need to try again, next time the app opens
            }
        }];
}

@end


