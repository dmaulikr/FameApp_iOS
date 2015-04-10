//
//  ImageStorageHelper.m
//  FameApp
//
//  Created by Eldar on 4/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "ImageStorageHelper.h"

@implementation ImageStorageHelper

+ (BOOL)saveImageToLocalDirectory:(UIImage *)aImage aUsername:(NSString *)aUsername {

    NSLog(@"%@", [ImageStorageHelper constructSaveFileName:aUsername]);
    return YES;
    
//    NSData *imageData = UIImageJPEGRepresentation(aImage, 0.8);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *fileName =[NSString stringWithFormat:@"%@.jpg",[ImageStorageHelper constructSaveFileName:aUsername]];
//    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:fileName];
//    
//    if ([imageData writeToFile:imagePath atomically:NO]) {
//        
//        NSLog(@"the cachedImagedPath is %@",imagePath);
//        return YES;
//    }
//    else {
//        
//        NSLog(@"Failed to cache image data to disk");
//        return NO;
//    }
}

+ (NSString *)constructSaveFileName:(NSString *)aUsername {
    
    return [NSString stringWithFormat:@"%@_%f", aUsername, CFAbsoluteTimeGetCurrent()];
}

@end

