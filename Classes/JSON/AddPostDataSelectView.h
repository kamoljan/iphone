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
	NSString *resultValue;
	IBOutlet UIPickerView *pickerView;
}

@property (nonatomic, retain) NSString *resultValue;

-(void) setPickerData:(NSMutableArray *)dataArray;
@end
