//
//  FBDataManager.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBDataManager.h"
#import "MUGAppUtils.h"
#import "FBGraphUtils.h"
#import "MUGDefaultURLDelegate.h"
#import "SBJSON.h"
#import "MUGEvent.h"
#import "SQLiteMgr.h"

static FBDataManager* instance = nil;

@interface FBDataManager ()

-(void) makeUserRequest;

@end


@implementation FBDataManager

+ (FBDataManager *) getInstance
{
    @synchronized([FBDataManager class])
    {
        if(instance == nil)
        {
            instance = [[FBDataManager alloc] init];
        }
    }
    return instance;
}


-(void) syncData
{
    [self makeUserRequest];
}



-(void) onUserInfoAvailable: (NSData *) userData
{
    NSString *response = [[[NSString alloc] initWithData:userData encoding:NSUTF8StringEncoding] autorelease];
    SBJSON *jsonParser = [[[SBJSON alloc] init] autorelease];
    id result = [jsonParser objectWithString:response];
    if([result isKindOfClass:[NSDictionary class]])
    {
        NSString *userId = [result valueForKey:@"id"];
        NSLog(@"Recieved userId %@ ", userId);
        [MUGAppUtils persistUserId:userId];
    }
    [self makeEventRequest];

}

-(void) onEventInfoAvailable : (NSData *)eventData
{
    NSString *response = [[[NSString alloc] initWithData:eventData encoding:NSUTF8StringEncoding] autorelease];
    SBJSON *jsonParser = [[[SBJSON alloc] init] autorelease];
    id result = [jsonParser objectWithString:response];
     
    if([result isKindOfClass:[NSDictionary class]])
    {
        NSArray* eventMaps = (NSArray *)[result objectForKey:@"data"];
        if(eventMaps != nil)
        {
            NSDateFormatter *dateFormatter = [MUGAppUtils getDateFormatter];
            for(NSDictionary *dict in eventMaps)
            {
                NSString* endTime = [dict objectForKey:@"end_time"];
                NSString* event_id = [dict objectForKey:@"id"];
                NSString* location = [dict objectForKey:@"location"];
                NSString* name = [dict objectForKey:@"name"];
                NSString* start_time = [dict objectForKey:@"start_time"];
                NSString* timezone = [dict objectForKey:@"timezone"];
                NSString* eventStatus = [dict objectForKey:@"rsvp_status"];

                if([name hasPrefix:@"MUG"])
                {
                    MUGEvent *event = [[SQLiteMgr getSharedInstance].eventDao getMugEventByID:event_id];
                    if(event == nil) {
                        event = [[MUGEvent alloc] init];
                    }
                    event.eventName         = name;
                    event.eventEndTime      = [dateFormatter dateFromString:endTime];
                    event.eventLocation     = location;
                    event.eventStartTime    = [dateFormatter dateFromString:start_time];
                    event.eventTimeZone     = timezone;
                    event.participationStatus = eventStatus;
                    event.eventID           = event_id;
                    [[SQLiteMgr getSharedInstance].eventDao insertMugEvent:event];
                }
            }
        }
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kEventsInfoNotification object:nil]];
        
        //NSString *userId = [result valueForKey:@"id"];
        NSLog(@"Recieved result %@ ", result);
    }
    
}

-(void) onEventDetailsAvailable : (NSData *)eventData
{
    NSString *response = [[[NSString alloc] initWithData:eventData encoding:NSUTF8StringEncoding] autorelease];
    SBJSON *jsonParser = [[[SBJSON alloc] init] autorelease];
    NSDictionary *dict =  (NSDictionary*)[jsonParser objectWithString:response];
   
    if(dict)
    {
        NSString* description = [dict objectForKey:@"description"];
        NSString* event_id = [dict objectForKey:@"id"];
        
        MUGEvent *event = [[SQLiteMgr getSharedInstance].eventDao getMugEventByID:event_id];
        if(event != nil) {
            event.description = description;
            [[SQLiteMgr getSharedInstance].eventDao insertMugEvent:event];
        }
    }
       
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kEventsDetailsNotification object:nil]]; 
    
}

-(void) makeUserRequest
{

    MUGDefaultURLDelegate* urlDelegate = [[MUGDefaultURLDelegate alloc] initWithOperation:GET_USER_DETAILS_REQUEST andListener:self];
    NSString* accessToken = [MUGAppUtils getCurrentAuthToken];
    NSString* userUrl = [FBGraphUtils getUserInfoUrl:accessToken];
    NSURL *url = [NSURL URLWithString:userUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:urlDelegate];
}


-(void) makeEventRequest
{
    MUGDefaultURLDelegate* urlDelegate = [[MUGDefaultURLDelegate alloc] initWithOperation:GET_EVENTS_REQUEST andListener:self];
    NSString* accessToken = [MUGAppUtils getCurrentAuthToken];
    NSString* userId = [MUGAppUtils getUserId];
    NSString* eventsUrl = [FBGraphUtils getUserEventsUrl:accessToken withUserId:userId];
    
    NSLog(@" Event request URl = %@", eventsUrl );
    NSURL *url = [NSURL URLWithString:eventsUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //[request setHTTPMethod:@"GET"];
    [NSURLConnection connectionWithRequest:request delegate:urlDelegate];
}

- (void)makeFBObjectRequestWithObjectID:(NSString*)objectID
{
    MUGDefaultURLDelegate* urlDelegate = [[MUGDefaultURLDelegate alloc] initWithOperation:GET_EVENT_DETAILS_REQUEST andListener:self];
    NSString* accessToken = [MUGAppUtils getCurrentAuthToken];
    NSString* eventsUrl = [FBGraphUtils getFBObjectInfoUrl:accessToken withUserId:objectID ];
    NSURL *url = [NSURL URLWithString:eventsUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //[request setHTTPMethod:@"GET"];
    [NSURLConnection connectionWithRequest:request delegate:urlDelegate];
}

-(void) onConnectionCompleteForOperation:(NSString *) opId withStatus:(BOOL) status andData:(NSData *)data;
{
    if(status == YES)
    {
        if([opId isEqualToString:GET_USER_DETAILS_REQUEST])
        {
            [self onUserInfoAvailable:data];
        }
        else if([opId isEqualToString:GET_EVENTS_REQUEST])
        {
            [self onEventInfoAvailable:data];
        }
        else if([opId isEqualToString:GET_EVENT_DETAILS_REQUEST])
        {
            [self onEventDetailsAvailable:data];
        }
    }
    else {
        NSLog(@"Request failed %@ ",opId );
    }
    
}

@end
