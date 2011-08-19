//
//  MultiSelectViewController.m
//  tableview-multiselect
//
//  Created by Chad Meyer on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiSelectViewController.h"
#import "FTPUIMultiSelectTableView.h"
#import "FTPUIMultiSelectTableViewCell.h"


@implementation MultiSelectViewController
@synthesize table;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [table release];
    [toolBar release];
    [tableResults release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
    self.view = view;
    [view release];
    
}

- (void)viewDidLoad
{
    
    // Create the table view
	self.table = [[FTPUIMultiSelectTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain notification:@"multi_select"];
	self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.table.backgroundColor = [UIColor whiteColor];
    [self.table setIsMultiSelect:YES];
	[self.table setDelegate:self];
	[self.table setDataSource:self];
	[self.view addSubview:self.table];
    
    // Create a tool bar for the bottom of the view
	toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 410, 320, 50)];
	toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *toolBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Count Selected" style:UIBarButtonItemStyleBordered target:self action:@selector(countSelected)];
	NSMutableArray *toolBarButtons = [[NSMutableArray alloc] init];
	
	[toolBarButtons addObject:toolBarButton];
	[toolBar setItems:toolBarButtons];
    
    [self.view addSubview:toolBar];
	
	// release the objects
	[toolBarButton release];
	[toolBarButtons release];

    tableResults = [[NSArray alloc] initWithObjects:@"Page One", @"Page Two", @"Page Three", @"Page Four", nil];
    
    [super viewDidLoad];
}
	
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *arrayText = [tableResults objectAtIndex:[indexPath row]];
    
	static NSString *CellIdentifier = @"Cell";
    FTPUIMultiSelectTableViewCell *cell = (FTPUIMultiSelectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[FTPUIMultiSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;

		// Notification name is the way the table view knows that to check for multi select
		cell.notificationName = @"multi_select";
		
        
        UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 240, 15)];
		[cellLabel setBackgroundColor:[UIColor clearColor]];
		[cellLabel setTextAlignment:UITextAlignmentLeft];
		[cellLabel setFont:[UIFont boldSystemFontOfSize:14]];
		[cellLabel setTag:100];
		[cell.contentView addSubview:cellLabel];
		[cellLabel release];
	}
	
	// Creates the cell with all the necessary variables to set up custom UX presentation
	[cell drawCell:indexPath 
   withSectionRows:[tableView numberOfRowsInSection:[indexPath section]] 
       hasSelector:YES 
        isSelected:[table isTableCellSelected:[indexPath row]]];
    
    UILabel *cellLabel = (UILabel *)[cell.contentView viewWithTag:100];
    [cellLabel setText:arrayText];

    return cell;

}


- (void) countSelected {
    
    NSString *message = [[NSString alloc] init];
    
    if ([[table selectedTableCells] count] == 1) {
        message = [NSString stringWithFormat:@"There is %d selected item.", [[table selectedTableCells] count]];
    }
    else {
        message = [NSString stringWithFormat:@"There are %d selected items.", [[table selectedTableCells] count]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cell Count" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
