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
+ (void)setImageWithDefaultCache:(NSString *)imageURL imageView:(UIImageView *)imageView placeholderImageName:(NSString *)placeholderImageName completeBlock:(myCompleteBlock)completeBlock {
    
    [URLHelper setImageWithCacheOptions:nil imageURL:imageURL imageView:imageView placeholderImageName:placeholderImageName completeBlock:completeBlock];
}

+ (void)setImageWithShortCache:(NSString *)imageURL imageView:(UIImageView *)imageView placeholderImageName:(NSString *)placeholderImageName completeBlock:(myCompleteBlock)completeBlock {
    
    DFImageRequestOptions *options = [[DFImageRequestOptions alloc] init];
    options.expirationAge = 60;
    
    [URLHelper setImageWithCacheOptions:options imageURL:imageURL imageView:imageView placeholderImageName:placeholderImageName completeBlock:completeBlock];
}

#pragma mark - Preload Image into cache, related
+ (void)preloadImageWithDefaultCache:(NSString *)imageURL {
    
    [URLHelper setImageWithCacheOptions:nil imageURL:imageURL imageView:nil placeholderImageName:nil completeBlock:nil];
}

+ (void)preloadImageWithShortCache:(NSString *)imageURL {
    
    DFImageRequestOptions *options = [[DFImageRequestOptions alloc] init];
    options.expirationAge = 60;
    
    [URLHelper setImageWithCacheOptions:options imageURL:imageURL imageView:nil placeholderImageName:nil completeBlock:nil];
}


#pragma mark - Private Methods
+ (void)setImageWithCacheOptions:(DFImageRequestOptions *)options imageURL:(NSString *)imageURL imageView:(UIImageView *)imageView placeholderImageName:(NSString *)placeholderImageName completeBlock:(myCompleteBlock)completeBlock {
    
    
    // FIXME: use completeBlock
    
    
    if ((imageURL == nil) || ([imageURL isEqualToString:@""])) {
        
        if ((imageView != nil)
            && (placeholderImageName != nil) && ([placeholderImageName isEqualToString:@""] == NO)) {
            
            [imageView setImage:[UIImage imageNamed:placeholderImageName]];
            
            if (completeBlock != nil) {
                completeBlock(YES);
            }
        }
        
        return;
    }
    
    DFImageRequest *request = [DFImageRequest requestWithResource:[NSURL URLWithString:imageURL] targetSize:imageView.frame.size contentMode:DFImageContentModeAspectFill options:options];
    
    [[DFImageManager sharedManager] requestImageForRequest:request completion:^(UIImage *image, NSDictionary *info) {
        
        if (imageView != nil) {
            
            if (image != nil) {
                
                [imageView setImage:image];
            }
            else if ((placeholderImageName != nil) && ([placeholderImageName isEqualToString:@""] == NO)) {
                
                [imageView setImage:[UIImage imageNamed:placeholderImageName]];
            }
            else {
                
                NSLog(@"NOTHING TO SHOW");  // TODO: DEBUG - REMOVE
            }
            
            if (completeBlock != nil) {
                completeBlock(YES);
            }
        }
    }];
}

@end

