//
//  MUGAppDelegate.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "MUGAppUtils.h"


@class MUGViewController;

@interface MUGAppDelegate : UIResponder <UIApplicationDelegate>
{
    Facebook *facebook;
    UINavigationController* mugAppNavController;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MUGViewController *viewController;
@property (readonly) Facebook *facebook;

+ (MUGAppDelegate *) getInstance;
-(void) loadSummaryController;

@end
