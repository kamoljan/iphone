//
//  RootViewController.h
//  navBased
//
//  Created by yuriy on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "navBasedAppDelegate.h"
#import "adView.h"
#import "changeFilter.h"

@interface RootViewController : UITableViewController 
<UITableViewDelegate, UITableViewDataSource>
{		
	changeFilter *changeFilterController;
	adView *adViewContrloller;
  
	UIActivityIndicatorView *activityIndicator;
	navBasedAppDelegate	*appDelegate;
	NSMutableArray *resultsTitles;
	
	NSMutableArray *iyoThumbs;
	NSString *jsonString;
	NSOperationQueue *searchQueue;
		
}

@property (nonatomic, retain) adView *adViewController;
@property (nonatomic, retain) NSMutableArray *iyoThumbs;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSString *jsonString;
@property (nonatomic, retain) navBasedAppDelegate *appDelegate;
@property (nonatomic, retain) NSMutableArray *resultsTitles;
@property (nonatomic, retain) changeFilter *changeFilterController;
@property (nonatomic, retain) NSOperationQueue *searchQueue;

-(void) defaultSearchIyoiyoAds;
-(void) searchIyoAds:(NSDictionary *) filter;
-(void) loadAdsThumbs;
-(void) asyncThumbsStart;
-(void) reloadTableData:(NSIndexPath *)curPath;


@end
