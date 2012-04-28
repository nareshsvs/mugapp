//
//  MUGEvent.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUGEvent : NSObject
{
    
    NSString* eventOwner_;
    NSString* eventName_;
    NSString* description_;
    NSDate* eventStartTime_;
    NSDate* eventEndTime_;
    NSString* eventTimeZone_;
    NSString* eventLocation_;
    NSString* eventVenue_;
    NSDate* eventLastUpdatedOn_;
    NSString* participationStatus_;
    NSString* eventID_;
    
}

@property(nonatomic, copy) NSString* eventOwner;
@property(nonatomic, copy) NSString* eventName;
@property(nonatomic, copy) NSString* description;
@property(nonatomic, copy) NSDate* eventStartTime;
@property(nonatomic, copy) NSDate* eventEndTime;
@property(nonatomic, copy) NSString* eventTimeZone;
@property(nonatomic, copy) NSString* eventLocation;
@property(nonatomic, copy) NSString* eventVenue;
@property(nonatomic, copy) NSDate* eventLastUpdatedOn;
@property(nonatomic, copy) NSString* participationStatus;
@property(nonatomic, copy) NSString* eventID;

@end
