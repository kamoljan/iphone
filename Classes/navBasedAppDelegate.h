//
//  navBasedAppDelegate.h
//  navBased
//
//  Created by yuriy on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface navBasedAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;	
	NSString *adId;	
	NSMutableArray *searchResults;
	Boolean needToRefresh;
	
	// new standarted changes
	NSMutableDictionary *searchFilter;	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSString *adId;
@property (nonatomic, retain) NSMutableArray *searchResults;
@property (nonatomic, retain) NSMutableDictionary *searchFilter;
@property (nonatomic, assign) Boolean needToRefresh;

-(void) someFunction;
-(IBAction) changeFilter;
-(IBAction) iyoAdForm;

@end

