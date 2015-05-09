//
//  CustomSegueHelper_Modal.m
//  FameApp
//
//  Created by Eldar on 5/8/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "CustomSegueHelper_Modal.h"

@implementation CustomSegueHelper_Modal

+ (void)setCustomBackButton:(UIViewController *)screenSelf {
    
    // Replace Back button
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] init];
    
    __weak typeof(UIViewController *) weakScreenSelf = screenSelf;
    [newBackButton bk_initWithImage:[UIImage imageNamed:@"BackIcon_Black"] style:UIBarButtonItemStylePlain
        handler:^(id sender) {
            
            [weakScreenSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [[screenSelf navigationItem] setLeftBarButtonItem:newBackButton];
}

@end

