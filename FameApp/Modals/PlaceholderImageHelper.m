//
//  PlaceholderImageHelper.m
//  FameApp
//
//  Created by Eldar on 5/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "PlaceholderImageHelper.h"

@implementation PlaceholderImageHelper

+ (NSString *)imageNameForUserProfile {
    
    NSArray *amazingListOfErrors = @[
                                     @"Placeholder_ProfileImage_1",
                                     @"Placeholder_ProfileImage_2"
                                    ];
    
    return [amazingListOfErrors objectAtIndex:(arc4random() % [amazingListOfErrors count])];
}

+ (NSString *)imageNameForUserProfileEdit {
    
    NSArray *amazingListOfErrors = @[
                                     @"Placeholder_ProfileImage_Edit_1",
                                     @"Placeholder_ProfileImage_Edit_2"
                                    ];
    
    return [amazingListOfErrors objectAtIndex:(arc4random() % [amazingListOfErrors count])];
}

@end

