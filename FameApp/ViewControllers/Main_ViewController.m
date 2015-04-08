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

@synthesize contentView;
@synthesize niceButton, skipButton, bidPostButton;


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















