//
//  MultiSelectViewController.h
//  tableview-multiselect
//
//  Created by Chad Meyer on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTPUITableView;


@interface MultiSelectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    FTPUITableView      *table;
    NSArray             *tableResults;
    UIToolbar			*toolBar;
}

@property (nonatomic, retain) FTPUITableView *table;

@end
