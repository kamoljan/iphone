//
//  inputText.h
//  IyoApp
//
//  Created by yuriy on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IyoAppAppDelegate.h"


@interface inputText : UIViewController
<UITextFieldDelegate>
{
	IyoAppAppDelegate *appDelegate;
	UITextField *textItem;
	UILabel *titleText;
	int postItemNumber;
}

@property (nonatomic, retain) IBOutlet UITextField *textItem;
@property (nonatomic, retain) IBOutlet UILabel *titleText;

-(void) setPostFieldNumber:(int)number;
-(IBAction)didOK;
@end
