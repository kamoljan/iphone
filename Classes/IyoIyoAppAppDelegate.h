//
//  IyoIyoAppAppDelegate.h
//  IyoIyoApp
//
//  Created by yuriy on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdPosting.h"

@class IyoIyoAppViewController;

@interface IyoIyoAppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IyoIyoAppViewController *viewController;
	AdPosting *iyoAdPosting;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IyoIyoAppViewController *viewController;
@property (nonatomic, retain) AdPosting *iyoAdPosting;

@end

