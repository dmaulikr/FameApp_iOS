//
//  L360ConfettiView.m
//  L360ConfettiExample
//
//  Created by Mohammed Islam on 12/11/14.
//  Copyright (c) 2014 Life360. All rights reserved.
//

#import "L360ConfettiArea.h"
#import "L360ConfettiObject.h"
#import "L360ConfettiView.h"

@interface L360ConfettiArea ()

@property (nonatomic, strong) NSMutableSet *confettiBursts;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) NSArray *colors;

@end

@implementation L360ConfettiArea

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.swayLength = 50.0;
        self.blastSpread = 1.0;
        self.confettiBursts = [NSMutableSet set];
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        
        // Create gravity behavior. Don't add till view did appear
        self.gravityBehavior = [[UIGravityBehavior alloc] init];
        self.gravityBehavior.magnitude = 0.5;
        
        [self.animator addBehavior:self.gravityBehavior];
    }
    return self;
}

- (void)setupDataFromDelegates
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(colorsForConfettiArea:)]) {
        self.colors = [self.delegate colorsForConfettiArea:self];
    } else {
        // Default to these colors
        self.colors = @[[UIColor redColor],
                        [UIColor blueColor],
                        [UIColor greenColor],
                        [UIColor orangeColor],
                        [UIColor purpleColor],
                        [UIColor magentaColor],
                        [UIColor cyanColor]
                        ];
    }
}

- (void)burstAt:(CGPoint)point confettiWidth:(CGFloat)confettiWidth numberOfConfetti:(NSInteger)numberConfetti
{
    [self setupDataFromDelegates];
    
    NSMutableArray *confettiObjects = [NSMutableArray array];
    
    for (NSInteger i = 0; i < numberConfetti; i++) {
        CGFloat randomWidth = confettiWidth + [self randomFloatBetween:-(confettiWidth / 2.0) and:2.0];
        CGRect confettiFrame = CGRectMake(point.x,
                                          point.y,
                                          randomWidth,
                                          randomWidth);
        
        // Create the confetti view with the random properties
        L360ConfettiView *confettiView = [[L360ConfettiView alloc] initWithFrame:confettiFrame
                                                                withFlutterSpeed:[self randomFloatBetween:1.0 and:5.0]
                                                                     flutterType:[self randomIntegerFrom:0 to:L360ConfettiFlutterTypeCount]];
        confettiView.backgroundColor = self.colors[[self randomIntegerFrom:0 to:self.colors.count]];
        
        [self addSubview:confettiView];
        
        // Each view is associated with an object that handles how the confetti falls
        L360ConfettiObject *confettiObject = [[L360ConfettiObject alloc] initWithConfettiView:confettiView
                                                                             keepWithinBounds:self.bounds
                                                                                     animator:self.animator
                                                                                      gravity:self.gravityBehavior];
        confettiObject.linearVelocity = CGPointMake([self randomFloatBetween:-200.0 and:200.0],
                                                    [self randomFloatBetween:-100.0 and:-400.0]);
        confettiObject.density = [self randomFloatBetween:0.2 and:1.0];
        confettiObject.swayLength = [self randomFloatBetween:0.0 and:self.swayLength];
        
        [confettiObjects addObject:confettiObject];
        
        // Add the confetti object behavior to the animator and the view to gravity behavior
        [self.animator addBehavior:confettiObject.fallingBehavior];
        [self.gravityBehavior addItem:confettiView];
    }
    
    // Store the burst so that later it can be properly deallocated
    [self.confettiBursts addObject:confettiObjects];
}

- (void)blastFrom:(CGPoint)point towards:(CGFloat)angle withForce:(CGFloat)force confettiWidth:(CGFloat)confettiWidth numberOfConfetti:(NSInteger)numberConfetti
{
    [self setupDataFromDelegates];
    
    NSMutableArray *confettiObjects = [NSMutableArray array];
    
    for (NSInteger i = 0; i < numberConfetti; i++) {
        CGFloat randomWidth = confettiWidth + [self randomFloatBetween:-(confettiWidth / 2.0) and:2.0];
        CGRect confettiFrame = CGRectMake(point.x,
                                          point.y,
                                          randomWidth,
                                          randomWidth);
        
        // Create the confetti view with the random properties
        L360ConfettiView *confettiView = [[L360ConfettiView alloc] initWithFrame:confettiFrame
                                                                withFlutterSpeed:[self randomFloatBetween:1.0 and:5.0]
                                                                     flutterType:[self randomIntegerFrom:0 to:L360ConfettiFlutterTypeCount]];
        confettiView.backgroundColor = self.colors[[self randomIntegerFrom:0 to:self.colors.count]];
        
        [self addSubview:confettiView];
        
        // Each view is associated with an object that handles how the confetti falls
        L360ConfettiObject *confettiObject = [[L360ConfettiObject alloc] initWithConfettiView:confettiView
                                                                             keepWithinBounds:self.bounds
                                                                                     animator:self.animator
                                                                                      gravity:self.gravityBehavior];
        
        CGFloat confettiForce = [self randomFloatBetween:force - (force * 0.3) and:force];
        CGFloat vectorForceXmin = confettiForce * cos(angle - self.blastSpread);
        CGFloat vectorForceXmax = confettiForce * cos(angle + self.blastSpread);
        CGFloat vectorForceYmin = -confettiForce * sin(angle - self.blastSpread);
        CGFloat vectorForceYmax = -confettiForce * sin(angle + self.blastSpread);
        
        confettiObject.linearVelocity = CGPointMake([self randomFloatBetween:vectorForceXmin and:vectorForceXmax],
                                                    [self randomFloatBetween:vectorForceYmin and:vectorForceYmax]);
        confettiObject.density = [self randomFloatBetween:0.2 and:1.0];
        confettiObject.swayLength = [self randomFloatBetween:0.0 and:self.swayLength];
        
        [confettiObjects addObject:confettiObject];
        
        // Add the confetti object behavior to the animator and the view to gravity behavior
        [self.animator addBehavior:confettiObject.fallingBehavior];
        [self.gravityBehavior addItem:confettiView];
    }
    
    // Store the burst so that later it can be properly deallocated
    [self.confettiBursts addObject:confettiObjects];
}

#pragma mark helpers

- (CGFloat)randomFloatBetween:(CGFloat)smallNumber and:(CGFloat)bigNumber
{
    CGFloat diff = bigNumber - smallNumber;
    return (((CGFloat) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

/**
 *  [fromInteger, toInteger)
 *  So it's useful for arrays
 */
- (NSInteger)randomIntegerFrom:(NSInteger)fromInteger to:(NSInteger)toInteger
{
    if (fromInteger == toInteger) {
        return fromInteger;
    }
    
    return fromInteger + arc4random() % (toInteger - fromInteger);
}

@end
