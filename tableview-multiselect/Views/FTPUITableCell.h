
//
//  Created by Meyer, Chad on 8/18/10.
//  Copyright 2011 52projects. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FTPUITableCell : UITableViewCell {
	
	BOOL hasMultiSelect;
	BOOL hasSelector;
	NSInteger rowNumber;
	NSInteger totalRowsInSection;
	BOOL isHighlighted;
	NSString *_notificationName;
    
    UIColor *highlightedColor;
    UIColor *unhighlightedColor;
}

@property (nonatomic, assign) BOOL hasMultiSelect;
@property (nonatomic, assign) BOOL hasSelector;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, assign) NSInteger totalRowsInSection;
@property (nonatomic, assign) BOOL isHighlighted;
@property (nonatomic, copy) NSString *notificationName;

@property (nonatomic, retain) UIColor *highlightedColor;
@property (nonatomic, retain) UIColor *unhighlightedColor;

- (void) createCell: (NSIndexPath *)indexPath withSectionRows: (NSInteger)sectionRows withSelector:(BOOL)isSelector withHighlight:(BOOL)isHighlight;

- (void) createCell: (NSIndexPath *)indexPath withSectionRows: (NSInteger)sectionRows withSelector:(BOOL)isSelector withHighlight:(BOOL)isHighlight withMultiSelect:(BOOL)multiSelect;

// Call this method when the table view calls delegate didSelectRowAtIndexPath
- (void) drawCell: (BOOL)isHighlight;

- (void) changeLabelColors:(BOOL) isHightlighted;

@end
