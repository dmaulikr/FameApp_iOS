//
//  Analytics_Modal.h
//  FameApp
//
//  Created by Eldar on 6/25/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <objc/objc-runtime.h>
#import "AppsFlyerTracker.h"

@interface Analytics_Modal : NSObject

+ (void)trackScreen:(UIViewController *)targetSelf;

@end

