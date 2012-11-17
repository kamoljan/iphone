//
//  ImageAddingView.m
//  IyoApp
//
//  Created by yuriy on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageAddingView.h"


@implementation ImageAddingView
@synthesize imagesArray;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		appDelegate = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		imagesArray = [[NSMutableArray alloc] init];
		addImageButton = [[UIButton alloc] init];
		imagetableView = [[UITableView alloc] init];
		thumbs = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info
{	
	UIImage *adImage = [info objectForKey:UIImagePickerControllerOriginalImage];	
	[appDelegate.iyoAdPosting addImage:adImage];
	[picker dismissModalViewControllerAnimated:YES];
	NSURL *imageUrl = [NSURL URLWithString:[[appDelegate.iyoAdPosting.images lastObject] objectForKey:@"thumb"]];
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
-(void) setPostFieldNumber:(int)number
{
	postItemNumber = number;
}

-(IBAction) addImageToAd:(id)sender
{	
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	if (sender == addCameraImageButton) {
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
			picker.sourceType = UIImagePickerControllerSourceTypeCamera;
			[self presentModalViewController:picker animated:YES];
			[picker release];
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"Error accessing photo library"
								  message:@"Device does not support a camera"
								  delegate:nil
								  cancelButtonTitle:@"Cansel"
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			[picker	release];			
		}		
	}
	else {
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
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
			[picker	release];
		}
		
	}
	
	/*UIAlertView *alert = [[UIAlertView alloc]
	 initWithTitle:@"Error accessing photo library"
	 message:@"Device does not support a photo library"
	 delegate:nil
	 cancelButtonTitle:@"Cansel"
	 otherButtonTitles:nil];
	 [alert show];
	 [alert release];
	 */
	
}

-(void) removeImageAtPosition:(id)sender
{	
	[appDelegate.iyoAdPosting.images removeObjectAtIndex:[sender tag]];
	[thumbs removeObjectAtIndex:[sender tag]];
	[imagetableView reloadData];	
}

-(IBAction) didOK{	
	[appDelegate.iyoAdPosting insertImagesToPost];
	[appDelegate.iyoAdPosting.images removeAllObjects];
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	return [appDelegate.iyoAdPosting.images count];
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

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	viewLabel.text = [[appDelegate.iyoAdPosting.postFields objectAtIndex:postItemNumber] objectForKey:@"title"];
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
	[imagesArray release];
	[addImageButton release];
	[imagetableView release];
	[thumbs release];
    [super dealloc];
}


@end
