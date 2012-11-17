//
//  inputText.m
//  IyoApp
//
//  Created by yuriy on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "inputText.h"


@implementation inputText

@synthesize textItem, titleText;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		appDelegate = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		postItemNumber = 0;
		
    }
    return self;
}

-(void) setPostFieldNumber:(int)number
{
	postItemNumber = number;
}

- (IBAction) didOK
{		
	[[self navigationController] popViewControllerAnimated:YES];	
}

#pragma mark -

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{		
	NSString *postKey = [[appDelegate.iyoAdPosting.postFields objectAtIndex:postItemNumber] objectForKey:@"name"];
	[appDelegate.iyoAdPosting insertValue:textField.text
							   labelValue:textField.text
					   forPostItemWithKey:postKey];	
	[textField resignFirstResponder];
	[self didOK];			
	return YES;
}

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[titleText setText:[[appDelegate.iyoAdPosting.postFields objectAtIndex:postItemNumber] objectForKey:@"title"]];
	NSString *key = [[appDelegate.iyoAdPosting.postFields objectAtIndex:postItemNumber] objectForKey:@"name"];
	textItem.text = [appDelegate.iyoAdPosting postValueWithKey:key];
	[textItem becomeFirstResponder];
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
	[textItem release];
	[titleText release];
    [super dealloc];
}


@end
