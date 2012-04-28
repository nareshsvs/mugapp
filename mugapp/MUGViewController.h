//
//  MUGViewController.h
//  mugapp
//
//  Created by Naresh Srungarakavi on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"


@interface MUGViewController : UIViewController<FBRequestDelegate,FBDialogDelegate,FBSessionDelegate>
{
    UIButton* loginButton_;
    UIButton* offlineButton;    
}


@property(nonatomic, retain) IBOutlet UIButton* loginButton;
@property(nonatomic, retain) IBOutlet UIButton* offlineButton;

-(IBAction) loginWithFacebook:(id)sender;
-(IBAction) viewOffline:(id)sender;


@end
