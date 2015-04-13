//
//  ImageStorageHelper.m
//  FameApp
//
//  Created by Eldar on 4/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "ImageStorageHelper.h"

@implementation ImageStorageHelper

/*!
 @param fileName - Only the name of the file, not the full path.
 */
+ (UIImage *)loadImageFromLocalDirectory:(NSString *)fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

/*!
 return Local Image Path OR nil.
 */
+ (NSString *)saveImageToLocalDirectory:(UIImage *)aImage aUsername:(NSString *)aUserId {
    
    NSData *imageData = UIImageJPEGRepresentation(aImage, 0.8);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[ImageStorageHelper constructSaveFileName:aUserId]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    if ([imageData writeToFile:imagePath atomically:NO]) {
        
        NSLog(@"the cachedImagedPath is %@", imagePath);
        return fileName;
    }
    else {
        
        NSLog(@"Failed to cache image data to disk");
        return nil;
    }
}

#pragma mark - Private Methods
+ (NSString *)constructSaveFileName:(NSString *)aUsername {
    
    return [NSString stringWithFormat:@"%@_%f", aUsername, CFAbsoluteTimeGetCurrent()];
}

@end

