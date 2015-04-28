//
//  FormattingHelper.h
//  FameApp
//
//  Created by Eldar on 4/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVDate.h"

@interface FormattingHelper : NSObject

#pragma mark - Invite related
+ (NSString *)formatSMSInviteGeneralMessage:(int)sourceRef;
+ (NSString *)formatSMSInvitePersonalMessage:(int)sourceRef name:(NSString *)name;
#pragma mark - Date Time related
+ (NSString *)formatDateString:(NSDate *)aDate;
#pragma mark - Generic Error Messages
+ (NSString *)formatGeneralErrorMessage;

@end

