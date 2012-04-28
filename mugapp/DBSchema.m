//
//  DBSchema.m
//  MaaS360
//
//  Created by Neeraj Motwani on 17/05/11.
//  Copyright 2011 Fiberlink Communications Ltd. All rights reserved.
//

#import "DBSchema.h"


int const CURR_SCHEMA_VERSION = 1;
NSString * const V1 = @"1";

// Version 1
NSString * const V1_CREATE_EVENTS = @"create table if not exists mug_events( \
                                      event_name, start_time varchar, \
                                      end_time varchar, timezone varchar, location varchar, description varchar, \
                                      venue varchar, update_time varchar, event_host varchar, rsvp_status varchar, \
                                      event_id varhchar PRIMART_KEY UNIQUE )";


NSString * const V1_USER_PROFILE = @"create table if not exists user_profile (key varchar PRIMARY_KEY UNIQUE, value varchar)";

// Table Column names for event
NSString * const CL_EVENT_NAME = @"event_name";
NSString * const CL_START_TIME = @"start_time";
NSString * const CL_END_TIME = @"end_time";
NSString * const CL_TIMEZONE = @"timezone";
NSString * const CL_LOCATION = @"location";
NSString * const CL_DESCRIPTION = @"description";
NSString * const CL_VENUE = @"venue"; 
NSString * const CL_UPDATE_TIME = @"update_time";
NSString * const CL_EVENT_HOST = @"event_host";
NSString *const  CL_EVENT_RSPVS_STATUS = @"rsvp_status";
NSString *const  CL_EVENT_ID = @"event_id";


NSString * const CL_KEY = @"key";
NSString * const CL_VALUE = @"value";

