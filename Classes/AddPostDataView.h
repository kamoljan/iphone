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
	NSString *loadingDataType;
}

@property (nonatomic, retain) NSString *resultValue;

-(void) setOptionsData:(NSMutableArray *)dataArray;
-(void) loadOptionsDataByurl:(NSString *)urlString;
-(IBAction) buttonClicked:(id)sender;
@end
