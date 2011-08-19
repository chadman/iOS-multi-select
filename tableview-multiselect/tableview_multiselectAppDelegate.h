
//
//  Created by Meyer, Chad on 8/18/10.
//  Copyright 2011 52projects. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiSelectViewController;

@interface tableview_multiselectAppDelegate : NSObject <UIApplicationDelegate> {
    
    MultiSelectViewController *multiselectViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MultiSelectViewController *multiselectViewController;


@end
