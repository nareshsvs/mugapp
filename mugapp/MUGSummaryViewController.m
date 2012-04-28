//
//  MUGSummaryViewController.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGSummaryViewController.h"
#import "MUGAppDelegate.h"
#import "MUGFeedsViewController.h"
#import "MUGEventsViewController.h"

@interface MUGSummaryViewController ()
{
    NSArray *summaryItems;
    
}


@end

@implementation MUGSummaryViewController

@synthesize tableView=tableView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        summaryItems = [[NSArray alloc] initWithObjects:kEvents, nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //customize your navigation title bar
    UINavigationController *navController = self.navigationController;
    navController.title = @"MUG";
    
    self.title = @"MUG";
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:kRefreshButton
                                                                      style:UIBarButtonItemStyleBordered 
                                                                      target:self 
                                                                      action:@selector(refreshButtonPressed)] autorelease];
    
	// Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [summaryItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *summaryCell = [tableView dequeueReusableCellWithIdentifier:kSummaryCell];
    if(summaryCell == nil)
    {
        summaryCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSummaryCell] autorelease];
        [summaryCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    [summaryCell.textLabel setText:[summaryItems objectAtIndex:indexPath.row]];
    return summaryCell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if([[cell.textLabel text] isEqualToString:kFeeds])
    {
        MUGFeedsViewController *feedsController = [[MUGFeedsViewController alloc] initWithNibName:@"FeedsListView" bundle:nil];
        [self.navigationController pushViewController:feedsController animated:YES];
    }
    else if([[cell.textLabel text] isEqualToString:kEvents])
    {
        MUGEventsViewController *eventsController = [[MUGEventsViewController alloc] initWithNibName:@"EventListView" bundle:nil];
        [self.navigationController pushViewController:eventsController animated:YES];
    }
}

- (void) refreshButtonPressed
{
    
    
}


-(void) dealloc
{
    [tableView_ release];
    [super dealloc];
}

@end
