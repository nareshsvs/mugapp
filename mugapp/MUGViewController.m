//
//  MUGViewController.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGViewController.h"
#import "MUGAppDelegate.h"
#import "MUGSummaryViewController.h"

@interface MUGViewController ()


@end

@implementation MUGViewController

@synthesize loginButton=loginButton_;
@synthesize offlineButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MUGAppDelegate *mugInstance = [MUGAppDelegate getInstance];
    
    if([mugInstance.facebook isSessionValid])
    {
        [[MUGAppDelegate getInstance] loadSummaryController];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(IBAction) loginWithFacebook:(id)sender
{

    MUGAppDelegate *mugInstance = [MUGAppDelegate getInstance];
    [mugInstance.facebook authorize:[MUGAppUtils getDesiredPermissionForMugApp]];  
    
}


-(IBAction) viewOffline:(id)sender
{
    [[MUGAppDelegate getInstance] loadSummaryController];
}




/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    
    MUGAppDelegate* instance = [MUGAppDelegate getInstance];
    NSString* accessToken = [instance.facebook accessToken];
    NSDate* expiryTime = [instance.facebook expirationDate];
    [MUGAppUtils persistAuthToken:accessToken withExpiry:expiryTime];

    
    [[MUGAppDelegate getInstance] loadSummaryController];
    
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    
    [MUGAppUtils persistAuthToken:accessToken withExpiry:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {

    [MUGAppUtils clearTokenCache];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    
    [MUGAppUtils clearTokenCache];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [alertView release];
    
    [self fbDidLogout];
}




@end
