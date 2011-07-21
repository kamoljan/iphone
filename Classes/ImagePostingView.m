//
//  ImagePostingView.m
//  navBased
//
//  Created by yuriy on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImagePostingView.h"
#import "RequestPostAd.h"

@implementation ImagePostingView
@synthesize imagesArray;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.imagesArray = [[NSMutableArray alloc] init];
		addImageButton = [[UIButton alloc] init];
		imagetableView = [[UITableView alloc] init];
		thumbs = [[NSMutableArray alloc] init];
		
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
	[addImageButton release];
	[pickerController release];
	[thumbs release];
	[super dealloc];
}

#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info
{	
	RequestPostAd *uploadImage = [[RequestPostAd alloc] init];
	UIImage *adImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	NSData *imageData = UIImageJPEGRepresentation(adImage, 1.0);
	
	NSDictionary *adImageDic = [[NSDictionary alloc] initWithDictionary:[uploadImage doRequest:imageData]];
	[self.imagesArray addObject:adImageDic];
	
	[uploadImage release];
	[picker dismissModalViewControllerAnimated:YES];
	
	NSURL *imageUrl = [NSURL URLWithString:[[self.imagesArray lastObject] objectForKey:@"thumb"]];
	NSData *thumbData = [NSData dataWithContentsOfURL:imageUrl];
	UIImage *thumbImage = [UIImage imageWithData:thumbData];
	[thumbs addObject:thumbImage];
	
	[imagetableView reloadData];
	
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];
}
#pragma mark -
-(IBAction) addImageToAd
{
	if ([UIImagePickerController isSourceTypeAvailable: 
		 UIImagePickerControllerSourceTypePhotoLibrary]) {
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
		picker.delegate = self;
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:picker animated:YES];
		[picker release];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc]
							   initWithTitle:@"Error accessing photo library"
							  message:@"Device does not support a photo library"
							  delegate:nil
							  cancelButtonTitle:@"Cansel"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

}

-(void) removeImageAtPosition:(id)sender
{
	[self.imagesArray removeObjectAtIndex:[sender tag]];
	[thumbs removeObjectAtIndex:[sender tag]];
	[imagetableView reloadData];
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [imagesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:@"imageCell"] autorelease];
	}	
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%i - image",(indexPath.row +1 )];	
	
	cell.imageView.image = [thumbs objectAtIndex:indexPath.row];

	UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	myButton.frame = CGRectMake(100, 15, 200, 44); // position in the parent view and set the size of the button
	[myButton setTitle:@"Remove"
			  forState:UIControlStateNormal];
	myButton.tag = indexPath.row;
	// add targets and actions
	[myButton addTarget:self action:@selector(removeImageAtPosition:) 
	   forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:myButton ];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 75;
}

@end
