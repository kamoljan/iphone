//
//  SelectView.h
//  IyoApp
//
//  Created by yuriy on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IyoAppAppDelegate.h"

@interface SelectView : UIViewController {
	IyoAppAppDelegate *appDelegate;
	int postItemNumber;
	UILabel *viewLabel;
	UIPickerView *picker;
	NSString *selectedValue;
	NSString *selectedValueId;
	//sourceData is an array
	id sourceData;
	NSString *postKey;
	NSString *codeKey;
	NSString *valueKey;
}

@property (nonatomic, retain) IBOutlet UILabel *viewLabel;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) NSString *selectedValue;
@property (nonatomic, retain) NSString *selectedValueId;

-(void) setPostFieldNumber:(int)number;
-(void)setPosKey:(NSString *)postKeyName;
-(void) setSourceData:(id)data
		  withCodeKey:(NSString *)code 
		 withValueKey:(NSString *)value;
-(IBAction) didOK;
@end
