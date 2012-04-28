//
//  MUGDefaultURLDelegate.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUGConnectionEventProtocol.h"

@interface MUGDefaultURLDelegate : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSString *operationId;
    id<MUGConnectionEventProtocol> mugConnectionListener;
}

@property(nonatomic, retain) NSString* operationId;
@property(nonatomic, retain) id<MUGConnectionEventProtocol> mugConnectionListener;

-(id) initWithOperation: (NSString *) opId andListener: (id<MUGConnectionEventProtocol>) listener ;

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;


@end
