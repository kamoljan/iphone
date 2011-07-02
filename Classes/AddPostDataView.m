//
//  AddPostDataView.m
//  navBased
//
//  Created by yuriy on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPostDataView.h"


@implementation AddPostDataView

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		optionsData =[[NSMutableArray alloc] init];
		resultValue = [[NSString alloc] init];
		buttonsArray = [[NSMutableArray alloc] init];
		//sampleButton = [[UIButton alloc] init];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
    [super viewDidLoad];		
}

- (void)viewWillAppear:(BOOL)animated
{
	
	for (int i = 0; i < [buttonsArray count]; i++) {
		[[buttonsArray objectAtIndex:i]  removeFromSuperview];
	}
	[buttonsArray removeAllObjects];
	UIButton *myButton;
	for (int i = 0; i < [optionsData count]; i++) {
		myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		myButton.frame = CGRectMake(50, (50 + (i * 60) ), 200, 44); // position in the parent view and set the size of the button
		[myButton setTitle:[[optionsData objectAtIndex:i] objectForKey:@"name"]
				  forState:UIControlStateNormal];
		myButton.tag = (i + 1);
		// add targets and actions
		[myButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view	
		[buttonsArray addObject:myButton];
		[self.view addSubview:[buttonsArray objectAtIndex:i]];	
		
	}	
}

-(IBAction) buttonClicked:(id)sender
{
	resultValue = [[optionsData objectAtIndex:([sender tag] - 1)] objectForKey:@"value"];
	[[self navigationController] popViewControllerAnimated:YES];
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
	[optionsData release];	
    [super dealloc];
}

-(void) setOptionsData:(NSMutableArray *)dataArray
{
	optionsData = dataArray;	
}

@end
