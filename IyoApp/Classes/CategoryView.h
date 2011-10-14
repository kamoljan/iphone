//
//  CategoryView.h
//  IyoApp
//
//  Created by yuriy on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IyoAppAppDelegate.h"

@interface CategoryView : UIViewController 
<UIPickerViewDelegate, UIPickerViewDataSource>
{
	IyoAppAppDelegate *appDelegate;
	NSMutableArray *categories;
	int postItemNumber;
	UILabel *viewLabel;
	UIPickerView *picker;
	
}
@property (nonatomic, retain) IBOutlet UILabel *viewLabel;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
-(void) setPostFieldNumber:(int)number;
-(IBAction) didOK;
@end
