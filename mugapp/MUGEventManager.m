//
//  MUGEventManager.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGEventManager.h"
#import "MUGEvent.h"
#import "SQLiteMgr.h"


static MUGEventManager *instance = NULL;


@interface MUGEventManager()

- (void) loadAllEvents;

@end

@implementation MUGEventManager

@synthesize events;

+ (MUGEventManager *)getInstance
{
	@synchronized([MUGEventManager class])
    {
        if(instance == NULL)
        {
            instance = [[MUGEventManager alloc] init];
        }
    }
    return instance;
}

-(id) init
{
    self = [super init];
    if(self != nil)
    {
        [self loadAllEvents];
    }
    return self;
}

- (void) loadAllEvents
{
    self.events = [[SQLiteMgr getSharedInstance].eventDao getAllMugEvents];
   
}


- (MUGEvent *) getEventAtIndex : (NSIndexPath *) index
{
    MUGEvent *event = NULL;
    if(events != nil)
    {
       event = [events objectAtIndex:index.row];
    }
    return event;
}

- (NSInteger) getNumOfEvents
{
    NSInteger count = 0;
    if(events != nil)
    {
        count = [events count];
    }
    return count;   
}

- (void) syncEventsWithFacebook
{
    
}


@end
