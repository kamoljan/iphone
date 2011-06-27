//
//  RootViewController.m
//  navBased
//
//  Created by yuriy on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "adView.h"
#import "JSON.h"


@implementation RootViewController

@synthesize iyoThumbs, jsonString;
@synthesize activityIndicator, appDelegate, resultsTitles, adViewController,
changeFilterController, searchQueue;


#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{	
	if (self.appDelegate.needToRefresh) {
		searchQueue = [NSOperationQueue new];
		self.jsonString = @"";
		[resultsTitles removeAllObjects];
		[iyoThumbs removeAllObjects];
		[self.appDelegate.searchResults removeAllObjects];
		
		[self.tableView reloadData];
		
		[self searchIyoAds:appDelegate.searchFilter];
	}
}

- (void)viewDidLoad {
  	self.title = @"Iyoiyo.jp";
	
	appDelegate = (navBasedAppDelegate *)[[UIApplication sharedApplication] delegate];
	adViewController = [[adView alloc] initWithNibName:@"adView" bundle:[NSBundle mainBundle]];
	//Back button
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc]init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	jsonString = [[NSString alloc] init];	
	iyoThumbs = [[NSMutableArray alloc] init];
	resultsTitles = [[NSMutableArray alloc] init];

//	[self searchIyoAds:appDelegate.searchFilter];
	
	[super viewDidLoad];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


-(void) defaultSearchIyoiyoAds
{	
	NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.iyoiyo.jp/ios/search"];
	
	NSURL *url = [NSURL URLWithString:urlString];
	
	// Setup and start async download
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[urlString release];
	
	[connection release];
	[request release];	
}

#pragma mark -
#pragma mark Searching iyoiyo ads

-(void) searchIyoAds:(NSDictionary *) filter
{	
	
	NSString *urlString = [NSString stringWithFormat:@"http://www.iyoiyo.jp/ios/search?query=%@&category_id=%@&region_id=%@&start=%@&limit=%@",
						   [appDelegate.searchFilter objectForKey:@"query"],
						   [appDelegate.searchFilter objectForKey:@"category_id"],
						   [appDelegate.searchFilter objectForKey:@"region_id"],
						   [appDelegate.searchFilter objectForKey:@"start"],
						   [appDelegate.searchFilter objectForKey:@"limit"]];
	NSLog(@"%@",urlString);
	NSURL *url = [NSURL URLWithString:urlString];
	NSLog(@"searchIyoAds methos id called with this parametres: %@", appDelegate.searchFilter);
	// Setup and start async download
	NSAutoreleasePool *requestPool = [[NSAutoreleasePool	alloc] init];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection release];
	[request release];
	
	[requestPool release];

}
-(void) asyncThumbsStart
{
	NSAutoreleasePool *thumbsPool = [[NSAutoreleasePool alloc] init];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc]
										initWithTarget:self
										selector:@selector(loadAdsThumbs)
										object:nil];	
	if ( [searchQueue operationCount] == 1 ) {
		[[[searchQueue operations] objectAtIndex:0] cancel];
	}
	
	[searchQueue addOperation:operation];	
	[operation release];	
	
	[thumbsPool release];
}
-(void) loadAdsThumbs
{
	//Creating Images array	for UITableView
	NSString *thumbsURLString;
	NSURL *thumbsURL ;
	NSData *thumbImageData;
	NSDictionary *iyoAd;
	UIImage *image;
	
	NSLog(@"Images loading started");
	
	for (int i = 0; i < [self.appDelegate.searchResults count]; i++) {		
		
		iyoAd = [self.appDelegate.searchResults objectAtIndex:i];
		thumbsURLString = [NSString stringWithFormat:@"%@",[iyoAd objectForKey:@"thumb_url"]];
		thumbsURL = [NSURL URLWithString:thumbsURLString];		
		thumbImageData = [NSData dataWithContentsOfURL:thumbsURL];
		
		
		if ( thumbImageData == nil ){
			image = [UIImage imageNamed:@"img16.gif"];
		}
		else {
			image = [UIImage imageWithData:thumbImageData];
		}		
		
		if ( (i + 1) <= [self.iyoThumbs count])
		{
			[self.iyoThumbs insertObject:image atIndex:i];
		
			NSIndexPath *curPath = [NSIndexPath indexPathForRow:i inSection:0];

			[self performSelectorOnMainThread:@selector(reloadTableData:) withObject:curPath 
							waitUntilDone:NO];
		}
		
	}	
}

-(void) reloadTableData:(NSIndexPath *)curPath
{	
	NSArray *paths = [NSArray arrayWithObject:curPath];
	[self.tableView beginUpdates];
	[self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];	
	[self.tableView endUpdates];		
	
}
#pragma mark -
#pragma mark Request
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	NSLog(@"Data recived");
	NSString *tempJsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	self.jsonString = [self.jsonString stringByAppendingString:tempJsonString]; 
	[tempJsonString release];
	
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{	
	
	NSDictionary *results = [self.jsonString JSONValue];
	appDelegate.searchResults = [results objectForKey:@"ads"];
	
	[self asyncThumbsStart];
	for (int i = 0; i < [self.appDelegate.searchResults count]; i++) {	
		[resultsTitles addObject:[[appDelegate.searchResults objectAtIndex:i] objectForKey:@"title"]];
		[self.iyoThumbs addObject:[UIImage imageNamed:@"img16.gif"]];
	}

		
	[self.tableView reloadData];	
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSUInteger count = [resultsTitles count];
	if (count > 0) {
		return count;
	}
	return 9;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
	}
	
	if ( ([resultsTitles count] > 0 ) && ([resultsTitles count] >= (indexPath.row + 1 )) ) {
	
		cell.textLabel.text = [resultsTitles objectAtIndex:indexPath.row];
	
		cell.imageView.image = [self.iyoThumbs objectAtIndex:[indexPath row]];
		
		NSDictionary *iyoAd = [appDelegate.searchResults objectAtIndex:indexPath.row];
		NSString *price = [NSString stringWithFormat:@"%@",[iyoAd objectForKey:@"price"]];
		cell.detailTextLabel.text = price;
		
	}
	else {
		cell.textLabel.text = @"";
		cell.detailTextLabel.text = @"Loading iyoiyo ads";
		cell.imageView.image = nil;		
	}
	
	return cell	;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	if ( [appDelegate.searchResults count] >= (indexPath.row +1) ) {
		NSString *tempString = [[appDelegate.searchResults objectAtIndex:indexPath.row] objectForKey:@"link"];
		NSArray *components = [tempString componentsSeparatedByString:@"/"];
	
	
		self.appDelegate.adId = [components objectAtIndex:4];
		[self.navigationController pushViewController:self.adViewController animated:YES];

	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[iyoThumbs release];
	[activityIndicator release];
	[resultsTitles release];
	[searchQueue release];
	[jsonString release];
    [super dealloc];
}


@end

