//
//  CheckinTableCell.m
//  F1Touch
//
//  Created by Meyer, Chad on 2/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FTPUITableCell.h"

@interface FTPUITableCell (PRIVATE)
extern NSString * const NotificationPrefix;
extern NSString * const SelectedImageName;

- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size;
@end


@implementation FTPUITableCell
@synthesize hasMultiSelect;
@synthesize hasSelector;
@synthesize rowNumber;
@synthesize totalRowsInSection;
@synthesize isHighlighted;
@synthesize highlightedColor;
@synthesize unhighlightedColor;

NSString * const NotificationPrefix = @"FTPUITableView_";
NSString * const SelectedImageName = @"table_row_select.png";

-(void)setNotificationName:(NSString *)newString {
    if (_notificationName != newString) {
        [_notificationName release];
        _notificationName = [newString copy];
    }
}

- (id) notificationName {
	return _notificationName;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
		self.notificationName = [[NSString alloc] init];
        
        [self setHighlightedColor:[UIColor lightGrayColor]];
        [self setUnhighlightedColor:[UIColor whiteColor]];
    }
    return self;
}


// To make sure that nothing happens when the cell is selected (though it shouldn't be)
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}


- (void)dealloc {
	[_notificationName release];
    [highlightedColor release];
    [unhighlightedColor release];
    [super dealloc];
}

- (void) createCell: (NSIndexPath *)indexPath withSectionRows: (NSInteger)sectionRows withSelector:(BOOL)isSelector withHighlight:(BOOL)isHighlight {
	
	[self createCell:indexPath 
	 withSectionRows:sectionRows 
		withSelector:isSelector 
	   withHighlight:isHighlight 
	 withMultiSelect:NO];
}

- (void) createCell: (NSIndexPath *)indexPath withSectionRows: (NSInteger)sectionRows withSelector:(BOOL)isSelector withHighlight:(BOOL)isHighlight withMultiSelect:(BOOL)multiSelect {

	[self setHasSelector:isSelector];
	[self setRowNumber:[indexPath row]];
	[self setTotalRowsInSection:sectionRows];
	[self setHasMultiSelect:multiSelect];
	[self setIsHighlighted:isHighlight];
	[self drawCell:isHighlight];
}

- (void) drawCell: (BOOL)isHighlight {
    
	// If the cell has a selector, populate the selector view
	if (self.hasSelector) {
		if (isHighlight) {
            UIImage *table_row_select = [UIImage imageNamed:@"icon_check_square.gif"];
            ((UIImageView *)self.imageView).image = [self scale:table_row_select toSize:CGSizeMake(20, 20)];
            [self.contentView setBackgroundColor:self.highlightedColor];
		}
		else {
            UIImage *hollow_image = [UIImage imageNamed:@"select_hollow.png"];
            ((UIImageView *)self.imageView).image = [self scale:hollow_image toSize:CGSizeMake(20, 20)];
            [self.contentView setBackgroundColor:self.unhighlightedColor];
		}
	}
	
	[self changeLabelColors:isHighlight];
    

}

- (void) changeLabelColors:(BOOL) isHightlighted {

	// Find all labels that are part of the content view
	for (UIView *current in [self.contentView subviews]) {
		
		if ([current isKindOfClass:[UILabel class]]) {
			UILabel *currentLabel = (UILabel *)current;
			if(isHightlighted) {
				[currentLabel setTextColor:[UIColor whiteColor]];
			}
			else {
				[currentLabel setTextColor:[UIColor blackColor]];
			}
		}
	}
}

- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (hasSelector) {
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@%@", NotificationPrefix, [self notificationName]] object:self];
    }
}
@end
