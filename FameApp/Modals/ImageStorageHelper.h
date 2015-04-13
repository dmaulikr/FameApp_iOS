//
//  ImageStorageHelper.h
//  FameApp
//
//  Created by Eldar on 4/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageStorageHelper : NSObject

/*!
 return Local Image Path OR nil.
 */
+ (NSString *)saveImageToLocalDirectory:(UIImage *)aImage aUsername:(NSString *)aUserId;

@end

