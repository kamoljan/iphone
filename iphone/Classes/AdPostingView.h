//
//  AdPostingView.h
//  IyoIyoApp
//
//  Created by yuriy on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AdPostingView : UIViewController 
<UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UITableView *adPostingTable;
}

@property (nonatomic, retain) IBOutlet UITableView *adPostingTable;

@end
