//
//  MUGEventsViewController.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGEventsViewController.h"
#import "SQLiteMgr.h"
#import "MUGAppUtils.h"
#import "MUGEventManager.h"
#import "MUGEventDetailsViewController.h"

@interface MUGEventsViewController ()

@end

@implementation MUGEventsViewController

@synthesize tableView=tableView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MUG Events";
   
}

- (void)onEventsInfoReceived
{
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(NSNotificationCenter *)[NSNotificationCenter defaultCenter] addObserver:self 
																	 selector:@selector(onEventsInfoReceived)
																		 name:kEventsInfoNotification
																	   object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[MUGEventManager getInstance] getNumOfEvents];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *eventCell = [tableView dequeueReusableCellWithIdentifier:kEventCell];
    if(eventCell == nil)
    {
        eventCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kEventCell] autorelease];
        [eventCell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    
    
    MUGEvent *event = (MUGEvent *)[[MUGEventManager getInstance] getEventAtIndex:indexPath];
    if(event != NULL)
    {
        eventCell.textLabel.text = event.eventName;
        eventCell.detailTextLabel.text = [MUGAppUtils getDateAsDisplayString:event.eventStartTime];
    }
  
    return eventCell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    MUGEventDetailsViewController* eventDetailView = [[MUGEventDetailsViewController alloc] initWithNibName:@"EventDetail" bundle:nil];
    
    eventDetailView.eventID = [[[MUGEventManager getInstance] getEventAtIndex:indexPath] eventID];
    [self.navigationController pushViewController:eventDetailView animated:YES];
    [eventDetailView release];
}


@end
