//
//  CheckinUITableView.m
//  F1Touch
//
//  Created by Meyer, Chad on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FTPUITableView.h"
#import "FTPUITableCell.h"

@interface FTPUITableView (PRIVATE) 

- (void) setNotification:(NSString *)value;
@end

@implementation FTPUITableView
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
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(notificationChangeSelectedCells:) name: [NSString stringWithFormat:@"FTPUITableView_%@", notification] object:nil];
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
	
	FTPUITableCell *notificationTableCell = (FTPUITableCell *)[notification object];
	
	if (notificationTableCell.hasMultiSelect) {
		
		// If the object is not a check in table cell, we are not interested in it
		if ([[notification object] isKindOfClass:[FTPUITableCell class]]) {
			
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
		
		for (FTPUITableCell *current in visible) {
			if (current.rowNumber != notificationTableCell.rowNumber) {
				current.isHighlighted = NO;
				[current drawCell:NO];
			}
			else {
				current.isHighlighted = YES;
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

- (CGFloat)getHeightForText:(NSString *)text {
	CGSize aSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:11] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:UILineBreakModeWordWrap];
	
	return aSize.height;
}

#pragma mark -
#pragma mark Overrideen Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//[self deselectRowAtIndexPath:indexPath animated:NO];
}

@end
