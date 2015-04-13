//
//  FormattingHelper.m
//  FameApp
//
//  Created by Eldar on 4/13/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "FormattingHelper.h"

@implementation FormattingHelper

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

@end

