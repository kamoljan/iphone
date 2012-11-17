//
//  IyoIyoAppViewController.m
//  IyoIyoApp
//
//  Created by yuriy on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IyoIyoAppViewController.h"

@implementation IyoIyoAppViewController


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		appDelegate = (IyoIyoAppAppDelegate *)[[UIApplication sharedApplication] 
											  delegate];
		adPostingView = [[AdPostingView alloc] init];
		
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController pushViewController:adPostingView animated:YES];
	/*
	AdPosting *adPost = [[AdPosting alloc] init];

	
	 NSLog(@"Insert value \"Bugatti Veyron Super Sport\" for key \"Title\" ");
	
	if ([adPost insertValue:@"Bugatti Veyron Super Sport" forPostItemWithKey:@"title"]) {
		NSLog(@"Value inserted successfully, Lets check it");
		NSLog(@"%@",[adPost getPostItemWithKey:@"title" forKey:@"post_value"]);
	}
	else {
		NSLog(@"post value doesnt inserted");
	}
	
	[adPost setDynamicFieldsForCategoryWithId:9];
	[adPost chooseAdTypeById:@"99"];
	[adPost chooseMapItemsByPostCode:@"7900864"];	
	[adPost reloadFields];	
	
	[adPost insertValue:@"1" forPostItemWithKey:@"advertiser_type"];
	[adPost insertValue:@"testValue" forPostItemWithKey:@"advertiser_name"];
	[adPost insertValue:@"testValue@test.com" forPostItemWithKey:@"email"];
	[adPost insertValue:@"0118761510" forPostItemWithKey:@"phone"];
	[adPost insertValue:@"19" forPostItemWithKey:@"subcategory_id"];
	[adPost insertValue:@"2" forPostItemWithKey:@"ad_type"];
	[adPost insertValue:@"3710803" forPostItemWithKey:@"post_code"];
	[adPost insertValue:@"10" forPostItemWithKey:@"region_id"];
	[adPost insertValue:@"214" forPostItemWithKey:@"city_id"];
	[adPost insertValue:@"testValue" forPostItemWithKey:@"title"];
	[adPost insertValue:@"testValue" forPostItemWithKey:@"body"];
	
	
	//[adPost sendNewAdForPosting];
	
	[adPost release];
	 */
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[adPostingView release];
    [super dealloc];
}

@end
