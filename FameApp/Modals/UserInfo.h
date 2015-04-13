//
//  UserInfo.h
//  FameApp
//
//  Created by Eldar on 4/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQPersist.h"

@interface UserInfo : SQPObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userDisplayName;
@property (nonatomic, strong) NSString *userImageURL;

// TODO: need to add access token

@end
