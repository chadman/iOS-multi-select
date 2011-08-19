//
//  CheckinUITableView.m
//  F1Touch
//
//  Created by Meyer, Chad on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FTPUIMultiSelectTableView.h"
#import "FTPUIMultiSelectTableViewCell.h"

@interface FTPUIMultiSelectTableView (PRIVATE) 

- (void) setNotification:(NSString *)value;
@end

@implementation FTPUIMultiSelectTableView
@synthesize selectedTableCells;
@synthesize isMultiSelect;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)aStyle {

	return [self initWithFrame:frame 
						 style:aStyle 
				  notification:nil];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)aStyle notification:(NSString *)notification {
    if ((self = [super initWithFrame:frame style:aStyle])) {
        // Initialization code
        self.allowsSelection = NO;

		// Create a notification to select table cells
		self.selectedTableCells = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(notificationChangeSelectedCells:) 
                                                     name: [NSString stringWithFormat:@"FTPUITableView_%@", notification] 
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [selectedTableCells release];
    [super dealloc];
}

#pragma mark -
#pragma mark Custom Methods

- (void) notificationChangeSelectedCells: (NSNotification *) notification {
	
	FTPUIMultiSelectTableViewCell *notificationTableCell = (FTPUIMultiSelectTableViewCell *)[notification object];
	
	if (self.isMultiSelect) {
		
		// If the object is not a check in table cell, we are not interested in it
		if ([[notification object] isKindOfClass:[FTPUIMultiSelectTableViewCell class]]) {
			
			if ([self isTableCellSelected:[notificationTableCell rowNumber]]) {
				[self.selectedTableCells removeObject:[NSNumber numberWithInteger:[notificationTableCell rowNumber]]];
			}
			else {
				[self.selectedTableCells addObject:[NSNumber numberWithInteger:[notificationTableCell rowNumber]]];
			}
			
			// Draw the cell
			[notificationTableCell drawCell:[self isTableCellSelected:[notificationTableCell rowNumber]]];
		}
	}
	else {
		// get all the visible cells to deselect one of the cells
		NSArray *visible = [self visibleCells];
		
		for (FTPUIMultiSelectTableViewCell *current in visible) {
			if (current.rowNumber != notificationTableCell.rowNumber) {
				current.isSelected = NO;
				[current drawCell:NO];
			}
			else {
				current.isSelected = YES;
				[current drawCell:YES];
			}

		}
	}
}

- (BOOL) isTableCellSelected:(NSInteger) rowNumber {
	
	BOOL selectedFound = NO;
	
	
	// Determine if the table cell should be part of the list
	for (NSNumber *current in self.selectedTableCells) {
		// The array holds the row number so remove it
		if (current == [NSNumber numberWithInteger:rowNumber]) {
			selectedFound = YES;
			break;
		}
	}
	
	return selectedFound;
}

#pragma mark -
#pragma mark Overrideen Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//[self deselectRowAtIndexPath:indexPath animated:NO];
}

@end
