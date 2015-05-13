//
//  BiddingAndBonusInfo.m
//  FameApp
//
//  Created by Eldar on 5/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "BiddingAndBonusInfo.h"

@implementation BiddingAndBonusInfo

- (id)copyWithZone:(NSZone *)zone {
    
    id copy = [[[self class] alloc] init];
    
    if (copy) {
        
        // Copy NSObject subclasses
        [copy setUserId:[self.userId copyWithZone:zone]];
        [copy setWinningOdds:[self.winningOdds copyWithZone:zone]];
        [copy setBonusOdds:[self.bonusOdds copyWithZone:zone]];
        [copy setBonusForFriendInvite:[self.bonusForFriendInvite copyWithZone:zone]];
        [copy setBonusForShareToSN:[self.bonusForShareToSN copyWithZone:zone]];
    }
    
    return copy;
}

@end

