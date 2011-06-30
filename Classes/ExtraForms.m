//
//  ExtraForms.m
//  navBased
//
//  Created by yuriy on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExtraForms.h"
#import "JSON.h"


@implementation ExtraForms

@synthesize extraFormsArray, catId, extraTableView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.		
		self.catId = [NSString stringWithFormat:@"0"];
		self.extraFormsArray = [[NSMutableArray alloc] init];	
		self.extraTableView = [[UITableView alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[self initExtraForms];
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


- (void)dealloc {
	[self.extraFormsArray release];
	[self.extraTableView release];
    [super dealloc];
}

#pragma mark -
-(void)setCurrentCatId:(NSString *)curCatId
{
	catId = curCatId;
	
}

-(void)initExtraForms
{
	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/extra_forms/%@",catId]];
	NSData *extraData = [NSData dataWithContentsOfURL:url];
	NSString *tempExtraDataString = [[NSString alloc] initWithData:extraData 
													 encoding:NSUTF8StringEncoding];
	self.extraFormsArray =[tempExtraDataString JSONValue];

	[tempExtraDataString release];
	[url release];
	[extraTableView reloadData];
	
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@" rows count in tableView %i",[extraFormsArray count]);
	return [extraFormsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	NSString *extraCellIdentifier = @"extraCell";
//  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:extraCellIdentifier];
	
//	if (cell == nil) {
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:extraCellIdentifier] autorelease];
//	}	
	cell.textLabel.text = [[extraFormsArray objectAtIndex:indexPath.row] objectForKey:@"label"];
	
	cell.detailTextLabel.text = [[extraFormsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
		
	return cell	;
	
}
@end
