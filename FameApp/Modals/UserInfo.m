//
//  UserInfo.m
//  FameApp
//
//  Created by Eldar on 4/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (id)copyWithZone:(NSZone *)zone {
    
    id copy = [[[self class] alloc] init];
    
    if (copy) {
        
        // Copy NSObject subclasses
        [copy setUserId:[self.userId copyWithZone:zone]];
        [copy setUserDisplayName:[self.userDisplayName copyWithZone:zone]];
        [copy setUserImageURL:[self.userImageURL copyWithZone:zone]];
        [copy setUserEmail:[self.userEmail copyWithZone:zone]];
        [copy setUserToken:[self.userToken copyWithZone:zone]];
    }
    
    return copy;
}

@end

