//
//  CheckinTableCell.m
//  F1Touch
//
//  Created by Meyer, Chad on 2/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FTPUIMultiSelectTableViewCell.h"

@interface FTPUIMultiSelectTableViewCell (PRIVATE)
extern NSString * const NotificationPrefix;
extern NSString * const SelectedImageName;

- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size;
@end


@implementation FTPUIMultiSelectTableViewCell
@synthesize hasSelector;
@synthesize rowNumber;
@synthesize totalRowsInSection;
@synthesize isSelected;
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

- (void)dealloc {
	[_notificationName release];
    [highlightedColor release];
    [unhighlightedColor release];
    [super dealloc];
}

- (void) drawCell:(NSIndexPath *)indexPath withSectionRows:(NSInteger)sectionRows hasSelector:(BOOL)selector isSelected:(BOOL)selected {
	
    [self setHasSelector:selector];
	[self setRowNumber:[indexPath row]];
	[self setTotalRowsInSection:sectionRows];
	[self setIsSelected:selected];
	[self drawCell:selected];
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

- (void) changeLabelColors:(BOOL) selected {

	// Find all labels that are part of the content view
	for (UIView *current in [self.contentView subviews]) {
		
		if ([current isKindOfClass:[UILabel class]]) {
			UILabel *currentLabel = (UILabel *)current;
			if(selected) {
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
