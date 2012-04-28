//
//  FBDataManager.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUGConnectionEventProtocol.h"

@interface FBDataManager : NSObject<MUGConnectionEventProtocol>
{
    
}


-(void) syncData;
-(void) onConnectionCompleteForOperation:(NSString *) opId withStatus:(BOOL) status andData:(NSData *)data;

+ (FBDataManager *) getInstance;

- (void)makeFBObjectRequestWithObjectID:(NSString*)objectID;
-(void) makeEventRequest;

@end
