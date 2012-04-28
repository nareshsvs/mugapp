//
//  MUGAppConstants.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kAppId;
extern NSString* const kFbAuthTokenKey;
extern NSString* const kFbAuthTokenExpiryKey;

extern NSString* const kEvents;
extern NSString* const kFeeds;

extern NSString* const kRefreshButton;
extern NSString* const kSummaryCell;
extern NSString* const kDatabaseName;
extern NSString* const kLogoutButton;

extern NSString* const kEventDateFormat;
extern NSString* const kEventCell;

extern NSString* const kUserId;
extern NSString* const kEventsInfoNotification;
extern NSString* const kEventsDetailsNotification ;

@interface MUGAppUtils : NSObject


+ (NSArray *) getDesiredPermissionForMugApp;
+ (BOOL) isIpad;

+ (void) persistAuthToken : (NSString *) authToken withExpiry : (NSDate *) expiry;
+ (void) persistUserId: (NSString *)userId;
+ (NSString *) getUserId;
+ (NSString *) getCurrentAuthToken;
+ (NSDate *) getExpiryDate;
+ (void) clearTokenCache;

+ (NSDateFormatter *)getDateFormatter;
+ (void) insertDummyEvents;

+ (NSString *) getDateAsDisplayString: (NSDate *)date;
+ (NSUInteger) getDisplayHeightForString:(NSString*)str;

@end
