//
//  AdPostingForm.h
//  navBased
//
//  Created by yuriy on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertiserType.h"
#import "AdType.h"
#import "Subcategory.h"
#import "ExtraForms.h"
#import "navBasedAppDelegate.h"


@interface AdPostingForm : UIViewController 
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
{
	NSMutableArray *fieldsArray;
	NSMutableArray *extraFormsArray;
	navBasedAppDelegate *appDelegate;
	AdvertiserType *advertiserTypeForm;
	AdType *adType;
	Subcategory *subcategory;
	ExtraForms *extraParametres;
	
}

@property (nonatomic, retain) AdvertiserType *advertiserTypeForm;
@property (nonatomic, retain) AdType *adType;
@property (nonatomic, retain) Subcategory *subcategory;
@property (nonatomic, retain) ExtraForms *extraParametres;

-(void) addLabel:(NSString *)labelTitle toCell:(UITableViewCell *)cell;
-(void) addTextViewToCell:(UITableViewCell *)cell;
-(void) addTextFieldToCell:(UITableViewCell *)cell withKeyboardType:(NSString *)keyboardType;
-(void) prepareFieldsArray;
-(void) loadExtraFields;

-(void)addTextField:(UITableViewCell *)cell 
			  title:(NSString *)title 
	  withTextField:(Boolean)withTextField 
	 fieldType:(NSString *)fieldType
				tag:(NSUInteger)tag;

@end
