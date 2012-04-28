//
//  MUGEventDao.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "MUGEvent.h"

@interface MUGEventDao : NSObject
{
    FMDatabase *db;
}

@property(nonatomic, retain) FMDatabase *db;

- (id) initWithDb: (FMDatabase *)db;

- (NSMutableArray *) getAllMugEvents;
- (void) insertMugEvent: (MUGEvent *)event;

- (MUGEvent *) getMugEventByID:(NSString*)eventID;

@end
