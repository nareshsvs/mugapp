//
//  MUGEventDetailsViewController.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGEventDetailsViewController.h"
#import "MUGAppUtils.h"
#import "FBDataManager.h"
#import "SQLiteMgr.h"

#define kStdButtonWidth		200
#define kStdButtonHeight	40.0
#define kViewTag            1000

@interface MUGEventDetailsViewController ()
{
    NSMutableArray* eventInfoTitles;
    UIButton* infoButton; 
    UIActivityIndicatorView* activityIndicator;
    MUGEvent* event;
}

@property (nonatomic, assign) NSArray* eventInfoTitles;
@property (nonatomic, retain) UIButton* infoButton;
@property (nonatomic, retain) UIView    *footerView;
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, retain) MUGEvent* event;

- (void) getEventDescription:(id)sender;

@end

@implementation MUGEventDetailsViewController

@synthesize tableView=tableView_;
@synthesize acceptButton=acceptButton_;
@synthesize declineButton=declineButton_;
@synthesize syncToCalButton=syncToCalButton_;
@synthesize eventID;
@synthesize eventInfoTitles;
@synthesize infoButton;
@synthesize footerView;
@synthesize activityIndicator;
@synthesize event;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    MUGEvent* mugEvent =  [[SQLiteMgr getSharedInstance].eventDao getMugEventByID:self.eventID];
    self.event = mugEvent;
    
    self.eventInfoTitles = [[NSMutableArray alloc] initWithObjects:@"Event Name", @"Start Time", @"End Time", @"Event Venue", @"Event status", nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [eventInfoTitles release];
    
    self.footerView = nil;
    self.infoButton = nil;
    self.activityIndicator = nil;
    // Release any retained subviews of the main view.
}

-(void)showIndicator
{
    if(self.activityIndicator == nil) {
        UIActivityIndicatorView* activityIndicatorTemp = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicatorTemp.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
         // activityIndicatorTemp.backgroundColor=[UIColor grayColor];
        activityIndicatorTemp.center = self.view.center;
        self.activityIndicator=activityIndicatorTemp;
        [activityIndicatorTemp release];
        [self.view addSubview: activityIndicator];
        [self.view bringSubviewToFront:activityIndicator];
    }
    [self.activityIndicator startAnimating];
}

- (void)showInfoButton
{	
    CGRect buttonFrame = CGRectMake(10, 30, 300, 44);
	if (self.infoButton == nil)
	{
		UIButton *tempButton = [[UIButton alloc] initWithFrame:buttonFrame];
		[tempButton setBackgroundImage:[UIImage imageNamed:@"button_normal.png"] forState:UIControlStateNormal];
		[tempButton setBackgroundImage:[UIImage imageNamed:@"button_selected.png"] forState:UIControlStateHighlighted];
		[tempButton setTitle:@"More Details" forState:UIControlStateNormal];
		[tempButton setTitle:@"More Details" forState:UIControlStateHighlighted];
		[tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
		[tempButton addTarget:self action:@selector(getEventDescription:) forControlEvents:UIControlEventTouchUpInside];
		self.infoButton = tempButton;
		[tempButton release];
		tempButton = nil;
	}
	
	
    CGRect footerFrame = CGRectMake(0, 0, 320, 190);
    UIView *tempFooterView = [[UIView alloc] initWithFrame:footerFrame];
    [tempFooterView addSubview:self.infoButton];
    
    [self.tableView setTableFooterView:tempFooterView];
    self.footerView = tempFooterView;
    [tempFooterView release];
    tempFooterView = nil;
}


-(void)onEventsDetailsReceived
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    self.activityIndicator = nil;
    
    MUGEvent *mugEvent = [[SQLiteMgr getSharedInstance].eventDao getMugEventByID:event.eventID];
    self.event = mugEvent;
    
    if(self.event.description != nil && [self.event.description length] > 0) {
        [eventInfoTitles addObject:@"Description"];
        [self.tableView setTableFooterView:nil];
    }
    else {
        [eventInfoTitles removeObject:@"Description"];
        [self showInfoButton];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    if([[self.event participationStatus] isEqualToString:@"attending"] ||
       [[self.event participationStatus] isEqualToString:@"declined"] ) {
       
        self.acceptButton.enabled = NO;
        self.declineButton.enabled = NO;
    }
    else {
        
        self.acceptButton.enabled = YES;
        self.declineButton.enabled = YES;
    }
    
    if(self.event.description != nil && [self.event.description length] > 0) {
        [eventInfoTitles addObject:@"Description"];
        [self.tableView setTableFooterView:nil];
    }
    else {
        [eventInfoTitles removeObject:@"Description"];
        [self showInfoButton];
        
    }
    [self.tableView reloadData];
    
    [(NSNotificationCenter *)[NSNotificationCenter defaultCenter] addObserver:self 
																	 selector:@selector(onEventsDetailsReceived)
																		 name:kEventsDetailsNotification
																	   object:nil];
}

 
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) getEventDescription:(id)sender
{
    self.infoButton.enabled = NO;
    [self showIndicator];
    [[FBDataManager getInstance] makeFBObjectRequestWithObjectID:event.eventID ];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [eventInfoTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [eventInfoTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellidentifier = @"cellIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(indexPath.section == 0) {
        cell.textLabel.text = event.eventName;
    }
    else if(indexPath.section == 1){
        
        cell.textLabel.text = [MUGAppUtils getDateAsDisplayString:event.eventStartTime ];
    }
    else if(indexPath.section == 2){
        cell.textLabel.text = [MUGAppUtils getDateAsDisplayString:event.eventEndTime ];
    }
    else if(indexPath.section == 3){
        cell.textLabel.text = event.eventLocation;
    }
    else if(indexPath.section == 4){
        cell.textLabel.text = event.participationStatus;
    }
    else if(indexPath.section == 5){
        cell.textLabel.text = event.description;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 5) {
        return [MUGAppUtils getDisplayHeightForString:self.event.description];
    }
    return 48.0;
}

- (IBAction) acceptEvent:(id)sender
{
    
}

- (IBAction) declineEvent:(id)sender
{
    
}

- (IBAction) syncToCalEvent:(id)sender
{
    
}


-(void) dealloc
{   
    [tableView_ release];
    [acceptButton_ release];
    [declineButton_ release];
    [syncToCalButton_ release];
    [event release];
    [eventID release];
    [activityIndicator release];
    [footerView release];
    [infoButton release];
    
    [super dealloc];
    
}

@end
