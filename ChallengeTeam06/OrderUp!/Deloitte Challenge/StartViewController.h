//
//  StartViewController.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/3/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIButton+DeloitteAdditions.h"
#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"

@class WEPopoverController;

@interface StartViewController : UIViewController
{
    WEPopoverController *popoverController;
}

@property (strong, nonatomic) AppDelegate *appDelegate;

@property (nonatomic, retain) WEPopoverController *popoverController;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

// Order Name
@property (weak, nonatomic) IBOutlet UITextField *orderName;
@property (weak, nonatomic) IBOutlet UIButton *orderNameHelp;
- (IBAction)orderNameHelpClicked:(id)sender;

// Location
@property (weak, nonatomic) IBOutlet UITextField *orderLoc;
@property (weak, nonatomic) IBOutlet UIButton *orderLocHelp;
- (IBAction)orderLocHelpClicked:(id)sender;


// Time Placed
@property (weak, nonatomic) IBOutlet UITextField *orderTime;
@property (weak, nonatomic) IBOutlet UIButton *orderTimeHelp;
- (IBAction)orderTimeHelpClicked:(id)sender;

@end
