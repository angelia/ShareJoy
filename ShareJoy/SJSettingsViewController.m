//
//  SJSettingsViewController.m
//  Share Joy
//
//  Created by WANGLI on 12-10-18.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import "SJSettingsViewController.h"
#import "SJWBSettingsViewController.h"
#import "SJFBSettingsViewController.h"

@interface SJSettingsViewController ()

@end

@implementation SJSettingsViewController
@synthesize row_data;

- (void)returnToHomePage {
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_default.png"]];
    self.tableView.backgroundView = view;
    [view release];
    
//    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_default.png"]]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    row_data = [[NSArray alloc]initWithObjects:@"Facebook", @"Weibo", @"Flickr", @"About",nil];
    
    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(returnToHomePage)];
    [self.navigationItem setLeftBarButtonItem:btn_left animated:YES];

}

- (void)dealloc
{
    [super dealloc];
    [row_data release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
//    return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
//    return 0;
    return row_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor grayColor];
    
    // Configure the cell...
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    cell.textLabel.text = [row_data objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (indexPath.row == 0) {
        
        SJFBSettingsViewController *fbViewController = [[SJFBSettingsViewController alloc]initWithNibName:@"SJFBSettingsViewController" bundle:nil];
        
        [self.navigationController pushViewController:fbViewController animated:YES];
        
        [fbViewController release];
    }
    else if(indexPath.row == 1){
        
        SJWBSettingsViewController *wbsViewController = [[SJWBSettingsViewController alloc]initWithNibName:@"SJWBSettingsViewController" bundle:nil];
        
        [self.navigationController pushViewController:wbsViewController animated:YES];
        
        [wbsViewController release];
    }
    else if(indexPath.row ==2){
        
//        SJGoogleViewController *googleVC = [[SJGoogleViewController alloc]initWithNibName:@"SJGoogleViewController" bundle:nil];
//        [self.navigationController pushViewController:googleVC animated:YES];
//        
//        [googleVC release];
    }
    else{
        
    }
}

@end
