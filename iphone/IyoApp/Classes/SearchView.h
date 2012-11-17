//
//  SearchView.h
//  IyoApp
//
//  Created by yuriy on 10/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Search.h"

@interface SearchView : UIViewController 
<UITableViewDataSource, UITableViewDelegate>
{
	UITableView *adsTable;
	Search *adsList;
	int pageNumber;	
	UIActivityIndicatorView *activityImage;
}

@property (nonatomic, retain) IBOutlet UITableView *adsTable;
@end
