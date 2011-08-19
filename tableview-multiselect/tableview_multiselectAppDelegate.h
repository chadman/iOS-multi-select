//
//  tableview_multiselectAppDelegate.h
//  tableview-multiselect
//
//  Created by Chad Meyer on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiSelectViewController;

@interface tableview_multiselectAppDelegate : NSObject <UIApplicationDelegate> {
    
    MultiSelectViewController *multiselectViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MultiSelectViewController *multiselectViewController;


@end
