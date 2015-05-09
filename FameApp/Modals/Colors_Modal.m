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
    
    return [[Colors_Modal colorWithHexString:@"#ffd453"] colorWithAlphaComponent:1.0f]; // YELLOW
    
//    return [[Colors_Modal colorWithHexString:@"#ff9870"] colorWithAlphaComponent:1.0f]; // ORANGE
}

+ (UIColor *) getUIColorForNavigationBar_tintColor {
    
//    return [[Colors_Modal colorWithHexString:@"#ffffff"] colorWithAlphaComponent:1.0f];
    
    return [[Colors_Modal colorWithHexString:@"#30270a"] colorWithAlphaComponent:1.0f];
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
    
    return [[Colors_Modal colorWithHexString:@"#e4e4e4"] colorWithAlphaComponent:1.0f];  // GRAY 'light'
}

+ (UIColor *) getUIColorForMain_7 {
    
    return [UIColor grayColor];  // just gray
}

+ (UIColor *) getUIColorForMain_8 {
    
    return [[Colors_Modal colorWithHexString:@"#3399ff"] colorWithAlphaComponent:1.0f];  // BLUE
}

#pragma mark - Content Colors
+ (UIColor *) getUIColorForContentLabel_1 {
    
    return [[Colors_Modal colorWithHexString:@"#2ca5ac"] colorWithAlphaComponent:1.0f];  // CYAN
}

+ (UIColor *) getUIColorForContentLabel_2 {
    
    return [[Colors_Modal colorWithHexString:@"#ed4440"] colorWithAlphaComponent:1.0f];  // RED
}

+ (UIColor *) getUIColorForContentLabel_3 {
    
    return [[Colors_Modal colorWithHexString:@"#fead2f"] colorWithAlphaComponent:1.0f];  // YELLOW
}

+ (UIColor *) getUIColorForContentLabel_4 {
    
    return [[Colors_Modal colorWithHexString:@"#353131"] colorWithAlphaComponent:1.0f];  // DARK GRAY
}

+ (UIColor *) getUIColorForContentLabel_5 {
    
    return [UIColor blackColor];  // BLACK
}

+ (UIColor *) getUIColorForContentLabel_6 {
    
    return [UIColor whiteColor];  // WHITE
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
    
//#if TARGET_IPHONE_SIMULATOR
//    r += 12;
//    g += 19;
//    b += 16;
//#endif
    
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0f];
}

@end
