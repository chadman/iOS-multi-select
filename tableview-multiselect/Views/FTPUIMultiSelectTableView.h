
//
//  Created by Meyer, Chad on 8/18/10.
//  Copyright 2011 52projects. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FTPUIMultiSelectTableView : UITableView {

	NSMutableArray *selectedTableCells;
    BOOL isMultiSelect;
}

@property (nonatomic, retain) NSMutableArray *selectedTableCells;

/* is the table set up for multi select If it is YES then the table will select multi items, 
   if NO then the table will only select one item and the previously selected item will not longer be selected*/
@property (nonatomic, assign) BOOL isMultiSelect;

// Determiens if a specific table cell is selected
- (BOOL) isTableCellSelected:(NSInteger) rowNumber;

// If multi select is going to occur, init the table with this method to add the notification name
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)aStyle notification:(NSString *)notification;

@end
