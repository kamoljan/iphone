//
//  AddPostDataSelectView.m
//  navBased
//
//  Created by yuriy on 7/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPostDataSelectView.h"


@implementation AddPostDataSelectView

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		pickerData = [[NSMutableArray alloc] init];		
		resultValue = [[NSString alloc] init];
		pickerView = [[UIPickerView alloc] init];		
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
	
}

- (void)dealloc {
	[pickerData release];
	[pickerView release];
	[resultValue release];
    [super dealloc];
}

#pragma mark -

-(void) setPickerData:(NSMutableArray *)dataArray
{
	pickerData = dataArray;
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
	return ([pickerData count] - 1);
}

- (NSString *)pickerView:(UIPickerView *)pickerView 
			 titleForRow:(NSInteger)row 
			forComponent:(NSInteger)component
{
	if ([pickerData count] > 0) {
		return [[pickerData objectAtIndex:(row +1)] objectForKey:@"name"];
	}
	else {
		return @"";
	}
}
@end
