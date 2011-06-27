//
//  changeFilter.h
//  navBased
//
//  Created by yuriy on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "navBasedAppDelegate.h"

@interface changeFilter : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
	IBOutlet UITextField *queryText;
	IBOutlet UIPickerView *baseOptions;
	NSString *fJsonString;
	NSArray *jsonArray;
	NSMutableArray *arrayCategories;
	NSMutableArray *arrayRegions;
	navBasedAppDelegate *appDelegate;
	
}

@property(nonatomic,retain) IBOutlet UIPickerView *baseOptions;
@property(nonatomic,retain) IBOutlet UITextField *queryText;
@property(nonatomic,retain) NSString *fJsonString;
@property(nonatomic,retain) NSArray *jsonArray;
@property(nonatomic,retain) NSMutableArray *arrayRegions;
@property(nonatomic,retain) NSMutableArray *arrayCategories;
@property(nonatomic,retain) navBasedAppDelegate *appDelegate;

-(void)loadCategories;
-(void)loadRegions;
-(void)getArrayRegions:(NSArray *)regionsDictionary;
@end
