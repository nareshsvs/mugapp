//
//  MUGEventManager.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUGEvent.h"

@interface MUGEventManager : NSObject
{
    NSMutableArray* events;
}

@property(nonatomic, retain) NSMutableArray* events;

- (MUGEvent *) getEventAtIndex : (NSIndexPath *) index;
- (NSInteger) getNumOfEvents;
- (void) syncEventsWithFacebook;

+ (MUGEventManager *) getInstance;

@end
