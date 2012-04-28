//
//  MUGEventDao.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGEventDao.h"
#import "DBSchema.h"
#import "MUGAppUtils.h"

NSString* const GET_ALL_EVENTS = @"select event_id, event_name , start_time , end_time , timezone , location , \
                                    description , venue , update_time , event_host, rsvp_status from mug_events";


NSString* const INSERT_EVENT = @"insert or replace into mug_events ('event_id','event_name' , 'start_time' , 'end_time' , 'timezone' , 'location' , \
                                 'description' , 'venue' , 'update_time' , 'event_host', 'rsvp_status' ) values \
                                 (?,?,?,?,?,?,?,?,?,?,?)";

NSString* const GET_EVENTBY_ID = @"select event_id, event_name , start_time , end_time , timezone , location , \
description , venue , update_time , event_host, rsvp_status from mug_events where event_id = ?";

@implementation MUGEventDao

@synthesize db;

-(id) initWithDb:(FMDatabase *)dbref
{
    self = [super init];
    if(self != nil)
    {
        self.db = dbref;
    }
    return self;
}

-(void) dealloc
{
    [db release];
    [super dealloc];
}

-(NSMutableArray *) mapResultSetToEvents: (FMResultSet *) resultSet
{
    NSMutableArray *events = [[[NSMutableArray alloc] init] autorelease];
    if(resultSet != nil)
    {
        NSDateFormatter* formatter = [MUGAppUtils getDateFormatter];
        
        while([resultSet next])
        {
            NSString* eventName = [resultSet stringForColumn:CL_EVENT_NAME];
            NSString* desc =  [resultSet stringForColumn:CL_DESCRIPTION];
            NSString* endTime =   [resultSet stringForColumn:CL_END_TIME];
            NSString* eventHost =  [resultSet stringForColumn:CL_EVENT_HOST];
            NSString* location =  [resultSet stringForColumn:CL_LOCATION];
            NSString* startTime =  [resultSet stringForColumn:CL_START_TIME];
            NSString* timezone =  [resultSet stringForColumn:CL_TIMEZONE];
            NSString* updateTime =  [resultSet stringForColumn:CL_UPDATE_TIME];
            NSString* rsvp_status =  [resultSet stringForColumn:CL_EVENT_RSPVS_STATUS];
            NSString* eventID =  [resultSet stringForColumn:CL_EVENT_ID];
            
            
            MUGEvent *event = [[MUGEvent alloc] init];
            event.eventName = eventName;
            event.description = desc;
            event.eventEndTime = [formatter dateFromString:endTime];
            event.eventOwner = eventHost;
            event.eventLocation = location;
            event.eventStartTime = [formatter dateFromString:startTime];
            event.eventTimeZone = timezone;
            event.eventLastUpdatedOn = [formatter dateFromString:updateTime];
            event.participationStatus = rsvp_status;
            event.eventID = eventID;
            [events addObject:event];
            
        }
        [resultSet close];
    }
    return events;
}



- (NSMutableArray *) getAllMugEvents
{

    NSMutableArray *results = nil;
    @try {
        FMResultSet* resultSet = [db executeQuery:GET_ALL_EVENTS];
        results = [self mapResultSetToEvents:resultSet];
    }
    @catch (NSException *exception) {
        NSLog(@"exception while selecting %@ ", exception);
    }
    @finally {
        
    }
    return  results;
}

- (MUGEvent *) getMugEventByID:(NSString*)eventID
{
    
    MUGEvent * event = nil;
    NSMutableArray *results = nil;
    
    @try {
        FMResultSet* resultSet = [db executeQuery:GET_EVENTBY_ID, eventID ];
        results = [self mapResultSetToEvents:resultSet];
        if([results count] > 0) {
            event = [ results objectAtIndex:0];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception while selecting %@ ", exception);
    }
    @finally {
        
    }
    return  event;
}


- (void) insertMugEvent: (MUGEvent *)event
{
    
    @try {
        
        NSDateFormatter *dateFormatter = [MUGAppUtils getDateFormatter];
        NSString *startTime = [dateFormatter stringFromDate:event.eventStartTime];
        NSString *endTime = [dateFormatter stringFromDate:event.eventEndTime];
        NSString *updateTime = [dateFormatter stringFromDate:event.eventLastUpdatedOn];

        [db executeUpdate:INSERT_EVENT ,event.eventID, event.eventName, startTime, endTime,event.eventTimeZone,
         event.eventLocation, event.description, event.eventVenue,updateTime, event.eventOwner, event.participationStatus];
        [db commit];
    }
    @catch (NSException *exception) {
        NSLog(@"exception while inserting %@ ", exception);
    }
    @finally {
        
    }
       
}


@end
