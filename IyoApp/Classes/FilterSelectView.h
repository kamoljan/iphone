//
//  FilterSelectView.h
//  IyoApp
//
//  Created by yuriy on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FilterSelectView : UIViewController 
<UIPickerViewDelegate, UIPickerViewDataSource>
{
	NSArray *pickerViewDataSource;
	NSString *returnValue;
	NSString *returnValueLabel;
	NSString *dataSourceKeyString;
	NSString *dataSourceValueString;
}

@property(nonatomic,retain) NSArray *pickerViewDataSource;
@property(nonatomic,retain) NSString *returnValue;
@property(nonatomic,retain) NSString *returnValueLabel;
@property(nonatomic,retain) NSString *dataSourceKeyString;
@property(nonatomic,retain) NSString *dataSourceValueString;
@end
