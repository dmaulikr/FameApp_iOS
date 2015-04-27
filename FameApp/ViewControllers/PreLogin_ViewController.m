//
//  PreLogin_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/20/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "PreLogin_ViewController.h"


@interface PreLogin_ViewController ()
@end

@implementation PreLogin_ViewController

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self initSubViews];
}

- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForNavigationBar_backgroundColor]];
    
    [((UIButton *)[self.view viewWithTag:1001]) setBackgroundColor:[Colors_Modal getUIColorForMain_8]];
    [((UIButton *)[self.view viewWithTag:1002]) setBackgroundColor:[Colors_Modal getUIColorForMain_5]];
    
    [self initParallax];
}

- (void)initParallax {
    
    NSLog(@"ddd");
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-100);
    verticalMotionEffect.maximumRelativeValue = @(100);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-100);
    horizontalMotionEffect.maximumRelativeValue = @(100);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [[self.view viewWithTag:1000] addMotionEffect:group];
}

@end

