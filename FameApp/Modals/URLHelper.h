//
//  URLHelper.h
//  FameApp
//
//  Created by Eldar on 5/10/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DFImageManager.h"
#import "DFImageRequest.h"
#import "DFImageRequestOptions.h"

typedef void(^myCompleteBlock)(BOOL);

@interface URLHelper : NSObject

#pragma mark - Set Image with cache, related
+ (void)setImageWithDefaultCache:(NSString *)imageURL imageView:(UIImageView *)imageView placeholderImageName:(NSString *)placeholderImageName completeBlock:(myCompleteBlock)completeBlock;
+ (void)setImageWithShortCache:(NSString *)imageURL imageView:(UIImageView *)imageView placeholderImageName:(NSString *)placeholderImageName completeBlock:(myCompleteBlock)completeBlock;

#pragma mark - Preload Image into cache, related
+ (void)preloadImageWithDefaultCache:(NSString *)imageURL;
+ (void)preloadImageWithShortCache:(NSString *)imageURL;

@end

