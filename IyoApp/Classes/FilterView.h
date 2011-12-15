//
//  FilterView.h
//  IyoApp
//
//  Created by yuriy on 12/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FilterView : UIViewController 
<UITableViewDataSource, UITableViewDelegate>
{
	UITableView *filterTblView;
	NSString *selectedSubCategoryId;
	NSMutableArray *dataSourceArray;
	id searchFilterArray;
}

@property (nonatomic, retain) IBOutlet UITableView *filterTblView;
@property (nonatomic, retain) NSString *selectedSubcategoryId;

-(void)buildDataSourceArray;
@end
