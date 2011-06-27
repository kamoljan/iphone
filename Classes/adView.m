//
//  adView.m
//  navBased
//
//  Created by yuriy on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "adView.h"
#import "JSON.h"

@implementation adView


@synthesize adBodyTextView, adPriceLabel, imageView, appDelegateView, adPrice, adImage,
adJsonString, adBody, adQueue;
@synthesize currentAd;

#pragma mark -
#pragma mark Prepare ad

-(void) requestForAd:(NSString *)adId
{	
	NSString *adViewUrlString = [NSString stringWithFormat:@"http://www.iyoiyo.jp/ios/ad/%@",adId];

	//NSLog(@" The Choosen AD ID is: %@",appDelegateView.adId);
		
	NSURL *adUrl = [NSURL URLWithString:adViewUrlString];
	NSData *adData = [NSData dataWithContentsOfURL:adUrl];
	NSString *adJSONString = [[NSString alloc] initWithData:adData encoding:NSUTF8StringEncoding];

	self.currentAd = [adJSONString JSONValue];

	//Prepare ads price
	self.adPrice =  [NSString stringWithFormat:@"%@",[[self.currentAd objectForKey:@"ad"] objectForKey:@"price"]];
	// Prepare ads body
	self.adBody =  [NSString stringWithFormat:@"%@",[[self.currentAd objectForKey:@"ad"] objectForKey:@"body"]];
	self.adPriceLabel.text = self.adPrice;
		
	self.adBodyTextView.text = self.adBody;
	self.imageView.image = [UIImage imageNamed:@"img16.gif"];
		
	[adJSONString release];
	[self prepareAd];
	
}

-(void) prepareAd
{	
	// Asynchronously load image	
	NSInvocationOperation *adOperation = [[NSInvocationOperation alloc] 
										initWithTarget:self
										selector:@selector(loadAdImage)
										object:nil];
	[adQueue addOperation:adOperation];
	if ( [adQueue operationCount] == 1 ) {
		[[[adQueue operations] objectAtIndex:0] cancel];
	}
	
	NSLog(@"Operations count in queue %i", [adQueue operationCount]);
	
	[adOperation release];

}

-(void) loadAdImage
{		 
	NSAutoreleasePool *loadingPool = [[NSAutoreleasePool alloc] init];
	// Prepare images
	NSArray *adImages = [self.currentAd objectForKey:@"ad_images"];
	
	
	NSString *imageURLString ;
	NSURL *imageURL;
	NSData *imageImageData;
	UIImage *image;

	 NSMutableDictionary *imageURLDictionary;
	
	imageURLDictionary = [adImages objectAtIndex:0];	
	
	 imageURLString = [imageURLDictionary objectForKey:@"media_url"];	
	 imageURL = [NSURL URLWithString:imageURLString];		
	 imageImageData = [NSData dataWithContentsOfURL:imageURL];
	 image = [UIImage imageWithData:imageImageData];		
	 if (image == nil) {
		 image = [UIImage imageNamed:@"img16.gif"];
	 }
	self.adImage = image;
	[self performSelectorOnMainThread:@selector(changeImage) withObject:nil
						waitUntilDone:YES];
	
	[loadingPool release];
	
}

-(void) changeImage
{
	 self.imageView.image = self.adImage;	
}

#pragma mark -
#pragma mark Initialization
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		// Custom initialization.
		self.title = NSLocalizedString(@"Ad View", @"");		
		appDelegateView = (navBasedAppDelegate *)[[UIApplication sharedApplication] 
												  delegate];		
		adImage = [[UIImage alloc] init];
		adJsonString = [[NSString alloc] init];
		currentAd = [[NSMutableDictionary alloc] init];
		adPrice = [[NSString alloc] init];
		
		adQueue = [NSOperationQueue new];
		self.adPriceLabel = [[UILabel alloc] init];

		// Prepare the ad to ad View page		
		//[self requestForAd];
				
    }	
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	adPriceLabel.text = @"";
	imageView.image = nil;
	self.adImage = nil;
	adBodyTextView.text = @"";
	[self requestForAd:self.appDelegateView.adId];
}

-(void) viewWillDisappear:(BOOL)animated
{
	self.appDelegateView.needToRefresh = NO;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
	
    [super viewDidLoad];	
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
	[adPriceLabel release];
	[imageView release];
	[adImage release];
	[adJsonString release];
	[currentAd release];
	[adPrice release];
	[adBodyTextView release];
	[adBody release];
	
	[adQueue release];
    [super dealloc];
}


@end
