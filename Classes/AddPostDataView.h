//
//  AddPostDataView.h
//  navBased
//
//  Created by yuriy on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddPostDataView : UIViewController 
{
	NSArray *pickerData;
	NSString *resultValue;

}

-(void) setPickerData:(NSArray *)dataArray;
-(IBAction) buttonClicked:(id)sender;
@end
