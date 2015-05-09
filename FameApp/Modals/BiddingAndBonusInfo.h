//
//  BiddingAndBonusInfo.h
//  FameApp
//
//  Created by Eldar on 5/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQPersist.h"

@interface BiddingAndBonusInfo : SQPObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *winningOdds;
@property (nonatomic, strong) NSString *bonusOdds;
@property (nonatomic, strong) NSString *bonusForFriendInvite;
@property (nonatomic, strong) NSString *bonusForShareToSN;

@end

