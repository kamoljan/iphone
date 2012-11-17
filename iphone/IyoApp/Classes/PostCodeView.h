//
//  PostCodeView.h
//  IyoApp
//
//  Created by yuriy on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IyoAppAppDelegate.h"
#import "SelectView.h"

@interface PostCodeView : UIViewController 
<UITextFieldDelegate>
{
	SelectView *regionSelectView;
	SelectView *citySelectView;
	IBOutlet UILabel *regionLabel;
	IBOutlet UILabel *cityLabel;
	IBOutlet UITextField *postCodeField;
	IyoAppAppDelegate *appDelegate;
	NSString *postCode;	
	int postItemNumber;
}

-(IBAction)showRegionView;
-(IBAction)showCityView;
-(void) setPostFieldNumber:(int)number;
-(IBAction)didOK;
@end
