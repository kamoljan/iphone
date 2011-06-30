//
//  ExtraForms.h
//  navBased
//
//  Created by yuriy on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExtraForms : UIViewController 
<UITableViewDelegate, UITableViewDataSource>
{
	NSMutableArray *extraFormsArray;
	NSString *catId;
	IBOutlet UITableView *extraTableView;
}

@property (nonatomic, retain) NSMutableArray *extraFormsArray;
@property (nonatomic, retain) NSString *catId;
@property (nonatomic, retain) IBOutlet UITableView *extraTableView;

-(void)setCurrentCatId:(NSString *)curCatId;
-(void)initExtraForms;
@end
