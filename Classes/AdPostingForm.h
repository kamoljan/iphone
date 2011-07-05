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
#import "AddPostDataSelectView.h"
#import	"ImagePostingView.h"
#import "navBasedAppDelegate.h"


@interface AdPostingForm : UIViewController 
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
{
	NSMutableArray *fieldsArray;
	NSString *activeCatId;
	NSMutableArray *pickerViewValues;
	IBOutlet UITableView *tableView;
	navBasedAppDelegate *appDelegate;
	AdvertiserType *advertiserTypeForm;
	Subcategory *subcategory;
	AddPostDataView *addPostDataView;
	AddPostDataSelectView *addPostDataSelectView;
	ExtraForms *extraParametres;
	ImagePostingView *imagePostingView;
	
	//used for dynamic upload extra fields
	//the new value will be located at addPostDataVew.resultValue 
	Boolean shouldChangePostItem;	
	NSInteger changingIndexAtPostArray;
	//used for check which view to use to get new post value
	//for example radio uses AddPostDataVIew class,
	//select uses AddPostDataSelectView
	
	NSString *changingValueType;
	NSString *changingValueKey;
}

//@property (nonatomic, retain) AdvertiserType *advertiserTypeForm;
//@property (nonatomic, retain) Subcategory *subcategory;
//@property (nonatomic, retain) ExtraForms *extraParametres;
//@property (nonatomic, retain) IBOutlet UITableView *tableView;
//@property (nonatomic, retain) NSMutableArray *fieldsArray;
//@property (nonatomic, retain) NSMutableArray *pickerViewValues;
//@property (nonatomic, assign) Boolean shouldChangePostItem;
//@property (nonatomic, assign) NSInteger changingIndexAtPostArray;

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

-(void) shouldChangePostData:(Boolean)change 
			  atIndexPostion:(NSInteger)indexAtPostArray 
					 forType:(NSString *)type
					  forKey:(NSString *)key;

-(void) didUploadPostArray;

@end
