//
//  Subcategory.h
//  navBased
//
//  Created by yuriy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Subcategory : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
	IBOutlet UIPickerView *subPickerView;
	NSMutableArray *subcategories;
	NSString *currentCatId;
	NSMutableArray *extraFormsArray;
}

-(void) loadDataWithURLArray:(NSURL *)url;

@property (nonatomic, retain) NSMutableArray *subcategories;
@property (nonatomic, retain) NSString *currentCatId;
@property (nonatomic, retain) IBOutlet UIPickerView *subPickerView;
@property (nonatomic, retain) NSMutableArray *extraFormsArray;

-(void) loadExtraFields;
@end
