//
//  DBSchema.h
//  MaaS360
//
//  Created by Neeraj Motwani on 17/05/11.
//  Copyright 2011 Fiberlink Communications Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


extern int const CURR_SCHEMA_VERSION;

extern NSString * const V1;

// Version 1
extern NSString * const V1_CREATE_EVENTS;
extern NSString * const V1_USER_PROFILE;

// Table Column names for event
extern NSString * const CL_EVENT_NAME;
extern NSString * const CL_START_TIME;
extern NSString * const CL_END_TIME;
extern NSString * const CL_TIMEZONE;
extern NSString * const CL_LOCATION;
extern NSString * const CL_DESCRIPTION;
extern NSString * const CL_VENUE;
extern NSString * const CL_UPDATE_TIME;
extern NSString * const CL_EVENT_HOST;
extern NSString *const  CL_EVENT_RSPVS_STATUS;
extern NSString *const  CL_EVENT_ID;


extern NSString * const CL_KEY;
extern NSString * const CL_VALUE;
