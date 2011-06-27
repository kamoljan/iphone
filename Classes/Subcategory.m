//
//  Subcategory.m
//  navBased
//
//  Created by yuriy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Subcategory.h"
#import "JSON.h"


@implementation Subcategory

@synthesize subcategories, subPickerView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		subPickerView = [[UIPickerView alloc] init];
		subcategories = [[NSMutableArray alloc] init];
		titles = [[NSMutableArray alloc] init];
		NSURL *iyoURL = [NSURL URLWithString:@"http://www.iyoiyo.jp/ajax/category_tree"];
		[self getJSONArray:iyoURL];
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	[subPickerView release];
	[subcategories release];
	[titles release];
    [super dealloc];
}

#pragma mark -
#pragma mark get request data
-(void) getJSONArray:(NSURL *)url
{
	NSData *subData = [NSData dataWithContentsOfURL:url];
	NSString *tempDataString = [[NSString alloc] initWithData:subData 
													 encoding:NSUTF8StringEncoding];
	NSArray *tempCategories = [tempDataString JSONValue];	
	NSMutableArray *subCat;
	NSString *subCatName ;
	// Get regions and ad categories list
	for (int i = 0; i < [tempCategories count]; i++) {
		[subcategories addObject:[[tempCategories objectAtIndex:i] objectForKey:@"name"]];
		for (int j = 0; j < [[[tempCategories objectAtIndex:i] objectForKey:@"subcategories"]count]; j++) {
			subCat = [[tempCategories objectAtIndex:i] objectForKey:@"subcategories"];
			subCatName = [[subCat objectAtIndex:j] objectForKey:@"name"];
			
			[subcategories addObject:subCatName];
		}
	}
	[self.subPickerView reloadAllComponents];
	NSLog(@"%@", subcategories);

}

#pragma mark -
#pragma mark PickerView

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component
{
	if ([subcategories count] == 0) {
		return 1;
	}
	return [subcategories count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView 
			 titleForRow:(NSInteger)row 
			forComponent:(NSInteger)component
{
	if ([subcategories count] == 0) {
		return @"Please choose the subcategory";
	}
	else {
		return [subcategories objectAtIndex:row];
	}

}

@end
