//
//  Colors_Modal.h
//  FameApp
//
//  Created by Eldar on 3/30/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Colors_Modal : NSObject

#pragma mark - Navigation Bar Color
+ (UIColor *) getUIColorForNavigationBar_backgroundColor;
+ (UIColor *) getUIColorForNavigationBar_tintColor;

#pragma mark - Main Colors
/*! DARK 'light' */
+ (UIColor *) getUIColorForMain_1;
/*! PEACH */
+ (UIColor *) getUIColorForMain_2;
/*! DARK 'hard' */
+ (UIColor *) getUIColorForMain_3;
/*! RED */
+ (UIColor *) getUIColorForMain_4;
/*! GREEN */
+ (UIColor *) getUIColorForMain_5;
/*! GRAY 'light' */
+ (UIColor *) getUIColorForMain_6;
/*! just GRAY */
+ (UIColor *) getUIColorForMain_7; 

@end
