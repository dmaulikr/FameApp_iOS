//
//  AppAPI_Report_Modal.h
//  FameApp
//
//  Created by Eldar on 5/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AppAPI_GeneralInfo_Modal.h"

@interface AppAPI_Report_Modal : NSObject

#pragma mark - Report Content
+ (NSArray *) requestContruct_ReportContent:(NSString *)postId reportReason:(NSString *)reportReason msg:(NSString *)msg;
+ (NSDictionary *) processReply_ReportContent:(NSDictionary *)responseObject;

@end

