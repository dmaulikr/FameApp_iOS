//
//  AppAPI_SignUp_Modal.m
//  FameApp
//
//  Created by Eldar on 4/24/15.
//  Copyright (c) 2015 FameApp. All rights reserved.
//

#import "AppAPI_SignUp_Modal.h"

@implementation AppAPI_SignUp_Modal

/*!
 @param userId -
 @param password -
 @param email -
 @param bday - An array of NSNumber. Values order: day,month,year.
 */
+ (NSArray *) requestContruct_SignUp:(NSString *)userId password:(NSString *)password email:(NSString *)email bday:(NSArray *)bday {
    
    AppDelegate *appDelegateInst = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSURL *baseURL = [NSURL URLWithString:appDelegateInst.appAPIBaseURL];
    NSString *reqPath = @"user/signup";
    
    // prepare params
    NSString *reqData_userId = userId;
    NSString *reqData_password = password;
    NSString *reqData_email = email;
    NSDictionary *reqData_bday = @{ @"day" : [bday objectAtIndex:0],
                                    @"month" : [bday objectAtIndex:1],
                                    @"year" : [bday objectAtIndex:2]
                                  };
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                reqData_userId, @"userId",
                                reqData_password, @"password",
                                reqData_email, @"email",
                                reqData_bday, @"bday",
                                nil];
    
    return [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@%@", baseURL, reqPath], parameters, nil];
}

+ (NSDictionary *) processReply_SignUp:(NSDictionary *)responseObject {
    
    // statusCode - int
    // statusMsg  - string
    // errorField - string
    
    // TODO: incomplete
    
    return responseObject;
}

@end

