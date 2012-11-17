//
//  AdvertiserType.m
//  IyoApp
//
//  Created by yuriy on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdvertiserType.h"


@implementation AdvertiserType
@synthesize viewLabel;

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

-(IBAction) choosedPersonal
{
	[appDelegate.iyoAdPosting insertValue:@"1" 
							   labelValue:@"Personal" 
					   forPostItemWithKey:@"advertiser_type"];	
	[[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction) choosedCompany
{
	[appDelegate.iyoAdPosting insertValue:@"2" 
							   labelValue:@"Company" 
					   forPostItemWithKey:@"advertiser_type"];	
	[[self navigationController] popViewControllerAnimated:YES];
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
