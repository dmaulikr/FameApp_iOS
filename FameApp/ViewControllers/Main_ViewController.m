//
//  Main_ViewController.m
//  FameApp
//
//  Created by Eldar on 3/29/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Main_ViewController.h"

#import "DataStorageHelper.h"

int dt;


@interface Main_ViewController ()
@end


@implementation Main_ViewController

@synthesize contentView;
@synthesize niceButton, skipButton, bidPostButton;
@synthesize timerController, timerPercentCount, timer, timerFinishSeconds;


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
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(timerInverval:) userInfo:nil repeats:YES];
    timerFinishSeconds = finishSeconds;
    timerPercentCount = startSeconds;
    [timerController startWithBlock:^CGFloat {
        
        return timerPercentCount / 100;
    }];
}

- (void)timerInverval:(NSTimer *)aTimer {
    
    timerPercentCount += 100/(CGFloat)timerFinishSeconds/10;
    
    if (timerPercentCount == 100) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)didUpdateProgressTimer:(KKProgressTimer *)progressTimer percentage:(CGFloat)percentage {
    
    NSLog(@"%f", percentage);
    
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


@end















