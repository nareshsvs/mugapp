//
//  MUGEventsViewController.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUGEventsViewController :  UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView_;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

//data source delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//table view delegates

@end
