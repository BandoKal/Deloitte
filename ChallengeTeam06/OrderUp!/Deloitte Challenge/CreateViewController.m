//
//  CreateViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/3/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()

@end

@implementation CreateViewController
@synthesize appDelegate;
@synthesize rssArray;
@synthesize startTableView, rssTableView;

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
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    /**********************************************
                Marked for Removal
     At this time appDelegate.xmlArray contains feed data...
     see FeedEntry.h for attr's!
     *********************************************/
    rssArray = [[NSMutableArray alloc] init];
    
    startTableView.delegate = self;
    startTableView.dataSource = self;
    rssTableView.delegate = self;
    rssTableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [startTableView reloadData];
    [rssTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"start"])
    {
        // ... 
    }
}

#pragma mark - TableView Delegate

// asks the delegate for the ehight to use for a row in a specified location
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == startTableView)
        return 75;
    else
        return 90;
}

// tells the delegate that the specified row is now selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == startTableView)
    {
        [self performSegueWithIdentifier:@"start" sender:self];
    }
}

// tells the delegate that the specified row is now unselected
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableView Data Source

// asks the data source for a cell to insert in a particular location of the table view (required)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    UITableViewCell *cell;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == startTableView)
    {
        cellIdentifier = @"startCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        // no further customization
    }
    else if (tableView == rssTableView)
    {
        cellIdentifier = @"rssCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UIWebView *webView = (UIWebView *)[cell viewWithTag:100];
    }
    
    return cell;
}

// asks the data source to return the number of sections in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// tells the data source to return the number of rows in a given section of a table view (required)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    if (tableView == startTableView)
        return 1;
    else if (tableView == rssTableView)
        return [rssArray count];
    
    return 0;
}

// asks the data source to return the titles for the sections for a table view
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // used for index list
    return nil;
}

// asks the data source for the title of the header of teh specified section of the table view
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == startTableView)
        return @" ";
    else if (tableView == rssTableView)
        return @"Places Near You";
    
    return nil;
}

@end
