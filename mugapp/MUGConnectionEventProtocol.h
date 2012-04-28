//
//  MUGConnectionEventProtocol.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MUGConnectionEventProtocol <NSObject>

@required
-(void) onConnectionCompleteForOperation:(NSString *) opId withStatus:(BOOL) status andData:(NSData *)data;

@end
