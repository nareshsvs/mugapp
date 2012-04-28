//
//  MUGDefaultURLDelegate.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGDefaultURLDelegate.h"


@implementation MUGDefaultURLDelegate

@synthesize operationId;
@synthesize mugConnectionListener;

-(id) initWithOperation: (NSString *) opId andListener: (id<MUGConnectionEventProtocol>) listener
{
    self = [super init];
    if(self != nil)
    {
        self.operationId = opId;
        self.mugConnectionListener = listener;
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error during connection %@ ", error);
    [self.mugConnectionListener onConnectionCompleteForOperation:operationId withStatus:FALSE andData:nil];

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
        if([httpResponse statusCode] != 200)
        {
            [self.mugConnectionListener onConnectionCompleteForOperation:operationId withStatus:FALSE andData:nil];
        }
        NSLog(@"Recieved response for connection %d ", [httpResponse statusCode]);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mugConnectionListener onConnectionCompleteForOperation:operationId withStatus:YES andData:data];
}



@end
