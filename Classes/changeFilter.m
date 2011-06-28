//
//  changeFilter.m
//  navBased
//
//  Created by yuriy on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "changeFilter.h"
#import "JSON.h"


@implementation changeFilter;

@synthesize  baseOptions, fJsonString, arrayRegions, jsonArray, appDelegate,
arrayCategories, queryText;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.appDelegate = (navBasedAppDelegate *)[[UIApplication sharedApplication] 
													   delegate];
        // Custom initialization.
		fJsonString = [[NSString alloc] init];	
		arrayRegions = [[NSMutableArray alloc] init];
		NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
		[tempDic setObject:@"0" forKey:@"id"];
		[tempDic setObject:@"Japan" forKey:@"name"];
		[arrayRegions addObject:[NSDictionary dictionaryWithDictionary:tempDic]];
		[tempDic removeAllObjects];
		
		arrayCategories = [[NSMutableArray	alloc] init];
		[tempDic setObject:@"0" forKey:@"catId"];
		[tempDic setObject:@"All Categories" forKey:@"catName"];
		[arrayCategories addObject:tempDic];
		jsonArray = [[NSMutableArray alloc] init];
		[tempDic release];
		self.title = @"Change Search Criteria";
		
		[self loadRegions];
		NSLog(@"%@",arrayRegions);
		[self loadCategories];
		
		[self.appDelegate.searchFilter setObject:@"" forKey:@"query"];
		[self.appDelegate.searchFilter setObject:@"0" forKey:@"category_id"];
		[self.appDelegate.searchFilter setObject:@"0" forKey:@"region_id"];
		
		
    }
    return self;
}

-(void) viewWillDisappear:(BOOL)animated
{
	self.appDelegate.needToRefresh = YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];	

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
	[baseOptions release];
	[jsonArray release];
	[arrayRegions release];
	[fJsonString release];
    [super dealloc];
}
#pragma mark -
#pragma mark Filter
-(void)loadRegions{
	NSString *urlString = [NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/regions"];
	NSURL *url = [NSURL  URLWithString:urlString];
	NSData *urlData = [NSData dataWithContentsOfURL:url];
	
	NSString *tempDataString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	
	NSMutableArray *tempRegionsArray;
	tempRegionsArray = [tempDataString JSONValue];
	NSMutableDictionary *tempRegion = [[NSMutableDictionary alloc] init];
	if ([self.arrayRegions count] == 1) {
			
		// Get regions and ad categories list
		for (int i = 0; i < [tempRegionsArray count]; i++) {
			[tempRegion setObject:[[tempRegionsArray objectAtIndex:i] objectForKey:@"name"] 
						   forKey:@"name"];
			[tempRegion setObject:[[tempRegionsArray objectAtIndex:i] objectForKey:@"id"]
						   forKey:@"id"];
		
			[arrayRegions addObject:[NSDictionary dictionaryWithDictionary:tempRegion]]; 
							   
			
		//	[arrayRegions insertObject:[NSDictionary dictionaryWithDictionary:tempRegion] 
		//					   atIndex:i];
			[tempRegion removeAllObjects];
		}	
		
	}
	
	[tempDataString release];
	
	// Reload the picker view
	[self.baseOptions reloadAllComponents];
}

-(void)loadCategories{
	NSString *urlString = [NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/category_tree"];
	NSURL *url = [NSURL  URLWithString:urlString];
	NSData *urlData = [NSData dataWithContentsOfURL:url];
	
	NSString *tempDataString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	
	NSMutableArray *tempCategories;
	tempCategories = [tempDataString JSONValue];	
	NSMutableArray *subCat;
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
	NSString *subCatName ;
	// Get regions and ad categories list
	for (int i = 0; i < [tempCategories count]; i++) {		
		[tempDict setObject:[[tempCategories objectAtIndex:i] objectForKey:@"name"] 
					 forKey:@"catName"];
		[tempDict setObject:[[tempCategories objectAtIndex:i] objectForKey:@"id"] 
					 forKey:@"catId"];
		[arrayCategories addObject: [NSDictionary dictionaryWithDictionary:tempDict]];		
		for (int j = 0; j < [[[tempCategories objectAtIndex:i] objectForKey:@"subcategories"] count]; j++) {
			subCat = [[tempCategories objectAtIndex:i] objectForKey:@"subcategories"];
			subCatName = [[subCat objectAtIndex:j] objectForKey:@"name"];
			
			[tempDict setObject:[[subCat objectAtIndex:j] objectForKey:@"name"] 
						 forKey:@"catName"];
			[tempDict setObject:[[subCat objectAtIndex:j] objectForKey:@"id"] 
						 forKey:@"catId"];
			[arrayCategories addObject: [NSDictionary dictionaryWithDictionary:tempDict]];
		}
		
	}
	
	// Reloa the picker view
//	[self.baseOptions reloadAllComponents];
	
	
	[tempDataString release];
}

-(void)getArrayRegions:(NSArray *)regionsDictionary
{

}

#pragma mark -
#pragma mark textField

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	[self.appDelegate.searchFilter setObject:textField.text forKey:@"query"];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark UIPickerView

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component
{
	if (component == 0) {
		if ([arrayRegions count] > 0) {
			return [arrayRegions count];
		}
		else {
			return 1;
		}
	}
	else {
		if ([arrayCategories count] > 0) {
			return [arrayCategories count];
		}
		else {
			return 1;
		}
	}

}

- (NSString *)pickerView:(UIPickerView *)pickerView 
			 titleForRow:(NSInteger)row 
			forComponent:(NSInteger)component
{
	if (component == 0) {
		if ([arrayRegions count] > 0) {
			return [[arrayRegions objectAtIndex:row] objectForKey:@"name"];
		}
		else {
			return @"Regions List is loading ...";
		}
	}
	else {
		if ([arrayCategories count] > 0) {
			return [[arrayCategories objectAtIndex:row] objectForKey:@"catName"];
		}
		else {
			return @"Category List is loading ...";
		}
	}

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row 
	   inComponent:(NSInteger)component {
	// Handle the selection
	if (component == 0) {
			[self.appDelegate.searchFilter setObject:[[arrayRegions objectAtIndex:row] 
													  objectForKey:@"id"]
											  forKey:@"region_id"];
	}
	else if (component == 1) {
		[self.appDelegate.searchFilter setObject:[[arrayCategories objectAtIndex:row ]
												  objectForKey:@"catId"]
		 										  forKey:@"category_id"];
	}
	
	NSLog(@"%@",self.appDelegate.searchFilter);
}

@end
