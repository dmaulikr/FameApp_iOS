//
//  Main_ViewController.m
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Main_ViewController.h"

#import "DataStorageHelper.h"  // TODO:
#import "UserInfo.h" // TODO:

int dt;


@interface Main_ViewController ()
@end


@implementation Main_ViewController

@synthesize contentView;
@synthesize niceButton, skipButton, bidPostButton;
@synthesize timerController, timerPercentCount, timer, timerFinishSeconds;
@synthesize popup;


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    // DEBUG
//    NSLog(@"%@", [DataStorageHelper getLoginUserInfo]);
//    
//    NSString *TEMP = [DataStorageHelper testCreate];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL"
//                                                    message:TEMP
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    
    [self initSubViews];
    [self initTimerView];
}

- (void)viewDidAppear:(BOOL)animated {  // TODO: DEBUG - REMOVE
    
    [super viewDidAppear:animated];
    
    [self startTimer:0 finishSeconds:15];
}

#pragma mark - Subviews init by device type
- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [[self.view viewWithTag:1000] setBackgroundColor:[Colors_Modal getUIColorForMain_2]];
    [[self.view viewWithTag:2000] setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    
    [niceButton setBackgroundColor:[Colors_Modal getUIColorForMain_5]];
    [bidPostButton setBackgroundColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    
    [UIHelper addShadowToView:niceButton];
    [UIHelper addShadowToView:skipButton];
    [UIHelper addShadowToView:bidPostButton];
    
    
    dt = [DeviceTypeHelper getDeviceType];
    
    if (dt == IPHONE_6) {
        
        [self initSubViews_iPhone6];
    }
}

- (void)initSubViews_iPhone6 {  // TODO: incomplete
    
//    [self.view viewWithTag:1000].frame = CGRectMake(5, 69, 365, 476);
//    [self.view viewWithTag:1001].frame = CGRectMake(10, 57, 345, 336);
//    
//    [self.view viewWithTag:2000].frame = CGRectMake(5, 544, 365, 122);
}

#pragma mark - Timer related
- (void)initTimerView {
    
    timerController = [[KKProgressTimer alloc] initWithFrame:[self.view viewWithTag:1002].frame];
    [self.view addSubview:timerController];
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
}

- (void)didUpdateProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    if (percentage >= 1) {
        [progressTimer stop];
    }
}

- (void)didStopProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    NSLog(@"TIMER DONE.");
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
    
    // TODO: incomplete
    NSLog(@"report now pressed");
    
    
    // TODO: collect:
    // TODO:    1. selected radio button value.
    // TODO:    2. msg from user
    // TODO:    3. reported content ID.
    
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

@end















