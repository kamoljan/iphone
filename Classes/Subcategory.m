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

@synthesize subcategories, currentCatId, extraFormsArray, adTypesArray,
resultValue;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		resultValue = [[NSString alloc] initWithString:@"-1"];
		subPickerView = [[UIPickerView alloc] init];
		subcategories = [[NSMutableArray alloc] init];	
		currentCatId = [[NSString alloc] initWithFormat:@"-1"];
		extraFormsArray = [[NSMutableArray alloc] init];
		adTypesArray = [[NSMutableArray alloc] init];
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
	[subPickerView release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {	
	[super dealloc];
}

#pragma mark -
#pragma mark load data
//get JSON Data and reload picker view
-(void) loadDataWithURLArray:(NSURL *)url
{
	[self.subcategories removeAllObjects];
	NSData *subData = [NSData dataWithContentsOfURL:url];
	NSString *tempDataString = [[NSString alloc] initWithData:subData 
													 encoding:NSUTF8StringEncoding];
	NSArray *tempCategories = [tempDataString JSONValue];	
	NSMutableArray *subCat;
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
	// Get regions and ad categories list
	for (int i = 0; i < [tempCategories count]; i++) {
		
		[tempDict setObject:[[tempCategories objectAtIndex:i] objectForKey:@"name"] 
					 forKey:@"catName"];
		[tempDict setObject:[[tempCategories objectAtIndex:i] objectForKey:@"id"] 
					 forKey:@"catId"];
		[self.subcategories addObject: [NSDictionary dictionaryWithDictionary:tempDict]];
		
		for (int j = 0; j < [[[tempCategories objectAtIndex:i] objectForKey:@"subcategories"] count]; j++) {
			subCat = [[tempCategories objectAtIndex:i] objectForKey:@"subcategories"];
			//[subcategories addObject:subCatName];
			[tempDict setObject:[[subCat objectAtIndex:j] objectForKey:@"name"] 
						 forKey:@"catName"];
			[tempDict setObject:[[subCat objectAtIndex:j] objectForKey:@"id"] 
						 forKey:@"catId"];
			[self.subcategories addObject: [NSDictionary dictionaryWithDictionary:tempDict]];
		}
	}
	
	[subPickerView reloadAllComponents];
	[tempDict release];
	[tempDataString release];
}


-(void) loadExtraFields
{
	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/extra_forms/%@",currentCatId]];
	NSData *extraData = [NSData dataWithContentsOfURL:url];
	NSString *tempExtraDataString = [[NSString alloc] initWithData:extraData 
														  encoding:NSUTF8StringEncoding];
	self.extraFormsArray =[tempExtraDataString JSONValue] ;
	
	[tempExtraDataString release];
	[url release];
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
	if ([self.subcategories count] == 0) {
		return 1;
	}
	return [self.subcategories count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView 
			 titleForRow:(NSInteger)row 
			forComponent:(NSInteger)component
{
	if ([self.subcategories count] == 0) {
		return @"Please choose the subcategory";
	}
	else {
		return [[self.subcategories objectAtIndex:row] objectForKey:@"catName"];
	}

}

- (void)pickerView:(UIPickerView *)pickerView 
	  didSelectRow:(NSInteger)row 
	   inComponent:(NSInteger)component
{
	self.currentCatId = [[self.subcategories objectAtIndex:row] objectForKey:@"catId"];
	[self loadExtraFields];	
	self.resultValue = currentCatId;
}

@end
