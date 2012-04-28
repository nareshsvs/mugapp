//
//  FBGraphUtils.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBGraphUtils.h"

NSString* const USER_ID = @"userId";

NSString* const GRAPH_BASE_URL = @"https://graph.facebook.com/";
NSString* const PARAM_ACCESS_TOKEN = @"access_token=";
NSString* const PARAM_OTHERS = @"&format=json&metadata=1";
NSString* const AMPHERSAND = @"&";
NSString* const QUESTIONMARK = @"?";
NSString* const FORWARD_SLASH = @"/";

NSString* const  ME=@"me";
NSString* const  EVENTS = @"events";

NSString* const GET_USER_DETAILS_REQUEST = @"GetUserDetails";
NSString* const GET_EVENTS_REQUEST = @"GetEventRequests";
NSString* const GET_EVENT_DETAILS_REQUEST = @"GetEventDetailsRequests";


@implementation FBGraphUtils

+ (NSMutableString *) getUserEventsUrl:(NSString*) accessToken withUserId: (NSString *) userId
{
    NSMutableString *userEvtUrl = [[[NSMutableString alloc] init] autorelease];
    [userEvtUrl appendString:GRAPH_BASE_URL];
    [userEvtUrl appendString:userId];
    [userEvtUrl appendString:FORWARD_SLASH];
    [userEvtUrl appendString:EVENTS];
    [userEvtUrl appendString:QUESTIONMARK];
    [userEvtUrl appendString:PARAM_ACCESS_TOKEN];
    [userEvtUrl appendString:accessToken];
    [userEvtUrl appendString:PARAM_OTHERS];
    
    return userEvtUrl;
}

+ (NSString *) getUserInfoUrl: (NSString *) accessToken
{
    NSMutableString *userEnvUrl = [[[NSMutableString alloc] init] autorelease];
    [userEnvUrl appendString:GRAPH_BASE_URL];
    [userEnvUrl appendString:ME];
    [userEnvUrl appendString:QUESTIONMARK];
    [userEnvUrl appendString:PARAM_ACCESS_TOKEN];
    [userEnvUrl appendString:accessToken];
    [userEnvUrl appendString:PARAM_OTHERS];
    
    return userEnvUrl;
    
}

+ (NSString *) getFBObjectInfoUrl:(NSString*) accessToken withUserId: (NSString *) objectID
{
    NSMutableString *userEvtUrl = [[[NSMutableString alloc] init] autorelease];
    [userEvtUrl appendString:GRAPH_BASE_URL];
    [userEvtUrl appendString:objectID];
//    [userEvtUrl appendString:QUESTIONMARK];
//    [userEvtUrl appendString:PARAM_ACCESS_TOKEN];
//    [userEvtUrl appendString:accessToken];
//    [userEvtUrl appendString:PARAM_OTHERS];
    
    return userEvtUrl;
    
}



@end
