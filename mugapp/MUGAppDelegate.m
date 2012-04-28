//
//  MUGAppDelegate.m
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUGAppDelegate.h"
#import "MUGViewController.h"
#import "MUGSummaryViewController.h"
#import "SQLiteMgr.h"
#import "FBDataManager.h"

@interface MUGAppDelegate()

-(void) initializeAppContext;

@end

@implementation MUGAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize facebook;

-(void) initializeAppContext
{
    // Initialize Facebook
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self.viewController];
    if([MUGAppUtils getCurrentAuthToken] != nil)
    {
        facebook.accessToken = [MUGAppUtils getCurrentAuthToken];
        facebook.expirationDate = [MUGAppUtils getExpiryDate];
    }
    
    
    // Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
 
    [SQLiteMgr getSharedInstance];
    //[MUGAppUtils insertDummyEvents];
    
}

- (void)dealloc
{return
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[MUGViewController alloc] initWithNibName:@"MUGViewController_iPhone" bundle:nil] autorelease];
    } else {
        self.viewController = [[[MUGViewController alloc] initWithNibName:@"MUGViewController_iPad" bundle:nil] autorelease];
    }
    
    [self initializeAppContext];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

-(void) loadSummaryController
{
    if([MUGAppUtils isIpad])
    {
        
    }
    else
    {
        //create summary controller and present it within a navigation controller
        MUGSummaryViewController* summaryController = [[[MUGSummaryViewController alloc] initWithNibName:@"SummaryView" bundle:nil] autorelease];
    
        mugAppNavController = [[UINavigationController alloc] initWithRootViewController:summaryController];
        
        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {  
            
            [self.viewController presentViewController:mugAppNavController animated:YES completion:nil];
        }
        else {
            
            [self.viewController presentModalViewController:mugAppNavController animated:YES];
        }
    }
    
    [[FBDataManager getInstance] syncData];    
}


+ (MUGAppDelegate *) getInstance
{
    return (MUGAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [facebook extendAccessTokenIfNeeded];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url];
}


@end
