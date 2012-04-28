//
//  sqliteMgr.h
//  MaaS360
//
//  Created by Neeraj Motwani on 16/05/11.
//  Copyright 2011 Fiberlink Communications Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "MUGEventDao.h"
#import "MUGUserProfileDao.h"

@interface SQLiteMgr : NSObject 
{
	FMDatabase*	dbAppStore;
    MUGEventDao* mugEventsDao;
    MUGUserProfileDao* userProfileDao;
}

@property (readwrite, copy) FMDatabase* dbAppStore;
@property (readonly) MUGEventDao* eventDao;
@property (readonly) MUGUserProfileDao* userProfileDao;

+(SQLiteMgr*)getSharedInstance;


@end
