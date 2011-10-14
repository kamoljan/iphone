//
//  SelectView.m
//  IyoApp
//
//  Created by yuriy on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectView.h"


@implementation SelectView
@synthesize viewLabel, picker, selectedValue, selectedValueId;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		appDelegate = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		postItemNumber = 0;
		selectedValue = @"";
		//postKey = [[NSString alloc] init];
		//codeKey = [[NSString alloc] init];
		//valueKey = [[NSString alloc] init];
    }
    return self;
}

-(void) setPostFieldNumber:(int)number{
	postItemNumber = number;
	postKey = [[appDelegate.iyoAdPosting.postFields objectAtIndex:postItemNumber] objectForKey:@"name"];
}
//use setPostFieldNumber: or setPosKey
-(void)setPosKey:(NSString *)postKeyName
{
	postKey = postKeyName;
}
-(void) setSourceData:(id)data 
		  withCodeKey:(NSString *)code 
		 withValueKey:(NSString *)value{	
	/*
	 [
		{
			"valueKey": "99"
			"codeKey": "blablabla"
		},
		...
	 ]
	 */
	sourceData = data;
	codeKey = [code retain];
	valueKey = [value retain];
}
-(IBAction) didOK{
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;	
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [sourceData count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {	
	return [[sourceData objectAtIndex:row] objectForKey:codeKey];	
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSString *labelValue = [NSString stringWithFormat:@"%@", [[sourceData objectAtIndex:row] objectForKey:codeKey]];
	NSString *value = [NSString stringWithFormat:@"%@",[[sourceData objectAtIndex:row] objectForKey:valueKey]];
	self.selectedValue = labelValue;
	self.selectedValueId = value;
	[appDelegate.iyoAdPosting insertValue:value
							   labelValue:labelValue
					   forPostItemWithKey:postKey];			 
}

#pragma mark -

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
	[selectedValue release];
	[selectedValueId release];
    [super dealloc];
}


@end
