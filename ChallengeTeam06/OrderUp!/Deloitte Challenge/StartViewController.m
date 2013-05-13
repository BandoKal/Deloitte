//
//  StartViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/3/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController
@synthesize appDelegate;
@synthesize orderName, orderNameHelp;
@synthesize orderLoc, orderLocHelp;
@synthesize orderTime, orderTimeHelp;
@synthesize popoverController;
@synthesize datePicker;

CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

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
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // set up the date picker
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    [self.datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    self.orderTime.inputView = self.datePicker;
    
    // set text field delegate
    orderName.delegate = self;
    orderLoc.delegate = self;
    orderTime.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.popoverController dismissPopoverAnimated:NO];
    self.popoverController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dateChanged
{
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    self.orderTime.text = [dateFormat stringFromDate:date];
}

- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    CGFloat heightFraction = textField.bounds.origin.y;
    
    // convert heightFraction to a scroll amount
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait)
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    else
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    
    if (textField.bounds.origin.y >= textField.bounds.origin.y)//(self.view.window.bounds.size.height - PORTRAIT_KEYBOARD_HEIGHT - textField.frame.size.height))
    {
        NSLog(@"here");
        // FINISH HERE!!
        //animatedDistance = textField.bounds.origin.y - (self.view.window.bounds.size.height - PORTRAIT_KEYBOARD_HEIGHT) - textField.frame.size.height;
        animatedDistance = 0;//  FINISH HERE!
    }
    else
    {
        animatedDistance = 0;
    }
    
    // apply the animation
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)orderNameHelpClicked:(id)sender
{
    // change bool value in appdelegate array
    [appDelegate.helpButtonValues setValue:@"YES" forKey:@"orderName"];
    
    // create popover
    if (self.popoverController)
    {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
    else
    {
        UIViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        
        self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
        [self.popoverController presentPopoverFromRect:orderNameHelp.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
}

- (IBAction)orderLocHelpClicked:(id)sender
{
    // change bool value in appdelegate array
    [appDelegate.helpButtonValues setValue:@"YES" forKey:@"orderLoc"];
    
    // create popover
    if (self.popoverController)
    {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
    else
    {
        UIViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        
        self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
        [self.popoverController presentPopoverFromRect:orderLocHelp.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
}

- (IBAction)orderTimeHelpClicked:(id)sender {
}
@end
