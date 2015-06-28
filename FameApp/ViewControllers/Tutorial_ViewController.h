//
//  Tutorial_ViewController.h
//  FameApp
//
//  Created by Eldar on 5/14/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Analytics_Modal.h"
#import "GHWalkThroughView.h"
#import "Colors_Modal.h"

@interface Tutorial_ViewController : UIViewController <GHWalkThroughViewDelegate, GHWalkThroughViewDataSource>

@property (nonatomic, strong) GHWalkThroughView *ghView;
@property (nonatomic, strong) NSArray *descStrings;
@property (nonatomic, strong) UILabel *welcomeLabel;

@end

