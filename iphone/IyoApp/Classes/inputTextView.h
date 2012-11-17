//
//  inputTextView.h
//  IyoApp
//
//  Created by yuriy on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IyoAppAppDelegate.h"

@interface inputTextView : UIViewController 
<UITextViewDelegate>
{
	IyoAppAppDelegate *appDelegate;
	IBOutlet UITextView *textViewItem;
	IBOutlet UILabel *titleText;
	int postItemNumber;
}
-(void) setPostFieldNumber:(int)number;
-(IBAction)didOK;
@end
