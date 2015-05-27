//
//  FormattingHelper.m
//  FameApp
//
//  Created by Eldar on 4/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "FormattingHelper.h"

@implementation FormattingHelper

#pragma mark - General Labels related
+ (NSString *)formatLabelTextForCurrentOddBonus:(NSString *)percentString {
    
    return [NSString stringWithFormat:@"+%@", percentString];
}

+ (NSString *)formatLabelTextForBonusInfo:(NSString *)percentString {
    
    return [NSString stringWithFormat:@"+%@ Bonus", percentString];
}

#pragma mark - General Number String related
+ (NSString *)formatNumberIntoString:(int)aNumber {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setGroupingSeparator:[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter stringFromNumber:[NSNumber numberWithInt:aNumber]];
}

#pragma mark - Invite related
/*!
 @param sourceRef - <br/>
                    0: From main screen.<br/>
                    1: From lost fame screen.
 */
+ (NSString *)formatSMSInviteGeneralMessage:(int)sourceRef {
    
    if (sourceRef == 0) {
        
        return @"Have you seen all the wacky stuff on Fame App?!\nhttp://thefameapp.co/?ref=0";
    }
    else if (sourceRef == 1) {
        
        return @"You just must try Fame App\nIt's crazy..\nhttp://thefameapp.co/?ref=1";
    }
    else {
        
        return @"Have you heard of Fame App?\nhttp://thefameapp.co";
    }
}

/*!
 @param sourceRef - <br/>
 0: From main screen.<br/>
 1: From lost fame screen.
 */
+ (NSString *)formatSMSInvitePersonalMessage:(int)sourceRef name:(NSString *)name {
    
//    if (sourceRef == 0) {
//        
//        return [NSString stringWithFormat:@"%@, you must checkout Fame app\nIt's crazy..\nhttp://thefameapp.co/?ref=0", name];
//    }
//    else if (sourceRef == 1) {
//        
//        return [NSString stringWithFormat:@"%@, you must checkout Fame app\nIt's crazy..\nhttp://thefameapp.co/?ref=0", name];
//    }
//    else {
//        
//        return [NSString stringWithFormat:@"%@, have you head of Fame app?\nhttp://thefameapp.co", name];
//    }
    
    return [FormattingHelper formatSMSInviteGeneralMessage:sourceRef];
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
                                        @"We really screwed up this time...\nPlease try again.",
                                        @"WHAAAAAAAT?! X_X\nPlease try again."
                                    ];
    
    return [amazingListOfErrors objectAtIndex:(arc4random() % [amazingListOfErrors count])];
}

@end

