//
//  PostHistory.m
//  FameApp
//
//  Created by Eldar on 4/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "PostHistory.h"

@implementation PostHistory

- (id)copyWithZone:(NSZone *)zone {
    
    id copy = [[[self class] alloc] init];
    
    if (copy) {
        
        // Copy NSObject subclasses
        [copy setTimestamp:[self.timestamp copyWithZone:zone]];
        [copy setUserId:[self.userId copyWithZone:zone]];
        [copy setPostId:[self.postId copyWithZone:zone]];
        [copy setContentFileName:[self.contentFileName copyWithZone:zone]];
        
        // Set primitives
        [copy setIsPublished:self.isPublished];
        [copy setCountViews:self.countViews];
        [copy setCountNices:self.countNices];
        [copy setTimerMSec:self.timerMSec];
    }
    
    return copy;
}

@end

