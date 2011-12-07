//
//  SearchView.m
//  IyoApp
//
//  Created by yuriy on 10/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchView.h"
#import "AdView.h";

@implementation SearchView

@synthesize adsTable;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		adsList = [[Search alloc] init];		
		pageNumber = 0;		
		[adsList searchWithFilter:nil];
		activityImage = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityImage.frame = CGRectMake(0, 0, 50, 50);
		activityImage.hidesWhenStopped = NO;
		[activityImage startAnimating];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
    [super viewDidLoad];		
}

-(void) viewDidAppear:(BOOL)animated{	
	[adsList setTbView:self.adsTable];
	[adsList startLoadingImages];
	[adsTable reloadData];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {		
	if ([adsList.dataSource count] > 0) {
		return ([adsList.dataSource count] + 1);
	}
	return 1;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
    }	
	if (indexPath.row < [adsList.dataSource count]) {
		// Configure the cell...
		cell.textLabel.text = [[adsList.dataSource objectAtIndex:indexPath.row] objectForKey:@"title"];		
		if ([adsList.imagesSource count] < 8) {
			[adsList.imagesSource insertObject:cell.imageView atIndex:indexPath.row];
		}		
		UIImage *emptyImage = [UIImage imageNamed:@"empty.PNG"];
		if (cell.imageView.image == nil) {
			[cell.imageView setImage:emptyImage];
		}		
		//[cell.imageView setImage:nil];
		//	cell.detailTextLabel.text = ;
	}else {
		cell.detailTextLabel.text = @"Show Next";
	}

	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row == [adsList.dataSource count]) {
		[adsList stopLoadingImages];
		pageNumber++;
		NSString *pageNumberString = [NSString stringWithFormat:@"%i",(pageNumber*8)];
		NSDictionary *tempDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"start",pageNumberString,nil]
															 forKeys:[NSArray arrayWithObjects:@"key",@"value",nil]];
		NSArray *filterArray = [NSArray arrayWithObjects:tempDict,nil];
		[adsList searchWithFilter:filterArray];
		[adsTable reloadData];
		return;
	}
	int adId = [[[adsList.dataSource objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];	
	AdView *iyoAdView = [[AdView alloc] initWithNibName:nil bundle:nil adId:[NSString stringWithFormat:@"%i",adId]];
	[self.navigationController pushViewController:iyoAdView animated:YES];
	[iyoAdView release];
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
	[activityImage stopAnimating];
	[activityImage release];
	[adsList release];
    [super dealloc];
}


@end
