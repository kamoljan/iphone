//
//  AdPostingView.m
//  IyoIyoApp
//
//  Created by yuriy on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdPostingView.h"
#import "inputText.h"
#import "AdvertiserType.h"
#import "CategoryView.h"
#import "SelectView.h"
#import "AdTypeView.h"
#import "PostCodeView.h"
#import	"inputTextView.h"


@implementation AdPostingView

@synthesize adPostingTable;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		adPostingTable = [[UITableView alloc] init];		
		appDelegate = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		iyoImageView = [[ImageAddingView alloc] initWithNibName:nil bundle:nil];
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
-(void)viewWillAppear:(BOOL)animated
{
	[adPostingTable reloadData];
}
#pragma mark -

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [appDelegate.iyoAdPosting getPostItemsCount];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[appDelegate.iyoAdPosting.postFields objectAtIndex:indexPath.row] objectForKey:@"title"];
	
	id key = [[appDelegate.iyoAdPosting.postFields objectAtIndex:indexPath.row] objectForKey:@"name"];
	
	cell.detailTextLabel.text = [appDelegate.iyoAdPosting postValueItemWithKey:key];
	
	if ([[[appDelegate.iyoAdPosting.postFields objectAtIndex:indexPath.row] objectForKey:@"enabled"] isEqualToString:@"NO"]) {
		cell.textLabel.textColor = [UIColor grayColor];
	}
	else {
		cell.textLabel.textColor = [UIColor blackColor];
	}

	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	NSString *type = [[appDelegate.iyoAdPosting.postFields objectAtIndex:indexPath.row] objectForKey:@"type"];
	NSString *name = [[appDelegate.iyoAdPosting.postFields objectAtIndex:indexPath.row] objectForKey:@"name"];
	
	if (![[[appDelegate.iyoAdPosting.postFields objectAtIndex:indexPath.row] objectForKey:@"enabled"] isEqualToString:@"YES"]) {
		return;
	}
	
	if ([type isEqualToString:@"text"]) {
		inputText *textInputView = [[inputText alloc] initWithNibName:nil bundle:nil];
		[textInputView setPostFieldNumber:indexPath.row];	
		[self.navigationController pushViewController:textInputView animated:YES];
		[textInputView release];
	} else if ( [name isEqualToString:@"advertiser_type"]) {
		AdvertiserType *iyoAdvertiserType = [[AdvertiserType alloc] initWithNibName:nil bundle:nil];
		[iyoAdvertiserType setPostFieldNumber:indexPath.row];
		[self.navigationController pushViewController:iyoAdvertiserType animated:YES];
		[iyoAdvertiserType release];
	} else if ( [name isEqualToString:@"subcategory_id"]) {
		CategoryView *iyoCategoryVew = [[CategoryView alloc] initWithNibName:nil bundle:nil];
		[iyoCategoryVew setPostFieldNumber:indexPath.row];
		[self.navigationController pushViewController:iyoCategoryVew animated:YES];
		[iyoCategoryVew release];
	} else if ( [name isEqualToString:@"ad_type"]) {
		AdTypeView *iyoAdTypeView = [[AdTypeView alloc] initWithNibName:nil bundle:nil];
		[iyoAdTypeView setPostFieldNumber:indexPath.row];		
		[iyoAdTypeView setSourceData:appDelegate.iyoAdPosting.SIAdTypes 
						 withCodeKey:@"name"
						withValueKey:@"id"];		
		[self.navigationController pushViewController:iyoAdTypeView animated:YES];
		[iyoAdTypeView release];
	} else if ( [name isEqualToString:@"post_code"]) {
		PostCodeView *iyoPostCodeView = [[PostCodeView alloc] initWithNibName:nil bundle:nil];
		[iyoPostCodeView setPostFieldNumber:indexPath.row];
		[self.navigationController pushViewController:iyoPostCodeView animated:YES];
		[iyoPostCodeView release];
	} else if	([type isEqualToString:@"select"]){
		SelectView *iyoSelectView = [[SelectView alloc] initWithNibName:nil bundle:nil];
		[iyoSelectView setPostFieldNumber:indexPath.row];
		[iyoSelectView setSourceData:[[appDelegate.iyoAdPosting.postFields objectAtIndex:indexPath.row] 
									  objectForKey:@"value"] 
						 withCodeKey:@"name"
						withValueKey:@"value"];
		[self.navigationController pushViewController:iyoSelectView animated:YES];
		[iyoSelectView release];
		
	} else if ([type isEqualToString:@"textView"]) {
		inputTextView *iyoTextView = [[inputTextView alloc] initWithNibName:nil bundle:nil];
		[iyoTextView setPostFieldNumber:indexPath.row];
		[self.navigationController pushViewController:iyoTextView animated:YES];
		[iyoTextView release];
	} else if ([name isEqualToString:@"file_upload_input"]) {
		
		[iyoImageView setPostFieldNumber:indexPath.row];
		[self.navigationController pushViewController:iyoImageView animated:YES];
		
	} else if ([name isEqualToString:@"sendButton"]) {
		NSDictionary *result = [appDelegate.iyoAdPosting sendNewAdForPosting];//send ad to server and get results
		NSString *message = @"";
		NSArray *errors = [[result objectForKey:@"ad_errors"] allValues];//get errors from results	
		//NSArray *errorKeys = [[result objectForKey:@"ad_errors"] allKeys];//get post keys of errors
		if (errors != nil) {
			for (id item in errors) {				
				if ( ([item isKindOfClass:[NSMutableArray class]]) || ([item isKindOfClass:[NSArray class]]) ) {
					message = [message stringByAppendingString:[item objectAtIndex:0]];
				}
				else {
					message = [message stringByAppendingString:item];
				}				
			}
			UIAlertView *alert = [[UIAlertView alloc]
			initWithTitle:@"Check this Fields"
			message:message
			delegate:nil
			cancelButtonTitle:@"OK"
			otherButtonTitles:nil];
			[alert show];
			[alert release];			
		} else if ([[result objectForKey:@"status"] isEqualToString:@"0"]) {
			message = [result objectForKey:@"email"];
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"Successfull"
								  message:[NSString stringWithFormat:@"Check your e-mail\n%@ for detailes",message]
								  delegate:nil
								  cancelButtonTitle:@"OK"
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
		}

		
	}
	
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
	[iyoImageView release];
	[adPostingTable release];
    [super dealloc];
}


@end
