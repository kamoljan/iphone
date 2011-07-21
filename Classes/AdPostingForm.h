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
#import "LocationForm.h"


@interface AdPostingForm : UIViewController 
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
{
	NSMutableArray *fieldsArray, *postArray;
	NSString *activeCatId;
	NSMutableArray *pickerViewValues;
	IBOutlet UITableView *adTableView;
	NSInteger moveHeight;
	navBasedAppDelegate *appDelegate;
	AdvertiserType *advertiserTypeForm;
	Subcategory *subcategory;
	AddPostDataView *addPostDataView;
	AddPostDataSelectView *addPostDataSelectView;
	ExtraForms *extraParametres;
	ImagePostingView *imagePostingView;
	LocationForm *locationForm;
	
	//adType saves the ad type view result data
	NSString *adTypeValue;
	//used for dynamic upload extra fields
	//the new value will be located at addPostDataVew.resultValue 
	Boolean shouldChangePostItem;	
	NSInteger changingIndexAtPostArray;
	//used for check which view to use to get new post value
	//for example radio uses AddPostDataVIew class,
	//select uses AddPostDataSelectView
	
	NSString *changingValueType;
	NSString *changingValueKey;
	CGRect activeRect;
}


-(void) addLabel:(NSString *)labelTitle toCell:(UITableViewCell *)cell;
-(void) addTextViewToCell:(UITableViewCell *)cell withTag:(NSInteger)tag;

-(void) addTextFieldToCell:(UITableViewCell *)cell 
		  withKeyboardType:(NSString *)keyboardType 
				   withTag:(NSInteger)tag;
-(void) prepareFieldsArray;

-(void) shouldChangePostData:(Boolean)change 
			  atIndexPostion:(NSInteger)indexAtPostArray 
					 forType:(NSString *)type
					  forKey:(NSString *)key;

-(void) didUploadPostArray;

-(void) addPostString:(NSString *)postString forKey:(NSString *)postKey;
-(void) addPostArray:(NSArray *)postItemArray;

-(Boolean)checkString:(NSString *)string forType:(NSString *)type;
@end
