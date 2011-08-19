
//
//  Created by Meyer, Chad on 8/18/10.
//  Copyright 2011 52projects. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FTPUIMultiSelectTableViewCell : UITableViewCell {
	
	BOOL hasSelector;
	NSInteger rowNumber;
	NSInteger totalRowsInSection;
	BOOL isSelected;
	NSString *_notificationName;
    UIColor *highlightedColor;
    UIColor *unhighlightedColor;
}

/* detemine if the table cell has a selector which is the image to the left */
@property (nonatomic, assign) BOOL hasSelector;

/* Used by the table view notification to determine what to draw for a specific cell */
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, assign) NSInteger totalRowsInSection;

/* Is the cell selected */ 
@property (nonatomic, assign) BOOL isSelected;

/* the name of the notification which should be the same as the FTPUIMultiSelectTableView */
@property (nonatomic, copy) NSString *notificationName;

/* Properties to set the background colors of the cell for specific states */
@property (nonatomic, retain) UIColor *highlightedColor;
@property (nonatomic, retain) UIColor *unhighlightedColor;

/* Draw the cell 
   @indexPath the index oath it is in the table view
   @sectionRows the number of rows in the section of the table view the cell is a part of
   @selector: Does the table view cell has a selector
   @selected: is the cell selected
*/
- (void) drawCell: (NSIndexPath *)indexPath withSectionRows: (NSInteger)sectionRows hasSelector:(BOOL)selector isSelected:(BOOL)selected;

// Call this method when the table view calls delegate didSelectRowAtIndexPath
- (void) drawCell: (BOOL)isHighlight;

/* Changes the color of the labels for the cell depending on if it is selected */
- (void) changeLabelColors:(BOOL) selected;

@end
