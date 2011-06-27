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


@interface AdPostingForm : UIViewController 
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
{
	NSMutableDictionary *fields;
	AdvertiserType *advertiserTypeForm;
	AdType *adType;
	Subcategory *subcategory;
}

@property (nonatomic, retain) NSDictionary *fields;
@property (nonatomic, retain) AdvertiserType *advertiserTypeForm;
@property (nonatomic, retain) AdType *adType;
@property (nonatomic, retain) Subcategory *subcategory;

-(void)addTextField:(UITableViewCell *)cell 
			  title:(NSString *)title 
	  withTextField:(Boolean)withTextField 
	 fieldType:(NSString *)fieldType
				tag:(NSUInteger)tag;

-(void)addTextView:(UITableViewCell *)cell 
			  title:(NSString *)title 
	  			tag:(NSUInteger)tag;
@end
