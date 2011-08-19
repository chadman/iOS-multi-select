//
//  CheckinUITableView.h
//  F1Touch
//
//  Created by Meyer, Chad on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTPUITableCell.h"


@interface FTPUITableView : UITableView {

	NSMutableArray *selectedTableCells;
	BOOL isMultiSelect;
}

@property (nonatomic, retain) NSMutableArray *selectedTableCells;
@property (nonatomic, assign) BOOL isMultiSelect;

// Determiens if a specific table cell is selected
- (BOOL) isTableCellSelected:(NSInteger) rowNumber;

// If multi select is going to occur, init the table with this method to add the notification name
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)aStyle notification:(NSString *)notification;

@end
