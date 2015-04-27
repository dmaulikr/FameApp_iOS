//
//  AppAPI_SignUp_Modal.h
//  FameApp
//
//  Created by Eldar on 4/24/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@interface AppAPI_SignUp_Modal : NSObject

+ (NSArray *) requestContruct_SignUp:(NSString *)userId password:(NSString *)password email:(NSString *)email bday:(NSArray *)bday;
+ (NSDictionary *) processReply_SignUp:(NSDictionary *)responseObject;

@end

