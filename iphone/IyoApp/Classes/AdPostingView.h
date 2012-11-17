//
//  AdPostingView.h
//  IyoIyoApp
//
//  Created by yuriy on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdPosting.h"
#import "IyoAppAppDelegate.h"
#import "ImageAddingView.h"

@interface AdPostingView : UIViewController 
<UITableViewDelegate, UITableViewDataSource>
{
	IyoAppAppDelegate *appDelegate;
	IBOutlet UITableView *adPostingTable;
	AdPosting *adPost;
	ImageAddingView *iyoImageView;
}

@property (nonatomic, retain) IBOutlet UITableView *adPostingTable;

@end
