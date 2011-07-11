//
//  LocationForm.m
//  navBased
//
//  Created by yuriy on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationForm.h"
#import "JSON.h"



@implementation LocationForm

@synthesize resultPostCode, resultRegionId, resultCityId;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		postalTextField = [[UITextField alloc] init];
		regionLabel = [[UILabel alloc] init];
		cityLabel = [[UILabel alloc] init];
		regionsArray = [[NSMutableArray alloc] init];
		citiesArray = [[NSMutableArray alloc] init];
		NSArray *keys = [NSArray arrayWithObjects:@"city", @"city_id", @"region", @"region_id", nil];
		NSArray *values = [NSArray arrayWithObjects:@"",@"",@"",@"",nil];
		currentRegionArray = [[NSMutableArray alloc] init];
		[currentRegionArray addObject:[NSMutableDictionary dictionaryWithObjects:values forKeys:keys]];		
		self.resultPostCode = @"0000000";
		self.resultRegionId = @"0";
		self.resultCityId = @"0";
				
		selectRegion = [[AddPostDataSelectView alloc] init];
		[selectRegion setPickerData:[self getArrayByURL:@"http://www.iyoiyo.jp/ajax/regions"] startFrom:0];
		selectCity = [[AddPostDataSelectView alloc] init];
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	regionLabel.text = @" ";
	cityLabel.text = @" ";
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void) viewWillAppear:(BOOL)animated
{	
		if ([selectRegion.selectedItem count] > 0) {
			[[currentRegionArray objectAtIndex:0] setObject:[selectRegion.selectedItem objectForKey:@"id"]
													 forKey:@"prefecture_id"];
			self.resultRegionId = [selectRegion.selectedItem objectForKey:@"id"];
			[[currentRegionArray objectAtIndex:0] setObject:[selectRegion.selectedItem objectForKey:@"name"]
													 forKey:@"prefecture"];
			regionLabel.text = [[currentRegionArray objectAtIndex:0] objectForKey:@"prefecture"];
		}
		if ([selectCity.selectedItem count] > 0) {
			[[currentRegionArray objectAtIndex:0] setObject:[selectCity.selectedItem objectForKey:@"id"]
													 forKey:@"city_id"];
			self.resultCityId = [selectCity.selectedItem objectForKey:@"id"];
			[[currentRegionArray objectAtIndex:0] setObject:[selectCity.selectedItem objectForKey:@"name"]
													 forKey:@"city"];
			cityLabel.text = [[currentRegionArray objectAtIndex:0] objectForKey:@"city"];
		}	

	
	NSLog(@"\nPostal code: %@\nRegionId: %@\nCityId %@", self.resultPostCode, self.resultRegionId, self.resultCityId);
	
}

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
	[regionLabel release];
	[cityLabel release];
	[postalTextField release];
	[regionsArray release];
	[citiesArray release];
    [super dealloc];
}

#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{	
	NSString *regionsURLString = [NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/postcodes/%@",textField.text];
	[textField resignFirstResponder];

	NSURL *url = [[NSURL alloc] initWithString:regionsURLString];
	NSData *extraData = [NSData dataWithContentsOfURL:url];
	NSString *tempExtraDataString = [[NSString alloc] initWithData:extraData 
														  encoding:NSUTF8StringEncoding];
	currentRegionArray  = [[tempExtraDataString JSONValue] copy];

	if ([currentRegionArray count] > 0) {
		
		self.resultPostCode = textField.text;
		self.resultRegionId = [[currentRegionArray objectAtIndex:0] objectForKey:@"prefecture_id"];
							   
		self.resultCityId = [[currentRegionArray objectAtIndex:0] objectForKey:@"city_id"];
		
		regionLabel.text = [[currentRegionArray objectAtIndex:0] objectForKey:@"prefecture"];	
		cityLabel.text = [[currentRegionArray objectAtIndex:0] objectForKey:@"city"];
		
		NSLog(@"\nPostal code: %@\nRegionId: %@\nCityId %@", self.resultPostCode, self.resultRegionId, self.resultCityId);
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"We couldnt find your post code"
							  message:@"Please, choose your prefecture and city manually"
							  delegate:nil
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
	[url release];
	[tempExtraDataString autorelease];
	return YES;
}


#pragma mark -
-(IBAction) chooseAnotherRegionForm
{
	[self.navigationController pushViewController:selectRegion animated:YES];
}

-(IBAction) chooseAnotherCityForm
{	
	NSString *regionId = [NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/cities/%@",[[currentRegionArray objectAtIndex:0] objectForKey:@"prefecture_id"] ];
	NSMutableArray *cityArray = [self getArrayByURL:regionId];
	[selectCity setPickerData:cityArray startFrom:0];
	[self.navigationController pushViewController:selectCity animated:YES];		
}

-(NSMutableArray *) getArrayByURL:(NSString *) URLString
{
	NSURL *url = [[NSURL alloc] initWithString:URLString];
	NSData *urlData = [NSData dataWithContentsOfURL:url];
	NSString *tempDataString = [[NSString alloc] initWithData:urlData 
														  encoding:NSUTF8StringEncoding];
	NSMutableArray *postData  =[tempDataString JSONValue];
	[url release];	
	[tempDataString release];
	return postData;
}

@end
