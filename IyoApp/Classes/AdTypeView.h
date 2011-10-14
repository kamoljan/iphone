//
//  AdTypeView.h
//  IyoApp
//
//  Created by yuriy on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IyoAppAppDelegate.h"
@interface AdTypeView : UIViewController {
	IyoAppAppDelegate *appDelegate;
	int postItemNumber;
	IBOutlet UILabel *viewLabel;
	IBOutlet UIPickerView *picker;
	//sourceData is an array
	id sourceData;
	NSString *postKey;
	NSString *codeKey;
	NSString *valueKey;
}
-(void) setPostFieldNumber:(int)number;
-(void) setSourceData:(id)data
		  withCodeKey:(NSString *)code 
		 withValueKey:(NSString *)value;
-(IBAction) didOK;

@end
