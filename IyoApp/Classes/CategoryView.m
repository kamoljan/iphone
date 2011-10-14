//
//  CategoryView.m
//  IyoApp
//
//  Created by yuriy on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryView.h"


@implementation CategoryView
@synthesize viewLabel, picker;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		appDelegate = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		categories = appDelegate.iyoAdPosting.SICategories;
		postItemNumber = 0;
    }
    return self;
}

-(void) setPostFieldNumber:(int)number
{
	postItemNumber = number;
}
-(void)didOK{
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;	
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [appDelegate.iyoAdPosting.SICategories count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[appDelegate.iyoAdPosting.SICategories objectAtIndex:row] objectForKey:@"catName"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {	
	//unselectable main category
	if ([[[categories objectAtIndex:row] objectForKey:@"catType"] isEqualToString:@"main"]) {		
		[pickerView selectRow:(row +1)
				  inComponent:0 
					 animated:YES];
		return;
	}
	
	NSString *catName = [[categories objectAtIndex:row] objectForKey:@"catName"];
	catName = [NSString stringWithString:catName];	
	id catId = [[categories objectAtIndex:row] objectForKey:@"catId"];	
	[appDelegate.iyoAdPosting setDynamicFieldsForCategoryWithId:catId];
	[appDelegate.iyoAdPosting insertValue:catId 
							   labelValue:catName 
					   forPostItemWithKey:@"subcategory_id"];
	 
}

#pragma mark -
-(void) viewWillAppear:(BOOL)animated{	
	id subCatId = [appDelegate.iyoAdPosting postValueWithKey:@"subcategory_id"];
	NSString *tempCatId;
	//find current category located row, then select it.
	for (int i=0; i < [appDelegate.iyoAdPosting.SICategories count]; i++) {		
		tempCatId = [[[appDelegate.iyoAdPosting.SICategories objectAtIndex:i] objectForKey:@"catId"] stringValue];
		if ([subCatId isEqualToString:tempCatId]) {
			[picker selectRow:i inComponent:0 animated:NO];
			break;
		}
	}	
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	viewLabel.text = [[appDelegate.iyoAdPosting.postFields objectAtIndex:postItemNumber] objectForKey:@"title"];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {	
    [super dealloc];
}


@end
