//
//  AppAPI_Report_Modal.m
//  FameApp
//
//  Created by Eldar on 5/9/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_Report_Modal.h"

@implementation AppAPI_Report_Modal

#pragma mark - Report Content
+ (NSArray *) requestContruct_ReportContent:(NSString *)postId reportReason:(NSString *)reportReason msg:(NSString *)msg {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"report/reportContent";
    
    // prepare params
    NSString *reqData_postId = postId;
    NSString *reqData_reportReason = reportReason;
    NSString *reqData_msg = (msg == nil || [msg isEqualToString:@""]) ? @"<EMPTY>" : msg;
    
    NSDictionary *parameters = [AppAPI_GeneralInfo_Modal addGeneralRequestInfoDictFull_toRequestDict:
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 reqData_postId, @"postId",
                                 reqData_reportReason, @"reportReason",
                                 reqData_msg, @"msg",
                                 nil]];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_ReportContent:(NSDictionary *)responseObject {
    
    return responseObject;
}

@end

