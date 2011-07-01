//
//  AdPostingForm.h
//  navBased
//
//  Created by yuriy on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertiserType.h"
#import "Subcategory.h"
#import "ExtraForms.h"
#import "AddPostDataView.h"
#import "navBasedAppDelegate.h"


@interface AdPostingForm : UIViewController 
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
{
	NSMutableArray *fieldsArray;
	Boolean shouldChangePostItem;
	NSInteger changingIndexAtPostArray;
	NSMutableArray *pickerViewValues;
	IBOutlet UITableView *tableView;
	navBasedAppDelegate *appDelegate;
	AdvertiserType *advertiserTypeForm;
	Subcategory *subcategory;
	AddPostDataView *addPostDataView;
	ExtraForms *extraParametres;
	
}

@property (nonatomic, retain) AdvertiserType *advertiserTypeForm;
@property (nonatomic, retain) Subcategory *subcategory;
@property (nonatomic, retain) ExtraForms *extraParametres;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *fieldsArray;
@property (nonatomic, retain) NSMutableArray *pickerViewValues;
@property (nonatomic, assign) Boolean shouldChangePostItem;
@property (nonatomic, assign) NSInteger changingIndexAtPostArray;

-(void) addLabel:(NSString *)labelTitle toCell:(UITableViewCell *)cell;
-(void) addTextViewToCell:(UITableViewCell *)cell;
-(void) addTextFieldToCell:(UITableViewCell *)cell 
		  withKeyboardType:(NSString *)keyboardType 
				   withTag:(NSInteger)tag;
-(void) prepareFieldsArray;

-(void)addTextField:(UITableViewCell *)cell 
			  title:(NSString *)title 
	  withTextField:(Boolean)withTextField 
	 fieldType:(NSString *)fieldType
				tag:(NSUInteger)tag;

@end
