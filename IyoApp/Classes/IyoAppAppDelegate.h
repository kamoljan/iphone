//
//  IyoAppAppDelegate.h
//  IyoApp
//
//  Created by yuriy on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdPosting.h"

@interface IyoAppAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	AdPosting *iyoAdPosting;
	NSArray *searchFilter;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) AdPosting *iyoAdPosting;
@property (nonatomic, retain) NSArray *searchFilter;
@end

