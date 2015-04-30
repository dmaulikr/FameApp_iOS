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
@synthesize popup;


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

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

#pragma mark - Subviews init by device type
- (void)initSubViews {
    
    [self.view setBackgroundColor:[Colors_Modal getUIColorForMain_1]];
    
    // set buttons colors
    [self setColorForAddCaptionButton];
    
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
}

- (void)initSubViews_iPhone6Plus {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 414, 414);
    [self.view viewWithTag:1002].frame = CGRectMake(0, 0, 414, 414);
    [self.view viewWithTag:1001].frame = CGRectMake(0, 444, 414, 101);
    [self.view viewWithTag:1003].frame = CGRectMake(0, 586, 414, 50);
}

- (void)initSubViews_iPhone6 {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 375, 375);
    [self.view viewWithTag:1002].frame = CGRectMake(0, 0, 375, 375);
    [self.view viewWithTag:1001].frame = CGRectMake(0, 395, 375, 101);
    [self.view viewWithTag:1003].frame = CGRectMake(0, 537, 375, 50);
}

- (void)initSubViews_iPhone5x {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 320, 320);
    [self.view viewWithTag:1002].frame = CGRectMake(0, 0, 320, 320);
    [self.view viewWithTag:1001].frame = CGRectMake(0, 343, 320, 79);
    [self.view viewWithTag:1003].frame = CGRectMake(0, 455, 320, 50);
}

- (void)initSubViews_iPhone4x {
    
    [self.view viewWithTag:1000].frame = CGRectMake(0, 0, 320, 320);
    [self.view viewWithTag:1002].frame = CGRectMake(0, 0, 320, 320);
    [self.view viewWithTag:1001].frame = CGRectMake(0, 329, 320, 79);
    
    [self.view viewWithTag:1003].hidden = YES;
}

#pragma mark - Save related
- (void)saveImage {
    
    // hide the keyboard,
    // otherwise the app will crash
    [[self view] endEditing:YES];
    
    UIViewController *myViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PostScreen"];
    [self presentViewController:myViewController animated:YES completion:nil];
    
//    // save image
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        
//        UIImage *imageToSave = [self visibleImage];
//        if (imageToSave != nil) {
//            
//            // TODO:
//            // TODO: here the bidding process starts
//            // TODO:
//            
//            
//            NSString *userId = @"@number1";  // TODO: get userId
//            NSString *imagePath = [ImageStorageHelper saveImageToLocalDirectory:imageToSave aUsername:userId];
//            
//            
//            // TODO: DEBUG - should be a global var.  -> get from AppDelegateInst
//            // TODO:    here will be only 'userId' and 'contentFileName'
//            PostHistory *currentPost = [[PostHistory alloc] init];
//            currentPost.userId = userId;
//            currentPost.contentFileName = imagePath;
//            currentPost.isPublished = true;
//            currentPost.countNices = 10000;
//            currentPost.countViews = 100000;
//            currentPost.timestamp = [[NSDate alloc] init];
//            currentPost.postId = [NSString stringWithFormat:@"%@", [[NSDate alloc] init]]; // TODO: temp value - the real one will come from the server
//            [DataStorageHelper addPostHistory:currentPost];
//            
//        }
//        else {
//            
//            [self showStatusPopup:NO message:[FormattingHelper formatGeneralErrorMessage]];
//        }
//    });
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
    
    NSArray *textColors = [NSArray arrayWithObjects:
                                           [Colors_Modal getUIColorForContentLabel_3],
                                           [Colors_Modal getUIColorForContentLabel_1],
                                           [Colors_Modal getUIColorForContentLabel_2],
                                           nil];
    NSArray *backgroundColors = [NSArray arrayWithObjects:
                                                 [Colors_Modal getUIColorForContentLabel_5],
                                                 [Colors_Modal getUIColorForContentLabel_4],
                                                 [Colors_Modal getUIColorForContentLabel_6],
                                                 nil];
    
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
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom);
    
    popup = [KLCPopup popupWithContentView:popupView
                                  showType:(KLCPopupShowType)KLCPopupShowTypeSlideInFromBottom
                               dismissType:(KLCPopupDismissType)KLCPopupDismissTypeSlideOutToBottom
                                  maskType:(KLCPopupMaskType)KLCPopupMaskTypeNone
                  dismissOnBackgroundTouch:NO
                     dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(dismissStatusPopup:) userInfo:nil repeats:NO];
}

- (void)dismissStatusPopup:(NSTimer *)aTimer {
    
    [popup dismiss:YES];
}

@end

