//
//  AdView.m
//  IyoApp
//
//  Created by yuriy on 10/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdView.h"
#import "IyoiyoAPI.h"
#import "AsynchronousImage.h"
#import "ClickableImage.h"

@implementation AdView

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil adId:(NSString *)adId{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		ad = [[NSDictionary alloc] init];
		IyoiyoAPI *iyo = [[IyoiyoAPI alloc] init];
		NSDictionary *data = [iyo loadAdById:adId];
		adImages = [[data objectForKey:@"ad_images"] retain];
		ad = [[data	objectForKey:@"ad"] retain];
		[iyo release];
    }
    return self;
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
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{	
	switch (indexPath.row) {
		case 2:
			return 150;
			break;
		default:
			return 45;
			break;
	}
	 
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
    }	
	switch (indexPath.row) {
		case 0:{
			[cell.detailTextLabel setNumberOfLines:2];
			NSString *plabel = [NSString stringWithUTF8String:"\u5186"];
			NSString *price = [NSString stringWithFormat:@"%@ %@",[ad objectForKey:@"price"],plabel];
			NSString *adtitle = [ad objectForKey:@"title"];
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ \n %@ ",adtitle, price];
			break;
		}
			
		case 1:{			
			if ([[ad objectForKey:@"has_images"] intValue] == 1) {				
				ClickableImage *imv1,*imv2, *imv3, *imv4, *imv5, *imv6;
				imv1 = [[ClickableImage alloc]initWithFrame:CGRectMake(0,0, 45, 45)];
				imv2 = [[ClickableImage alloc]initWithFrame:CGRectMake(50,0, 45, 45)];
				imv3 = [[ClickableImage alloc]initWithFrame:CGRectMake(100,0, 45, 45)];
				imv4 = [[ClickableImage alloc]initWithFrame:CGRectMake(150,0, 45, 45)];
				imv5 = [[ClickableImage alloc]initWithFrame:CGRectMake(200,0, 45, 45)];
				imv6 = [[ClickableImage alloc]initWithFrame:CGRectMake(250,0, 45, 45)];
				NSArray *imvArray = [[NSArray alloc] initWithObjects:imv1, imv2, imv3, imv4, imv5, imv6, nil];
				int i = 0;
				for (id item in adImages) {
					NSString *thumbUrl = [item objectForKey:@"thumb_url"];
					NSString *mediaURL = [item objectForKey:@"media_url"];
					AsynchronousImage *asyncLoadImage = [[AsynchronousImage alloc] initWithImageView:[imvArray objectAtIndex:i]
																					  URLPathToImage:thumbUrl];
					[asyncLoadImage setActivityIndicatorPositionIx:5 IY:10 IWidth:30 IHeight:30];
					[[imvArray objectAtIndex:i] setSourceURLString:mediaURL];
					[asyncLoadImage autorelease];					
					//
					[cell addSubview:[imvArray objectAtIndex:i]];					
					[[imvArray objectAtIndex:i] release];
					i++;
				}
				[imvArray release];
			}
			else {
				NSLog(@"No Images");
			}
			break;			
		}		
		case 2:{
			cell.detailTextLabel.text = [ad objectForKey:@"body"];
			[cell.detailTextLabel setNumberOfLines:6];
			break;
		}
		case 3:{
			[cell.detailTextLabel setNumberOfLines:2];
			NSString *regionName = [[ad objectForKey:@"region"] objectForKey:@"name"];
			NSString *cityName = [[ad objectForKey:@"city"] objectForKey:@"name"];
			NSString *advertiserName = [ad objectForKey:@"advertiser_name"];
			cell.detailTextLabel.text =[NSString stringWithFormat:@"%@ - %@\n%@",regionName,cityName,advertiserName];
			break;
		}		
		default:
			break;
	}
	return cell;
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
	[adImages release];
	[ad release];
    [super dealloc];
}


@end
