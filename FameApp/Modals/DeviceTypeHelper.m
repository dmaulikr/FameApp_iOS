//
//  DeviceTypeHelper.m
//  FameApp
//
//  Created by Eldar on 3/30/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "DeviceTypeHelper.h"

@implementation DeviceTypeHelper

+ (int)getDeviceType {
    
    float h = [UIScreen mainScreen].bounds.size.height;
    float w = [UIScreen mainScreen].bounds.size.width;
    
    if ((h == 736) && (w == 414)) {
        
        return IPHONE_6PLUS;
    }
    else if ((h == 667) && (w == 375)) {
        
        return IPHONE_6;
    }
    else if ((h == 568) && (w == 320)) {
     
        return IPHONE_5x;
    }
    else if ((h == 480) && (w == 320)) {
     
        return IPHONE_4x;
    }
    
    return -1;
}

@end
