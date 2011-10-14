//
//  inputTextView.m
//  IyoApp
//
//  Created by yuriy on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "inputTextView.h"


@implementation inputTextView

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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
		
		[appDelegate.iyoAdPosting insertValue:textView.text
								   labelValue:@"Body text"
						   forPostItemWithKey:@"body"];		
        // Return FALSE so that the final '\n' character doesn't get added				
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

- (IBAction) didOK
{		
	[[self navigationController] popViewControllerAnimated:YES];	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[titleText setText:[[appDelegate.iyoAdPosting.postFields objectAtIndex:postItemNumber] objectForKey:@"title"]];
	NSString *key = [[appDelegate.iyoAdPosting.postFields objectAtIndex:postItemNumber] objectForKey:@"name"];
	textViewItem.text = [appDelegate.iyoAdPosting postValueWithKey:key];
	[textViewItem becomeFirstResponder];
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
	[textViewItem release];
	[titleText release];
    [super dealloc];
}


@end
