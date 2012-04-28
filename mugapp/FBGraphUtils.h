//
//  FBGraphUtils.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const GET_USER_DETAILS_REQUEST;
extern NSString* const GET_EVENTS_REQUEST;
extern NSString* const GET_EVENT_DETAILS_REQUEST;

@interface FBGraphUtils : NSObject

+ (NSMutableString *) getUserEventsUrl:(NSString*) accessToken withUserId: (NSString *) userId;
+ (NSString *) getUserInfoUrl: (NSString *) accessToken;
+ (NSString *) getFBObjectInfoUrl:(NSString*) accessToken withUserId: (NSString *) objectID;

@end
