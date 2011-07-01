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
		pickerData =[[NSArray alloc] init];
		resultValue = [[NSString alloc] init];
		//sampleButton = [[UIButton alloc] init];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
    [super viewDidLoad];

	NSMutableArray *buttonsArray = [[NSMutableArray alloc] init];
	UIButton *myButton;
	for (int i = 0; i < [pickerData count]; i++) {
		myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		myButton.frame = CGRectMake(50, (100 + (i * 60) ), 200, 44); // position in the parent view and set the size of the button
		[myButton setTitle:[[pickerData objectAtIndex:i] objectForKey:@"name"]
				  forState:UIControlStateNormal];
		myButton.tag = (NSInteger)[[[pickerData objectAtIndex:i] objectForKey:@"value"] intValue];
		// add targets and actions
		[myButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view	
		[buttonsArray addObject:myButton];
		[self.view addSubview:[buttonsArray objectAtIndex:i]];	
		
	}
	
}

-(IBAction) buttonClicked:(id)sender
{
	NSLog(@"%i",[sender tag]);
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
	[pickerData release];
    [super dealloc];
}

-(void) setPickerData:(NSArray *)dataArray
{	
	pickerData = [[dataArray copy] autorelease];	
}

@end
