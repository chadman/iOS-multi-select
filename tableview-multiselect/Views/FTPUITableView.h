
//
//  Created by Meyer, Chad on 8/18/10.
//  Copyright 2011 52projects. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FTPUITableView : UITableView {

	NSMutableArray *selectedTableCells;
}

@property (nonatomic, retain) NSMutableArray *selectedTableCells;

// Determiens if a specific table cell is selected
- (BOOL) isTableCellSelected:(NSInteger) rowNumber;

// If multi select is going to occur, init the table with this method to add the notification name
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)aStyle notification:(NSString *)notification;

@end
