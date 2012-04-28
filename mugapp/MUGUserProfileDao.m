//
//  MUGUserProfile.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGUserProfileDao.h"
#import "DBSchema.h"

NSString *const INSERT_KEY = @"insert or replace into user_profile ('key', 'value') values (?,?) ";
NSString *const GET_VALUE = @"select value from user_profile where key = ? ";

@implementation MUGUserProfileDao
@synthesize  db;

-(id) initWithDb: (FMDatabase *)dbref
{
    self = [super init];
    if(self != nil)
    {
        self.db = dbref;   
    }
    return self;
}


-(NSString *) getValueForKey: (NSString *) key
{
    NSString *value = @"";
    @try {
        FMResultSet *resultSet = [db executeQuery:GET_VALUE, key];
        if(resultSet != nil)
        {
            while([resultSet next])
            {
                value = [resultSet stringForColumn:CL_VALUE];
                break;
            }
        }
        [resultSet close];
    }
    @catch (NSException *exception) {
        NSLog(@"exception while querying %@ ", exception);
    }
    @finally {
        
    }
    return value;
}

-(void) saveValue:(NSString *)value  forKey:(NSString *)key
{
    @try {
        
        [db executeUpdate:INSERT_KEY,key,value];
        [db commit];

    }
    @catch (NSException *exception) {
        NSLog(@"exception while inserting %@ ", exception);

    }
    @finally {
    }
    
}

-(void) dealloc
{
    [db release];
    [super dealloc];
}

@end
