//
//  AddPostDataSelectView.h
//  navBased
//
//  Created by yuriy on 7/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddPostDataSelectView : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
	NSMutableArray *pickerData;
	NSMutableDictionary *selectedItem;
	NSString *resultValue;
	IBOutlet UIPickerView *pickerView;
	NSInteger startValue;
}

@property (nonatomic, retain) NSString *resultValue;
@property (nonatomic, retain) NSMutableDictionary *selectedItem;

-(void) setPickerData:(NSMutableArray *)dataArray startFrom:(NSInteger)start;

@end
