//
//  FilterView.m
//  IyoApp
//
//  Created by yuriy on 12/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterView.h"
#import "IyoAppAppDelegate.h"
#import "TextView.h"
#import "FilterSelectView.h"

@implementation FilterView
@synthesize filterTblView, selectedSubcategoryId;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		dataSourceArray = [[NSMutableArray alloc] init];
		IyoAppAppDelegate *appDelegate = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		searchFilterArray = appDelegate.searchFilter;
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*
- (void)viewDidLoad {
    [super viewDidLoad];	
}
*/
- (void) viewWillAppear:(BOOL)animated{
	[self buildDataSourceArray];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [dataSourceArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
    }
	if ([dataSourceArray count] > 0) {
		cell.detailTextLabel.text = [[dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"label"];
	}
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	id object = [[dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"object"];
	[self.navigationController pushViewController:object animated:YES];
}
#pragma mark -
-(void)buildDataSourceArray{
	TextView *textForm = [[TextView alloc] init];
	NSMutableDictionary *tempDic;	
	NSArray *keys = [NSArray arrayWithObjects:@"label",@"name",@"viewType",@"object",nil];
	NSArray *objects = [NSArray arrayWithObjects:@"Search text",@"query",@"text",textForm,nil];	
	tempDic = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
	[textForm autorelease];
	[dataSourceArray addObject:tempDic];
	
	NSMutableDictionary *tempDic2;
	FilterSelectView *pickerForm = [[FilterSelectView alloc] init];
	NSArray *keys2 = [NSArray arrayWithObjects:@"label",@"name",@"viewType",@"object",nil];
	NSArray *objects2 = [NSArray arrayWithObjects:@"Select subcategory",@"category_id",@"select",pickerForm,nil];	
	tempDic2 = [NSMutableDictionary dictionaryWithObjects:objects2 forKeys:keys2];
	[pickerForm autorelease];
	[dataSourceArray addObject:tempDic2];
	
	NSMutableDictionary *tempDic3;
	FilterSelectView *pickerForm2 = [[FilterSelectView alloc] init];
	NSArray *keys3 = [NSArray arrayWithObjects:@"label",@"name",@"viewType",@"object",nil];
	NSArray *objects3 = [NSArray arrayWithObjects:@"Select region",@"region_id",@"select",pickerForm2,nil];
	tempDic3 = [NSMutableDictionary dictionaryWithObjects:objects3 forKeys:keys3];
	[pickerForm2 autorelease];
	[dataSourceArray addObject:tempDic3];
	
	
}
#pragma mark -
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
	[dataSourceArray release];	
    [super dealloc];
}


@end
