//
//  PostHistory.h
//  FameApp
//
//  Created by Eldar on 4/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQPersist.h"

@interface PostHistory : SQPObject

@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *postId;
@property (nonatomic, strong) NSString *contentFileName;
@property (nonatomic) int countViews;
@property (nonatomic) int countNices;

@end

