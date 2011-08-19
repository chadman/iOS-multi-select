
//
//  Created by Meyer, Chad on 8/18/10.
//  Copyright 2011 52projects. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTPUIMultiSelectTableView;


@interface MultiSelectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    FTPUIMultiSelectTableView       *table;
    NSArray                         *tableResults;
    UIToolbar                       *toolBar;
}

@property (nonatomic, retain) FTPUIMultiSelectTableView *table;

@end
