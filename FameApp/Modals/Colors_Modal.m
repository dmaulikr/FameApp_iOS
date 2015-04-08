//
//  Colors_Modal.m
//  FameApp
//
//  Created by Eldar on 3/30/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "Colors_Modal.h"

@implementation Colors_Modal


#pragma mark - Navigation Bar Color
+ (UIColor *) getUIColorForNavigationBar_backgroundColor {
    
    return [[Colors_Modal colorWithHexString:@"#ff9870"] colorWithAlphaComponent:1.0f];
}

+ (UIColor *) getUIColorForNavigationBar_tintColor {
    
    return [[Colors_Modal colorWithHexString:@"#ffffff"] colorWithAlphaComponent:1.0f];
}


#pragma mark - Main Colors
+ (UIColor *) getUIColorForMain_1 {
    
    return [[Colors_Modal colorWithHexString:@"#2f3c4d"] colorWithAlphaComponent:1.0f];  // DARK 'light'
}

+ (UIColor *) getUIColorForMain_2 {
    
    return [[Colors_Modal colorWithHexString:@"#fef6e9"] colorWithAlphaComponent:1.0f];  // PEACH
}

+ (UIColor *) getUIColorForMain_3 {
    
    return [[Colors_Modal colorWithHexString:@"#283039"] colorWithAlphaComponent:1.0f];  // DARK 'hard'
}

+ (UIColor *) getUIColorForMain_4 {
    
    return [[Colors_Modal colorWithHexString:@"#ef423a"] colorWithAlphaComponent:1.0f];  // RED
}

+ (UIColor *) getUIColorForMain_5 {
    
    return [[Colors_Modal colorWithHexString:@"#24dd7f"] colorWithAlphaComponent:1.0f];  // GREEN
}

+ (UIColor *) getUIColorForMain_6 {
    
    return [[Colors_Modal colorWithHexString:@"#d4d4d4"] colorWithAlphaComponent:1.0f];  // GRAY 'light'
}

+ (UIColor *) getUIColorForMain_7 {
    
    return [UIColor grayColor];
}

#pragma mark -
#pragma mark - Private Helper Methods
// Converts HEX color to UIColor - takes @"#123456"
+ (UIColor *) colorWithHexString:(NSString *)str {
    
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [Colors_Modal colorWithHex:x];
}

// Converts HEX color to UIColor - takes 0x123456
+ (UIColor *) colorWithHex:(long)col {
    
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0f];
}

@end
