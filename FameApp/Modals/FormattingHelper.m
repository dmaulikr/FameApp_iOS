//
//  FormattingHelper.m
//  FameApp
//
//  Created by Eldar on 4/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "FormattingHelper.h"

@implementation FormattingHelper

#pragma mark - Invite related
/*!
 @param sourceRef - <br/>
                    0: From main screen.<br/>
                    1: From lost fame screen.
 */
+ (NSString *)formatSMSInviteGeneralMessage:(int)sourceRef {   // TODO: incomplete
    
    if (sourceRef == 0) {
        
        return @"You must checkout Fame app\nIt's crazy..\nhttp://xxxxxxxx.co/ref=0";
    }
    else if (sourceRef == 1) {
        
        return @"You must checkout Fame app\nIt's crazy..\nhttp://xxxxxxxx.co/ref=1";
    }
    else {
        
        return @"Have you head of Fame app?\nhttp://xxxxxxxx.co";
    }
}

/*!
 @param sourceRef - <br/>
 0: From main screen.<br/>
 1: From lost fame screen.
 */
+ (NSString *)formatSMSInvitePersonalMessage:(int)sourceRef name:(NSString *)name {   // TODO: incomplete
    
    if (sourceRef == 0) {
        
        return [NSString stringWithFormat:@"%@, you must checkout Fame app\nIt's crazy..\nhttp://xxxxxxxx.co/ref=0", name];
    }
    else if (sourceRef == 1) {
        
        return [NSString stringWithFormat:@"%@, you must checkout Fame app\nIt's crazy..\nhttp://xxxxxxxx.co/ref=0", name];
    }
    else {
        
        return [NSString stringWithFormat:@"%@, have you head of Fame app?\nhttp://xxxxxxxx.co", name];
    }
}

#pragma mark - Date Time related
+ (NSString *)formatDateString:(NSDate *)aDate {
    
    if (aDate == nil) {
        
        return @"";
    }
    
    NVDate *dateObj = [[NVDate alloc] initUsingDate:aDate];
    NVDate *nowDateObj = [[NVDate alloc] initUsingToday];
    
    // today
    if ((nowDateObj.year == dateObj.year)
        && (nowDateObj.month == dateObj.month)
        && (nowDateObj.day == dateObj.day)) {
        
        dateObj.dateFormatUsingString = @"HH:mm";
        return [dateObj stringValue];
    }
    // same year
    else if (nowDateObj.year == dateObj.year) {
    
        dateObj.dateFormatUsingString = @"MMMM dd";
        return [dateObj stringValue];
    }
    // any other date
    else {
        
        dateObj.dateFormatUsingString = @"yyyy/MM/dd";
        return [dateObj stringValue];
    }
}

#pragma mark - Generic Error Messages
+ (NSString *)formatGeneralErrorMessage {
    
    NSArray *amazingListOfErrors = @[
                                        @"We realךy screwed up this time...\nPlease try again.",
                                        @"WHAAAAAAAT?! X_X\nPlease try again."
                                    ];
    
    return [amazingListOfErrors objectAtIndex:(arc4random() % [amazingListOfErrors count])];
}

@end

