//
//  AddPostDataSelectView.m
//  navBased
//
//  Created by yuriy on 7/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPostDataSelectView.h"


@implementation AddPostDataSelectView

@synthesize resultValue, selectedItem;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		pickerData = [[NSMutableArray alloc] init];		
		self.resultValue = [[NSString alloc] init];
		pickerView = [[UIPickerView alloc] init];
		self.selectedItem = [[NSMutableDictionary alloc] init];
		startValue = 0;
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

- (void)viewWillAppear:(BOOL)animated
{
	[pickerView selectRow:0 inComponent:0 animated:NO];
	self.resultValue = [[pickerData objectAtIndex:startValue] objectForKey:@"value"];	
	
}

- (void)dealloc {
	[pickerData autorelease];
	[pickerView release];
    [super dealloc];
}

#pragma mark -

-(void) setPickerData:(NSMutableArray *)dataArray startFrom:(NSInteger)start
{
	startValue = start;
	pickerData = [dataArray mutableCopy];
	self.selectedItem = [pickerData objectAtIndex:startValue];
	[pickerView reloadAllComponents];
}

#pragma mark -
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component
{
	return ([pickerData count] - startValue);
}

- (NSString *)pickerView:(UIPickerView *)pickerView 
			 titleForRow:(NSInteger)row 
			forComponent:(NSInteger)component
{
	if ([pickerData count] > 0) {
		return [[pickerData objectAtIndex:(row +startValue)] objectForKey:@"name"];
	}
	else {
		return @"";
	}
}
- (void)pickerView:(UIPickerView *)pickerView 
	  didSelectRow:(NSInteger)row 
	   inComponent:(NSInteger)component
{
	self.resultValue = [[pickerData objectAtIndex:(row + startValue)] objectForKey:@"value"];
	self.selectedItem = [pickerData objectAtIndex:(row +startValue)];	
}
@end
