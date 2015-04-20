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
}

@end

