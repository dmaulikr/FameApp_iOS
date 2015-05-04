// redone to match FameApp

#import <QuartzCore/QuartzCore.h>
#import "ZCSlotMachine.h"

#define SHOW_BORDER 0

static BOOL isSliding = NO;
static const NSUInteger kMinTurn = 6;

/********************************************************************************************/

@implementation ZCSlotMachine {
@private
    // UI
    UIImageView *_backgroundImageView;
    UIImageView *_coverImageView;
    UIView *_contentView;
    UIEdgeInsets _contentInset;
    NSMutableArray *_slotScrollLayerArray;
    
    // Data
    NSArray *_slotResults;
    NSArray *_currentSlotResults;
    
    __weak id<ZCSlotMachineDataSource> _dataSource;
    
    BOOL _isFinalResultsSet;
    int _state;
}

@synthesize completePositionArray;

#pragma mark - View LifeCycle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        _backgroundImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_backgroundImageView];
        
        _contentView = [[UIView alloc] initWithFrame:frame];
#if SHOW_BORDER
        _contentView.layer.borderColor = [UIColor blueColor].CGColor;
        _contentView.layer.borderWidth = 1;
#endif
        
        [self addSubview:_contentView];
        
        _coverImageView = [[UIImageView alloc] initWithFrame:frame];
        _coverImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_coverImageView];
        
        _slotScrollLayerArray = [NSMutableArray array];
        
        self.singleUnitDuration = 0.14f;
        
        _contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

#pragma mark - Properties Methods

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImageView.image = backgroundImage;
}

- (void)setCoverImage:(UIImage *)coverImage {
    _coverImageView.image = coverImage;
}

- (UIEdgeInsets)contentInset {
    return _contentInset;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    
    CGRect viewFrame = self.frame;
    
    _contentView.frame = CGRectMake(_contentInset.left, _contentInset.top, viewFrame.size.width - _contentInset.left - _contentInset.right, viewFrame.size.height - _contentInset.top - _contentInset.bottom);
}

- (NSArray *)slotResults {
    return _slotResults;
}

- (id<ZCSlotMachineDataSource>)dataSource {
    return _dataSource;
}

- (void)setDataSource:(id<ZCSlotMachineDataSource>)dataSource {
    _dataSource = dataSource;
    
    [self reloadData];
}

- (void)reloadData {
    if (self.dataSource) {
        for (CALayer *containerLayer in _contentView.layer.sublayers) {
            [containerLayer removeFromSuperlayer];
        }
        _slotScrollLayerArray = [NSMutableArray array];
        
        NSUInteger numberOfSlots = [self.dataSource numberOfSlotsInSlotMachine:self];
        CGFloat slotSpacing = 0;
        if ([self.dataSource respondsToSelector:@selector(slotSpacingInSlotMachine:)]) {
            slotSpacing = [self.dataSource slotSpacingInSlotMachine:self];
        }
        
        CGFloat slotWidth = _contentView.frame.size.width / numberOfSlots;
        if ([self.dataSource respondsToSelector:@selector(slotWidthInSlotMachine:)]) {
            slotWidth = [self.dataSource slotWidthInSlotMachine:self];
        }
        
        for (int i = 0; i < numberOfSlots; i++) {
            CALayer *slotContainerLayer = [[CALayer alloc] init];
            slotContainerLayer.frame = CGRectMake(i * (slotWidth + slotSpacing), 0, slotWidth, _contentView.frame.size.height);
            slotContainerLayer.masksToBounds = YES;
            
            CALayer *slotScrollLayer = [[CALayer alloc] init];
            slotScrollLayer.frame = CGRectMake(0, 0, slotWidth, _contentView.frame.size.height);
#if SHOW_BORDER
            slotScrollLayer.borderColor = [UIColor greenColor].CGColor;
            slotScrollLayer.borderWidth = 1;
#endif
            [slotContainerLayer addSublayer:slotScrollLayer];
            
            [_contentView.layer addSublayer:slotContainerLayer];
            
            [_slotScrollLayerArray addObject:slotScrollLayer];
        }
        
        CGFloat singleUnitHeight = _contentView.frame.size.height / 3;
        
        NSArray *slotIcons = [self.dataSource iconsForSlotsInSlotMachine:self];
        NSUInteger iconCount = [slotIcons count];
        
        for (int i = 0; i < numberOfSlots; i++) {
            CALayer *slotScrollLayer = [_slotScrollLayerArray objectAtIndex:i];
            NSInteger scrollLayerTopIndex = - (i + kMinTurn + 3) * iconCount;
            
            for (int j = 0; j > scrollLayerTopIndex; j--) {
                UIImage *iconImage = [slotIcons objectAtIndex:abs(j) % iconCount];
                
                CALayer *iconImageLayer = [[CALayer alloc] init];
                // adjust the beginning offset of the first unit
                NSInteger offsetYUnit = j + 1 + iconCount;
                iconImageLayer.frame = CGRectMake(0, offsetYUnit * singleUnitHeight, slotScrollLayer.frame.size.width, singleUnitHeight);
                
                iconImageLayer.contents = (id)iconImage.CGImage;
                iconImageLayer.contentsScale = iconImage.scale;
                iconImageLayer.contentsGravity = kCAGravityCenter;
#if SHOW_BORDER
                iconImageLayer.borderColor = [UIColor redColor].CGColor;
                iconImageLayer.borderWidth = 1;
#endif
                
                [slotScrollLayer addSublayer:iconImageLayer];
            }
        }
    }
}

#pragma mark - Public Methods

- (BOOL)isReallyDone {
    
    return (_isFinalResultsSet == YES) && (_state == 2);
}

- (void)setSlotResults:(NSArray *)slotResults {
    
    _slotResults = slotResults;
    
    if (!_currentSlotResults) {
        NSMutableArray *currentSlotResults = [NSMutableArray array];
        for (int i = 0; i < [slotResults count]; i++) {
            [currentSlotResults addObject:[NSNumber numberWithUnsignedInteger:0]];
        }
        _currentSlotResults = [NSArray arrayWithArray:currentSlotResults];
    }
}

- (void)setFinalResults:(NSArray *)finalResults {
    
    self.slotResults = finalResults;
    _isFinalResultsSet = YES;
}

- (void)startSliding:(int)state {
    
//    // DEBUG
    NSDate *start = [NSDate date];
    
    isSliding = YES;
    
    if ([self.delegate respondsToSelector:@selector(slotMachineWillStartSliding:)]) {
        [self.delegate slotMachineWillStartSliding:self];
    }
    
    NSArray *slotIcons = [self.dataSource iconsForSlotsInSlotMachine:self];
    NSUInteger slotIconsCount = [slotIcons count];
    completePositionArray = [NSMutableArray array];
    
    _state = state;
    
    [CATransaction begin];
    
    if (state == 0) {
        
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    }
    else if (state == 1) {
        
        //        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    }
    else {
        
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    }
    
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:^{
        
        if ([self.delegate respondsToSelector:@selector(slotMachineDidEndSliding:)]) {
            
            [self.delegate slotMachineDidEndSliding:self];
        }

//        isSliding = NO;
//        for (int i = 0; i < [_slotScrollLayerArray count]; i++) {
//            CALayer *slotScrollLayer = [_slotScrollLayerArray objectAtIndex:i];
//
//            slotScrollLayer.position = CGPointMake(slotScrollLayer.position.x, ((NSNumber *)[completePositionArray objectAtIndex:i]).floatValue);
//
//            NSMutableArray *toBeDeletedLayerArray = [NSMutableArray array];
//
//            NSUInteger resultIndex = [[self.slotResults objectAtIndex:i] unsignedIntegerValue];
//            NSUInteger currentIndex = [[_currentSlotResults objectAtIndex:i] unsignedIntegerValue];
//
//            for (int j = 0; j < slotIconsCount * (kMinTurn + i) + resultIndex - currentIndex; j++) {
//                CALayer *iconLayer = [slotScrollLayer.sublayers objectAtIndex:j];
//                [toBeDeletedLayerArray addObject:iconLayer];
//            }
//
//            for (CALayer *toBeDeletedLayer in toBeDeletedLayerArray) {
//                // use initWithLayer does not work
//                CALayer *toBeAddedLayer = [CALayer layer];
//                toBeAddedLayer.frame = toBeDeletedLayer.frame;
//                toBeAddedLayer.contents = toBeDeletedLayer.contents;
//                toBeAddedLayer.contentsScale = toBeDeletedLayer.contentsScale;
//                toBeAddedLayer.contentsGravity = toBeDeletedLayer.contentsGravity;
//
//                CGFloat shiftY = slotIconsCount * toBeAddedLayer.frame.size.height * (kMinTurn + i + 3);
//                toBeAddedLayer.position = CGPointMake(toBeAddedLayer.position.x, toBeAddedLayer.position.y - shiftY);
//
//                [toBeDeletedLayer removeFromSuperlayer];
//                [slotScrollLayer addSublayer:toBeAddedLayer];
//            }
//            toBeDeletedLayerArray = [NSMutableArray array];
//        }
//
//        _currentSlotResults = self.slotResults;
//        completePositionArray = [NSMutableArray array];
        
        // DEBUG
        NSDate *methodFinish = [NSDate date];
        NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:start];
        NSLog(@"Done (%d). Execution Time: %f", state, executionTime);
        
//        _currentSlotResults = self.slotResults;
        
        if (state < 2) {
            
//            NSLog(@"%@", self.slotResults);
            
            if (_isFinalResultsSet == YES) {
                
//                self.slotResults = _finalResults;
                [self startSliding:2];
            }
            else {
                
                [self startSliding:1];
            }
        }
    }];
    
    for (int i = 0; i < [_slotScrollLayerArray count]; i++) {
        CALayer *slotScrollLayer = [_slotScrollLayerArray objectAtIndex:i];
        
        NSUInteger resultIndex = [[self.slotResults objectAtIndex:i] unsignedIntegerValue];
        NSUInteger currentIndex = [[_currentSlotResults objectAtIndex:i] unsignedIntegerValue];
        
        long myValueForSlideY = 0;
        long myValueForDuration = 0;
        
        if (state == 0) {
            
            myValueForSlideY = ((i + kMinTurn) * slotIconsCount + resultIndex - currentIndex);
            myValueForDuration = ((kMinTurn) * slotIconsCount + resultIndex - currentIndex);
        }
        else if (state == 1) {
            
            myValueForSlideY = ((i + kMinTurn) * slotIconsCount + resultIndex - currentIndex);
            myValueForDuration = ((kMinTurn-3) * slotIconsCount + resultIndex - currentIndex);
        }
        else if (state == 2) {
            
            myValueForSlideY = ((i + kMinTurn - 2) * slotIconsCount + resultIndex - currentIndex);
            myValueForDuration = ((i + kMinTurn - 2) * slotIconsCount + resultIndex - currentIndex);
        }
        
        CGFloat slideY = myValueForSlideY * (_contentView.frame.size.height / 3);
        
        CABasicAnimation *slideAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        slideAnimation.fillMode = kCAFillModeForwards;
        
        slideAnimation.duration = myValueForDuration * self.singleUnitDuration;
        slideAnimation.toValue = [NSNumber numberWithFloat:slotScrollLayer.position.y + slideY];
        slideAnimation.removedOnCompletion = NO;
        
        [slotScrollLayer addAnimation:slideAnimation forKey:@"slideAnimation"];
        
        [completePositionArray addObject:slideAnimation.toValue];
    }
    
    [CATransaction commit];
}

@end

