//
//  AdTypeView.m
//  IyoApp
//
//  Created by yuriy on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdTypeView.h"


@implementation AdTypeView


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		appDelegate = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		postItemNumber = 0;
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
-(void) setSourceData:(id)data 
		  withCodeKey:(NSString *)code 
		 withValueKey:(NSString *)value{	
	sourceData = data;	
	codeKey = [code copy];
	valueKey = [value copy];
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
	if ([sourceData count] > 0) {
		id value = [[sourceData objectAtIndex:row] objectForKey:valueKey];
		NSString *labelValue = [[sourceData objectAtIndex:row] objectForKey:codeKey];		
		[appDelegate.iyoAdPosting insertValue:value
								   labelValue:labelValue
						   forPostItemWithKey:postKey];
		[appDelegate.iyoAdPosting chooseAdTypeById:[NSString stringWithString:[value stringValue]]]; 
	 	[appDelegate.iyoAdPosting reloadFields];	 
	}	 
}

#pragma mark -
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
	//[sourceData release];	
	[codeKey release];
	[valueKey release];
    [super dealloc];
}


@end
