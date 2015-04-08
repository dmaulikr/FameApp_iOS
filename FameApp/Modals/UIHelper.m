//
//  UIHelper.m
//  FameApp
//
//  Created by Eldar on 4/5/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

+ (void)addShadowToView:(UIView *)aView {
    
    //Adds a shadow to sampleView
    CALayer *layer = aView.layer;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowRadius = 4.0f;
    layer.shadowOpacity = 0.80f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
}

@end
