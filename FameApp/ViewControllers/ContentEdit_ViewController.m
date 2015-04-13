//
//  ContentEdit_ViewController.m
//  FameApp
//
//  Created by Eldar on 4/2/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "ContentEdit_ViewController.h"


int dt;


@interface ContentEdit_ViewController ()
@end


@implementation ContentEdit_ViewController

@synthesize image, imageView;
@synthesize currentlyEditingLabel, labels;

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

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
    [self.navigationController.navigationBar setBarTintColor:[Colors_Modal getUIColorForMain_3]];
    self.navigationItem.title = @"EDIT";
    
    labels = [[NSMutableArray alloc] init];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchOutside:)]];
    [self.imageView setImage:image];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"GO"
                                                                   style:UIBarButtonItemStyleBordered target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:saveButton, nil];
    
    [self initSubViews];
}

#pragma mark - Subviews init by device type
- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    
    // set buttons colors
    [self setColorForAddCaptionButton];
    
    dt = [DeviceTypeHelper getDeviceType];
    
    if (dt == IPHONE_6) {
        
        [self initSubViews_iPhone6];
    }
}

- (void)initSubViews_iPhone6 {  // TODO: incomplete
    
}

#pragma mark - Save related
- (void)saveImage {
    
    // save image
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        UIImage *imageToSave = [self visibleImage];
        if (imageToSave != nil) {
            
            NSString *userId = @"@number1";  // TODO: get userId
            
            NSString *imagePath = [ImageStorageHelper saveImageToLocalDirectory:imageToSave aUsername:userId];
            
            
            // TODO: DEBUG - should be a global var.
            // TODO:    here will be only 'userId' and 'contentFileName'
            PostHistory *currentPost = [[PostHistory alloc] init];
            currentPost.userId = userId;
            currentPost.contentFileName = imagePath;
            currentPost.isPublished = true;
            currentPost.countNices = 10000;
            currentPost.countViews = 100000;
            currentPost.timestamp = [[NSDate alloc] init];
            currentPost.postId = @"123";
            [DataStorageHelper addPostHistory:currentPost];
            
            
        }
        else {
            
            // TODO: handle the error
        }
    });
}

- (UIImage *)visibleImage {
    
    [currentlyEditingLabel hideEditingHandles];
    
    AppDelegate* appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0.0);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -self.imageView.frame.origin.x, -self.imageView.frame.origin.y - 44);
    
    NSLog(@"%f", self.imageView.frame.origin.y);
    
    [appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - Add Caption related
- (IBAction)addCaption:(id)sender {
    
    [currentlyEditingLabel hideEditingHandles];
    CGRect labelFrame = CGRectMake(CGRectGetMidX(self.imageView.frame) - arc4random() % 150,
                                   CGRectGetMidY(self.imageView.frame) - arc4random() % 200,
                                   80, 70);
    UITextField *aLabel = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [aLabel setClipsToBounds:YES];
    [aLabel setAutoresizingMask:(UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin)];
    [aLabel setText:[self changeText_caption]];
    [aLabel sizeToFit];
    
    IQLabelView *labelView = [[IQLabelView alloc] initWithFrame:labelFrame];
    [labelView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)];
    labelView.delegate = self;
    [labelView setShowContentShadow:NO];
    [labelView setTextField:aLabel];
    [labelView setFontName:@"HelveticaNeue-CondensedBold"];
    [labelView setFontSize:20.0];
    [labelView sizeToFit];
    [[self.view viewWithTag:1000] addSubview:labelView];
    
    currentlyEditingLabel = labelView;
    [self changeColor_caption];
    [labels addObject:labelView];
    
    [self setColorForAddCaptionButton];
}

- (void)setColorForAddCaptionButton {
    
    // TODO: use better colors
    NSArray *textColors = [NSArray arrayWithObjects:[UIColor whiteColor], [UIColor redColor], [UIColor yellowColor], nil];
    NSArray *backgroundColors = [NSArray arrayWithObjects:[UIColor blackColor], [UIColor whiteColor], [UIColor blueColor], nil];
    
    while (YES) {
        
        int randomIndex = arc4random() % [textColors count];
        UIButton *addCaptionButton = (UIButton *) [self.view viewWithTag:1001];
        
        if (addCaptionButton.backgroundColor != [backgroundColors objectAtIndex:randomIndex]) {
            
            [addCaptionButton setTitleColor:[textColors objectAtIndex:randomIndex] forState:UIControlStateNormal];
            [addCaptionButton setBackgroundColor:[backgroundColors objectAtIndex:randomIndex]];
            
            break;
        }
    }
}

- (void)changeColor_caption {
    
    UIButton *addCaptionButton = (UIButton *) [self.view viewWithTag:1001];
    [currentlyEditingLabel setTextColor:addCaptionButton.titleLabel.textColor];
    [currentlyEditingLabel setBackgroundColor:addCaptionButton.backgroundColor];
}

- (NSString *)changeText_caption {
    
    NSArray *strings = @[@"#SayIt", @"#WTF?!", @"#Kinky", @"#YOLO"];
    int randomIndex = arc4random() % [strings count];
    return [strings objectAtIndex:randomIndex];
}

#pragma mark - Clear All related
- (IBAction)clearAll:(id)sender {
    
    // clear all the labels
    for (IQLabelView *aLabelView in labels) {
        
        [aLabelView setHidden:YES];
    }
    labels = [[NSMutableArray alloc] init];
}

#pragma mark - Gesture
- (void)touchOutside:(UITapGestureRecognizer *)touchGesture {
    
    [currentlyEditingLabel hideEditingHandles];
}

#pragma mark - IQLabelDelegate
- (void)labelViewDidClose:(IQLabelView *)label {
    
    // some actions after delete label
    [labels removeObject:label];
}

- (void)labelViewDidBeginEditing:(IQLabelView *)label {
    
    // move or rotate begin
}

- (void)labelViewDidShowEditingHandles:(IQLabelView *)label {
    
    // showing border and control buttons
    currentlyEditingLabel = label;
}

- (void)labelViewDidHideEditingHandles:(IQLabelView *)label {
    
    // hiding border and control buttons
    currentlyEditingLabel = nil;
}

- (void)labelViewDidStartEditing:(IQLabelView *)label {
    
    // tap in text field and keyboard showing
    currentlyEditingLabel = label;
}

@end


