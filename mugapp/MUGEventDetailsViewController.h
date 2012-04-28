//
//  MUGEventDetailsViewController.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUGEvent.h"

@interface MUGEventDetailsViewController :  UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView_;
    UIBarButtonItem *acceptButton_;
    UIBarButtonItem *declineButton_;
    UIBarButtonItem *syncToCalButton_;
    NSString *eventID;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *acceptButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *declineButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *syncToCalButton;

@property(nonatomic, retain) NSString *eventID;

- (IBAction) acceptEvent:(id)sender;
- (IBAction) declineEvent:(id)sender;
- (IBAction) syncToCalEvent:(id)sender;


//data source delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//table view delegates

@end
