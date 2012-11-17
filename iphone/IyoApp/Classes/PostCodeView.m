//
//  PostCodeView.m
//  IyoApp
//
//  Created by yuriy on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PostCodeView.h"


@implementation PostCodeView

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		appDelegate = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		regionSelectView = [[SelectView alloc] initWithNibName:nil bundle:nil];
		citySelectView = [[SelectView alloc] initWithNibName:nil bundle:nil];
		[appDelegate.iyoAdPosting initPrefectures];
		
    }
    return self;
}

#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if ( ![textField.text isEqualToString:@""] ) {		
		[appDelegate.iyoAdPosting chooseMapItemsByPostCode:textField.text];
		[appDelegate.iyoAdPosting insertValue:textField.text
								   labelValue:appDelegate.iyoAdPosting.currentPrefecture 
						   forPostItemWithKey:@"post_code"];
		
		[appDelegate.iyoAdPosting insertValue: appDelegate.iyoAdPosting.currentPrefectureId
								   labelValue:appDelegate.iyoAdPosting.currentPrefecture 
						   forPostItemWithKey:@"region_id"];
		regionSelectView.selectedValueId = appDelegate.iyoAdPosting.currentPrefectureId;
		regionSelectView.selectedValue = appDelegate.iyoAdPosting.currentPrefecture;
		regionLabel.text = appDelegate.iyoAdPosting.currentPrefecture;// show selected prefecture in label		
		[appDelegate.iyoAdPosting insertValue: appDelegate.iyoAdPosting.currentCityId
								   labelValue:appDelegate.iyoAdPosting.currentCity 
						   forPostItemWithKey:@"city_id"];
		citySelectView.selectedValueId = appDelegate.iyoAdPosting.currentCityId;
		citySelectView.selectedValue = appDelegate.iyoAdPosting.currentCity;
		cityLabel.text = appDelegate.iyoAdPosting.currentCity;
	}	
	[textField resignFirstResponder];
	return YES;
}

-(IBAction)showRegionView{
	/*
	 [
		{
			"id": "1"
			"name": "blablabla"
		},
		...
	 ]
	 */
	[regionSelectView setSourceData:appDelegate.iyoAdPosting.SIPrefectures
						withCodeKey:@"name"
					   withValueKey:@"id"];
	[regionSelectView setPosKey:@"region_id"];
	 
	[self.navigationController pushViewController:regionSelectView animated:YES];
}
-(IBAction)showCityView{	
	if ( ([regionSelectView.selectedValueId floatValue] != 0) ) {
		[appDelegate.iyoAdPosting loadCitiesByPrefectureId:regionSelectView.selectedValueId];	
		[citySelectView setSourceData:appDelegate.iyoAdPosting.SICities
						  withCodeKey:@"name"
						 withValueKey:@"id"];
		[citySelectView setPosKey:@"city_id"];
		[citySelectView.picker reloadComponent:0];
		[citySelectView.picker selectRow:0 inComponent:0 animated:NO];
		[self.navigationController pushViewController:citySelectView animated:YES];
	}
}
-(void) setPostFieldNumber:(int)number{
	postItemNumber = number;	
}
-(IBAction)didOK{
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
-(void)viewWillAppear:(BOOL)animated
{
	regionLabel.text = regionSelectView.selectedValue;
	cityLabel.text = citySelectView.selectedValue;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	postCodeField.text = [appDelegate.iyoAdPosting postValueWithKey:@"post_code"];
	[self textFieldShouldReturn:postCodeField];
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
	[regionSelectView release];
	[citySelectView release];
    [super dealloc];
}


@end
