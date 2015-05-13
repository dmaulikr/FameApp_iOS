//
//  URLHelper.m
//  FameApp
//
//  Created by Eldar on 5/10/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "URLHelper.h"

@implementation URLHelper

#pragma mark - Set Image with cache, related
+ (void)setImageWithDefaultCache:(NSString *)imageURL imageView:(UIImageView *)imageView placeholderImageName:(NSString *)placeholderImageName {
    
    [URLHelper setImageWithCacheOptions:nil imageURL:imageURL imageView:imageView placeholderImageName:placeholderImageName];
}

+ (void)setImageWithShortCache:(NSString *)imageURL imageView:(UIImageView *)imageView placeholderImageName:(NSString *)placeholderImageName {
    
    DFImageRequestOptions *options = [[DFImageRequestOptions alloc] init];
    options.expirationAge = 60;
    
    [URLHelper setImageWithCacheOptions:options imageURL:imageURL imageView:imageView placeholderImageName:placeholderImageName];
}

#pragma mark - Preload Image into cache, related
+ (void)preloadImageWithDefaultCache:(NSString *)imageURL {
    
    [URLHelper setImageWithCacheOptions:nil imageURL:imageURL imageView:nil placeholderImageName:nil];
}

+ (void)preloadImageWithShortCache:(NSString *)imageURL {
    
    DFImageRequestOptions *options = [[DFImageRequestOptions alloc] init];
    options.expirationAge = 60;
    
    [URLHelper setImageWithCacheOptions:options imageURL:imageURL imageView:nil placeholderImageName:nil];
}


#pragma mark - Private Methods
+ (void)setImageWithCacheOptions:(DFImageRequestOptions *)options imageURL:(NSString *)imageURL imageView:(UIImageView *)imageView placeholderImageName:(NSString *)placeholderImageName {
    
    if ((imageURL == nil) || ([imageURL isEqualToString:@""])) {
        
        if ((imageView != nil)
            && (placeholderImageName != nil) && ([placeholderImageName isEqualToString:@""] == NO)) {
            
            [imageView setImage:[UIImage imageNamed:placeholderImageName]];
        }
        
        return;
    }
    
    DFImageRequest *request = [DFImageRequest requestWithResource:[NSURL URLWithString:imageURL] targetSize:imageView.frame.size contentMode:DFImageContentModeAspectFill options:options];
    
    [[DFImageManager sharedManager] requestImageForRequest:request completion:^(UIImage *image, NSDictionary *info) {
        
        if (imageView != nil) {
            
            if (info != nil) {
                
                [imageView setImage:image];
            }
            else if ((placeholderImageName != nil) && ([placeholderImageName isEqualToString:@""] == NO)) {
                
                [imageView setImage:[UIImage imageNamed:placeholderImageName]];
            }
        }
    }];
}

@end

