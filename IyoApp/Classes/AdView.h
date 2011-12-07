//
//  AdView.h
//  IyoApp
//
//  Created by yuriy on 10/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AdView : UIViewController 
<UITableViewDelegate, UITableViewDataSource>
{
	NSDictionary *ad;
	NSDictionary *adImages;
	IBOutlet UITableView *adTblVIew;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil adId:(NSString *)adId;
@end
