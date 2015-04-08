//
//  DeviceTypeHelper.h
//  FameApp
//
//  Created by Eldar on 3/30/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

enum DeviceType {
    
    IPHONE_4x    = 4,
    IPHONE_5x    = 5,
    IPHONE_6     = 60,
    IPHONE_6PLUS = 61
};

@interface DeviceTypeHelper : NSObject

+ (int)getDeviceType;

@end
