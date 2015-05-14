//
//  Tutorial_ViewController.m
//  FameApp
//
//  Created by Eldar on 5/14/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Tutorial_ViewController.h"


// TODO: incomplete - change the texts

static NSString * const descText1 = @"\nAAAAAAAA";
static NSString * const descText2 = @"\nBBBBBBBB";
static NSString * const descText3 = @"\nCCCCCCCC";


@interface Tutorial_ViewController ()
@end

@implementation Tutorial_ViewController

@synthesize ghView, descStrings, welcomeLabel;

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    ghView = [[GHWalkThroughView alloc] initWithFrame:self.navigationController.view.bounds];
    [ghView setDataSource:self];
    [ghView setDelegate:self];
    [ghView setWalkThroughDirection:GHWalkThroughViewDirectionVertical];
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    welcomeLabel.text = @"Welcome";
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.descStrings = [NSArray arrayWithObjects:descText1, descText2, descText3, nil];
    
    ghView.isfixedBackground = NO;
    ghView.floatingHeaderView = nil;
    [ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
    [ghView setCloseTitle:@""];
    
    [ghView showInView:self.view animateDuration:0.3];
}

#pragma mark - GHDataSource related
- (NSInteger)numberOfPages {
    
    return 3;
}

- (void)configurePage:(GHWalkThroughPageCell *)cell atIndex:(NSInteger)index {
    
    cell.title = [NSString stringWithFormat:@"This is page %ld", index+1];  // TODO: incomplete
    cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"Tutorial_TitleImage_%ld", index+1]];
    cell.desc = [self.descStrings objectAtIndex:index];
}

- (UIImage *)bgImageforPage:(NSInteger)index {
    
//    NSString* imageName = @"Tests";//[NSString stringWithFormat:@"bg_0%ld.jpg", index+1];
//    UIImage* image = [UIImage imageNamed:imageName];
//    return image;
    
    NSArray *bgColorsList = @[ [Colors_Modal getUIColorForMain_8],
                               [Colors_Modal getUIColorForMain_5],
                               [Colors_Modal getUIColorForNavigationBar_backgroundColor],
                               [Colors_Modal getUIColorForMain_1]
                             ];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[bgColorsList objectAtIndex:index] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)walkthroughDidDismissView:(GHWalkThroughView *)walkthroughView {
    
    // TODO: incomplete
    // TODO:    1. show the camera view.
    // TODO:    2. camera view for when it was opened from here, will have hints:
    // TODO:        - above the gallery button, telling the person to upload the best image they have.
    
    NSLog(@"GOT IT PRESSED");
}

@end

