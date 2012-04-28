//
//  sqliteMgr.m
//  MaaS360
//
//  Created by Neeraj Motwani on 16/05/11.
//  Copyright 2011 Fiberlink Communications Ltd. All rights reserved.
//

#import "sqliteMgr.h"
#import "DBSchema.h"
#import "MUGAppUtils.h"
#import "MUGEventDao.h"

#pragma mark -
#pragma mark SQL Query


static SQLiteMgr* sharedSQLiteMgrInstance = nil;

@interface SQLiteMgr()

-(void) initDaos;
-(void) createSchema;

@end

@implementation SQLiteMgr

#pragma mark -
#pragma mark Property Definition


@synthesize dbAppStore;
@synthesize eventDao = mugEventsDao;
@synthesize userProfileDao;

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { DDLogWarn(@"Failure on line %d", __LINE__); return 123; } }


#pragma mark -
#pragma mark Obejct Creation

+(SQLiteMgr*)getSharedInstance 
{
	@synchronized([SQLiteMgr class])
	{
		if (!sharedSQLiteMgrInstance)
			[[self alloc] init];
		
		return sharedSQLiteMgrInstance;
	}
	return nil;
}

+(id)alloc 
{
	@synchronized([SQLiteMgr class])
	{
		NSAssert(sharedSQLiteMgrInstance == nil, @"Attempted to allocate a second instance of a SQLiteMgr.");
		sharedSQLiteMgrInstance = [super alloc];
		return sharedSQLiteMgrInstance;
	}	
	return nil;
}

-(BOOL) createDb
{
    // If db does not exist in documents folder, copy it from bundle
    BOOL success = false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:kDatabaseName];
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    if (!success) 
    {
        success = [fileManager createFileAtPath:writableDBPath contents:nil attributes:nil];
    }
    
    dbAppStore = [FMDatabase databaseWithPath:writableDBPath];
    if (![dbAppStore open]) 
    {
        success = false;
    }
    
    // Only for debug mode
#ifdef CONFIGURATION_DEBUG
    [dbAppStore setTraceExecution:YES];
    [dbAppStore setLogsErrors:YES];
#endif
    
    return success;
}


-(void) createSchema
{
    int version = [dbAppStore queryUserVersion];
    if (version >= CURR_SCHEMA_VERSION) 
    {
        return;
    }
    
    NSMutableArray *arrSql = [[[NSMutableArray alloc] init] autorelease];
    [arrSql addObject:V1_CREATE_EVENTS];
    [arrSql addObject:V1_USER_PROFILE];

    if(arrSql != nil && [arrSql count] > 0)
    {
        BOOL bErrorInUpdate = FALSE;
        for(NSString *strUpdateQuery in arrSql)
        {
            
            if (![dbAppStore executeUpdate:strUpdateQuery])
            {
                bErrorInUpdate = YES;
                break;
            }
        }
        if(!bErrorInUpdate)
        {
            NSString *strSchemaUpdate = [NSString stringWithFormat:@"%@%d",@"PRAGMA user_version =",CURR_SCHEMA_VERSION];
            [dbAppStore executeUpdate:strSchemaUpdate];
            [dbAppStore commit];
        }
        else 
        {
            [dbAppStore rollback];
        }
    }
    
}

-(void) initDaos
{
    mugEventsDao = [[MUGEventDao alloc] initWithDb:dbAppStore];
    userProfileDao = [[MUGUserProfileDao alloc] initWithDb:dbAppStore];
}

-(id)init 
{
	self = [super init];
	if (self != nil) 
	{
		BOOL bRet = [self createDb];
        if(bRet == true)
        {
            [self createSchema];
            [self initDaos];
        }
        else{
            return nil;
        }
	}	
    
	return self;
}


-(void)dealloc
{
        
    [mugEventsDao release];
    [userProfileDao release];
    [dbAppStore release];
    [super dealloc];
}




@end