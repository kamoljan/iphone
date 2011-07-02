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
	NSMutableArray *optionsData;
	NSString *resultValue;
	NSMutableArray *buttonsArray; 
}

-(void) setOptionsData:(NSMutableArray *)dataArray;
-(IBAction) buttonClicked:(id)sender;
@end
