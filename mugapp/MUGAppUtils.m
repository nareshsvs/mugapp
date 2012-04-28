//
//  MUGAppConstants.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGAppUtils.h"
#import "MUGEvent.h"
#import "MUGEventDao.h"
#import "SQLiteMgr.h"

//NSString* const kAppId = @"210849718975311";
NSString* const kAppId = @"253276701436321";

NSString* const kFbAuthTokenKey = @"MugAppFBAuthToken";
NSString* const kFbAuthTokenExpiryKey= @"MugAppFBAuthTokenExpiryTime";

NSString* const kEvents = @"Events";
NSString* const kFeeds = @"Feeds";

NSString* const kRefreshButton = @"Refresh";
NSString* const kSummaryCell = @"Summary";
NSString* const kEventCell = @"eventCell";
NSString* const kLogoutButton = @"Logout";

NSString* const kDatabaseName = @"mug_data.db";

NSString* const kEventDateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

NSString* const kUserId = @"userId";


NSString* const kEventsInfoNotification = @"EvenetsInfoReceived";
NSString* const kEventsDetailsNotification = @"EvenetsDetailsReceived";

@implementation MUGAppUtils


+ (NSArray *) getDesiredPermissionForMugApp
{
    return [[NSArray alloc] initWithObjects:@"user_groups",@"user_events",@"user_about_me", nil];
}


+ (BOOL) isIpad
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return false;
    return true;
}

+ (void) persistUserId: (NSString *)userId
{
    [[SQLiteMgr getSharedInstance].userProfileDao saveValue:userId forKey:kUserId];
}

+ (NSString *) getUserId
{
   return [[SQLiteMgr getSharedInstance].userProfileDao getValueForKey:kUserId];
}


+ (void) persistAuthToken : (NSString *) authToken withExpiry : (NSDate *) expiry
{
    [[SQLiteMgr getSharedInstance].userProfileDao saveValue:authToken forKey:kFbAuthTokenKey];
    
    NSDateFormatter *dtFormatter = [self getDateFormatter];
    NSString* expiryString = [dtFormatter stringFromDate:expiry];
    [[SQLiteMgr getSharedInstance].userProfileDao saveValue:expiryString forKey:kFbAuthTokenExpiryKey];

}

+ (NSString *) getCurrentAuthToken
{
    return [[SQLiteMgr getSharedInstance].userProfileDao getValueForKey:kFbAuthTokenKey];
}

+ (NSDate *) getExpiryDate
{
    NSDateFormatter *dtFormatter = [self getDateFormatter];
    NSString* expiryString = [[SQLiteMgr getSharedInstance].userProfileDao getValueForKey:kFbAuthTokenExpiryKey];
    NSDate* expiryDate = [dtFormatter dateFromString:expiryString];
    return expiryDate;
    
}

+ (void) clearTokenCache
{
    [[SQLiteMgr getSharedInstance].userProfileDao saveValue:@"" forKey:kFbAuthTokenKey];
    [[SQLiteMgr getSharedInstance].userProfileDao saveValue:@"" forKey:kFbAuthTokenExpiryKey];
}

+ (NSDateFormatter *)getDateFormatter
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:kEventDateFormat];
    [formatter setLocale:currentLocale];
    return formatter;
}


+ (void) insertDummyEvents
{
    @try {
        
        NSString* testTime = @"2012-04-28T10:00:00";
        NSDateFormatter *dateFormatter = [MUGAppUtils getDateFormatter];
        NSDate* date = [dateFormatter dateFromString:testTime];
        
        MUGEvent* event = [[[MUGEvent alloc] init] autorelease];
        event.eventEndTime = date;
        event.eventLastUpdatedOn = date;
        event.eventLocation = @"kormanagala some where";
        event.eventName = @"MUG Hangout event 3";
        event.eventOwner = @"Sumeet singh";
        event.eventStartTime = date;
        event.eventTimeZone = @"India ";
        event.eventVenue = @"Fiberlink Software Pvt Ltd";
        event.description = @"IOS and Android development session 2";
        
        MUGEvent* event1 = [[[MUGEvent alloc] init] autorelease];
        event1.eventEndTime = date;
        event1.eventLastUpdatedOn = date;
        event1.eventLocation = @"kormanagala some where";
        event1.eventName = @"MUG Hangout event 2";
        event1.eventOwner = @"Sumeet singh";
        event1.eventStartTime = date;
        event1.eventTimeZone = @"India ";
        event1.eventVenue = @"Fiberlink Software Pvt Ltd";
        event1.description = @"IOS and Android development session 1";
        
        MUGEventDao *eventDao = [SQLiteMgr getSharedInstance].eventDao;
        [eventDao insertMugEvent:event];
        [eventDao insertMugEvent:event1];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
     
}

+ (NSString *) getDateAsDisplayString: (NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd yyyy 'at' hh:mm"];
    return [formatter stringFromDate:date];
}

+ (NSUInteger) getDisplayHeightForString:(NSString*)str
{
    CGSize maximumLabelSize = CGSizeMake(240, 9999);
    CGSize expectedLabelSize = [str sizeWithFont:[UIFont systemFontOfSize:15.0f] 
                                constrainedToSize:maximumLabelSize 
                                lineBreakMode:UILineBreakModeWordWrap];
    
    return expectedLabelSize.height;

}



@end
