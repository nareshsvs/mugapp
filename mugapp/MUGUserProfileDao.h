//
//  MUGUserProfile.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface MUGUserProfileDao : NSObject
{
    FMDatabase *db;
}

@property(nonatomic, retain) FMDatabase *db;

-(id) initWithDb: (FMDatabase *)db;

-(NSString *) getValueForKey: (NSString *) key;
-(void) saveValue:(NSString *)value  forKey:(NSString *)key;


@end
