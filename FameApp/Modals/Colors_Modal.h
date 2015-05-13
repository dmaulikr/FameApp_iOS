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
+ (UIColor *) getUIColorForNavigationBar_tintColor_1;

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
/*! BLUE */
+ (UIColor *) getUIColorForMain_8;

#pragma mark - Content Colors
/*! CYAN */
+ (UIColor *) getUIColorForContentLabel_1;
/*! RED */
+ (UIColor *) getUIColorForContentLabel_2;
/*! YELLOW */
+ (UIColor *) getUIColorForContentLabel_3;
/*! DARK GRAY */
+ (UIColor *) getUIColorForContentLabel_4;
/*! BLACK */
+ (UIColor *) getUIColorForContentLabel_5;
/*! WHITE */
+ (UIColor *) getUIColorForContentLabel_6;

@end
