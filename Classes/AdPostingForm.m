//
//  AdPostingForm.m
//  navBased
//
//  Created by yuriy on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdPostingForm.h"


@implementation AdPostingForm

@synthesize fields, advertiserTypeForm, adType, subcategory;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
	//	fields = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
		fields = [[NSMutableDictionary alloc] init];
		[fields setValue:@"Advertiser type" forKey: @"advertiser_type"];
		[fields setValue:@"Advertiser name" forKey:@"advertiser_name"];
		[fields setValue:@"e-mail" forKey: @"email"];
		[fields setValue:@"Phone number" forKey:@"phone"];
		[fields setValue:@"Subcategory" forKey:@"subcategory"];
		[fields setValue: @"Ad Type" forKey:@"ad_type"];
		[fields setValue: @"Postal code" forKey:@"post_code"];
		[fields setValue: @"Title" forKey:@"title"];
		[fields setValue:@"Body" forKey:@"body"];
		[fields setValue:@"Price" forKey:@"price"];
		[fields setValue:@"Past Your ads images" forKey: @"file_upload_input"];
		
		//Initialize Advertiser Type Form
		advertiserTypeForm = [[AdvertiserType alloc] init];
		//Initialize Ad Types form
		adType = [[AdType alloc] init];
		//Init Subcategories form
		subcategory = [[Subcategory alloc] init];
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
#pragma mark Table View
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	return [fields count];	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row) {
		case 1 : case 2: case 3: case 6: case 7: case 9:
			return 75;
			break;
		case 8:
			return 150;
			break;
		default:
			return 40;
			break;
	}
//	return 100;
} 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row) {
		case 0:
			[self.navigationController pushViewController:self.advertiserTypeForm animated:YES];
			break;
		case 5:
			[self.navigationController pushViewController:self.adType animated:YES];
			break;
		case 4:
			[self.navigationController pushViewController:self.subcategory animated:YES];
			break;

		default:
			break;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adCell"];

	//if (cell == nil) {
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:@"adCell"] autorelease];
	//}
		
	switch (indexPath.row) {
			case 0:
			[self addTextField:cell 
						 title:[fields objectForKey:@"advertiser_type"]
				 withTextField:NO
					 fieldType:@""
						   tag:indexPath.row];
			
			break;
			case 1:
			[self addTextField:cell 
						 title:[fields objectForKey:@"advertiser_name"]
				 withTextField:YES
					 fieldType:@""
						   tag:indexPath.row];
			break;
			case 2:
			[self addTextField:cell 
						 title:[fields objectForKey:@"email"]
				 withTextField:YES
					 fieldType:@"email"
						   tag:indexPath.row];
			break;
			case 3:
			[self addTextField:cell
						 title:[fields objectForKey:@"phone"]
				 withTextField:YES
					 fieldType:@"phone"
						   tag:indexPath.row];
			break;
			case 4:
			[self addTextField:cell
						 title:[fields objectForKey:@"subcategory"]
				 withTextField:NO
					 fieldType:@""
						   tag:indexPath.row];
			break;
			case 5:
			[self addTextField:cell
						 title:[fields objectForKey:@"ad_type"]
				 withTextField:NO
					 fieldType:@""
						   tag:indexPath.row];
			break;
			case 6:
			[self addTextField:cell
						 title:[fields objectForKey:@"post_code"]
				 withTextField:YES
					 fieldType:@""
						   tag:indexPath.row];
			break;
			case 7:
			[self addTextField:cell
						 title:[fields objectForKey:@"title"]
				 withTextField:YES
					 fieldType:@""
						   tag:indexPath.row];
			break;
			case 8:
			[self addTextView:cell
						 title:[fields objectForKey:@"body"]
						   tag:indexPath.row];
			cell.textLabel.text = @"";
			break;
			case 9:
			[self addTextField:cell
						 title:[fields objectForKey:@"price"]
				 withTextField:YES
					 fieldType:@""
						   tag:indexPath.row];
			break;
			case 10:
			[self addTextField:cell
						 title:[fields objectForKey:@"file_upload_input"]
				 withTextField:NO
					 fieldType:@""
						   tag:indexPath.row];
				break;
			default :
				
				break;
	}
	
	return cell;
	
}


-(void)addTextField:(UITableViewCell *)cell 
			  title:(NSString *)title 
	  withTextField:(Boolean)withTextField 
	 fieldType:(NSString *)fieldType
				tag:(NSUInteger)tag 
{
	
	CGSize labelSize = CGSizeMake(250, 50);
	NSString *theText = title;
	UILabel *myUILabel = [[UILabel alloc] init];
	CGSize theStringSize = [theText sizeWithFont:myUILabel.font constrainedToSize:labelSize lineBreakMode:myUILabel.lineBreakMode];
	myUILabel.frame = CGRectMake(myUILabel.frame.origin.x+10, myUILabel.frame.origin.y+5, theStringSize.width, theStringSize.height);
	myUILabel.text = theText;
	[cell addSubview:myUILabel];
	
	if (withTextField) {
		UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 35, 185, 30)];
		playerTextField.adjustsFontSizeToFitWidth = YES;
		playerTextField.textColor = [UIColor blackColor];
		playerTextField.placeholder = @"Required";
		if (fieldType==@"email") {
			playerTextField.keyboardType = UIKeyboardTypeEmailAddress;			
		}
		else if (fieldType==@"phone") {
			playerTextField.keyboardType = UIKeyboardTypePhonePad;
		}
		else {
			playerTextField.keyboardType = UIKeyboardTypeDefault;
		}

		playerTextField.textAlignment = UITextAlignmentLeft;
		playerTextField.borderStyle = UITextBorderStyleRoundedRect;    
		playerTextField.returnKeyType = UIReturnKeyDone;
		playerTextField.secureTextEntry = NO;
	
		playerTextField.backgroundColor = [UIColor whiteColor];
		playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
		playerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
		playerTextField.textAlignment = UITextAlignmentLeft;
		playerTextField.tag = (NSInteger)tag;
		playerTextField.delegate = self;
	
		playerTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
		[playerTextField setEnabled: YES];
	
		[cell addSubview:playerTextField];
	
		[playerTextField release];
		
	}

	[myUILabel release];
}

-(void)addTextView:(UITableViewCell *)cell 
			  title:(NSString *)title 
				tag:(NSUInteger)tag 
{
	
	CGSize labelSize = CGSizeMake(250, 50);
	NSString *theText = title;
	UILabel *myUILabel = [[UILabel alloc] init];
	CGSize theStringSize = [theText sizeWithFont:myUILabel.font constrainedToSize:labelSize lineBreakMode:myUILabel.lineBreakMode];
	myUILabel.frame = CGRectMake(myUILabel.frame.origin.x+10, myUILabel.frame.origin.y+5, theStringSize.width, theStringSize.height);
	myUILabel.text = theText;
	[cell addSubview:myUILabel];
	UITextView *adTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 35, 185, 100)];
	adTextView.textColor = [UIColor blackColor];
	adTextView.keyboardType = UIKeyboardTypeDefault;	
	adTextView.textAlignment = UITextAlignmentLeft;
	adTextView.returnKeyType = UIReturnKeyDone;
	adTextView.secureTextEntry = NO;
	adTextView.delegate = self;
	adTextView.text = @"YOur Ad`s body text here";
	adTextView.backgroundColor = [UIColor whiteColor];
	adTextView.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
	adTextView.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
	adTextView.textAlignment = UITextAlignmentLeft;
	adTextView.tag = (NSInteger)tag;
	adTextView.delegate = self;
	
	[cell addSubview:adTextView];
	
	[adTextView release];
	

	[myUILabel release];
}

#pragma mark -
#pragma mark textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	[textView resignFirstResponder];
}

#pragma mark -
#pragma mark standart Form methods

- (void)viewWillAppear:(BOOL)animated
{
	if (subcategory.currentCatId > 0) {
			
	}
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
	[fields release];
    [super dealloc];
}


@end
