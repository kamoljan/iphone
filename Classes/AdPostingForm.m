//
//  AdPostingForm.m
//  navBased
//
//  Created by yuriy on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdPostingForm.h"
#import "JSON.h"


@implementation AdPostingForm

@synthesize advertiserTypeForm, adType, subcategory, extraParametres;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		appDelegate = (navBasedAppDelegate *)[[UIApplication sharedApplication] 
											  delegate];

		fieldsArray = [[NSMutableArray alloc] init];
		//Initialize Advertiser Type Form
		advertiserTypeForm = [[AdvertiserType alloc] init];
		//Initialize Ad Types form
		adType = [[AdType alloc] init];
		//Init Subcategories form
		subcategory = [[Subcategory alloc] initWithNibName:nil bundle:nil];
		//Init Extra parametres view
		extraParametres = [[ExtraForms alloc] initWithNibName:nil bundle:nil];
		
		[self prepareFieldsArray];
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
	return [fieldsArray count];	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{/*
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
  */
	return [[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"height"] intValue];
} 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"type"] == @"select") {
		NSURL *iyoURL = [NSURL URLWithString:@"http://www.iyoiyo.jp/ajax/category_tree"];
		[self.subcategory loadDataWithURLArray:iyoURL];
		[self.navigationController pushViewController:self.subcategory animated:YES];	
	}
	/*
	switch (indexPath.row) {
		case 0:
			[self.navigationController pushViewController:self.advertiserTypeForm animated:YES];
			break;
		case 5:			
			//extraParametres.catId = subcategory.currentCatId;
			[extraParametres setCatId:subcategory.currentCatId];
			[self.navigationController pushViewController:self.extraParametres animated:YES];
			break;
		case 4:
			[self.navigationController pushViewController:self.subcategory animated:YES];
			break;

		default:
			break;
	}
	 */
}

-(UITableViewCell *) tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adCell"];

	//if (cell == nil) {
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:@"adCell"] autorelease];
	//}
	/*
	[self addTextField:cell 
				 title:[fields objectForKey:@"advertiser_type"]
		 withTextField:NO
			 fieldType:@""
				tag:indexPath.row];
	*/
	
	[self addLabel:[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"title"] 
			toCell:cell];
	
	NSString *fieldType = [[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"type"];
	if (fieldType == @"textView") {
		[self addTextViewToCell:cell];
	}
	else if (fieldType == @"text") {
		[self addTextFieldToCell:cell
				withKeyboardType:[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"text_type"]];
	}
	return cell;
	
}

-(void) addLabel:(NSString *)labelTitle toCell:(UITableViewCell *)cell
{
	CGSize labelSize = CGSizeMake(250, 50);
	UILabel *myUILabel = [[UILabel alloc] init];
	CGSize theStringSize = [labelTitle sizeWithFont:myUILabel.font constrainedToSize:labelSize lineBreakMode:myUILabel.lineBreakMode];
	myUILabel.frame = CGRectMake(myUILabel.frame.origin.x+10, myUILabel.frame.origin.y+5, theStringSize.width, theStringSize.height);
	myUILabel.text = labelTitle;
	[cell addSubview:myUILabel];
	
	[myUILabel release];
	
}

-(void) addTextViewToCell:(UITableViewCell *)cell
{
	UITextView *adTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 35, 185, 100)];
	adTextView.textColor = [UIColor blackColor];
	adTextView.keyboardType = UIKeyboardTypeDefault;	
	adTextView.textAlignment = UITextAlignmentLeft;
	adTextView.returnKeyType = UIReturnKeyDone;
	adTextView.secureTextEntry = NO;
	adTextView.delegate = self;
	adTextView.text = @"Your Ad`s body text here";
	adTextView.backgroundColor = [UIColor whiteColor];
	adTextView.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
	adTextView.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
	adTextView.textAlignment = UITextAlignmentLeft;
	adTextView.delegate = self;
	
	[cell addSubview:adTextView];
	
	[adTextView release];
}

-(void) addTextFieldToCell:(UITableViewCell *)cell withKeyboardType:(NSString *)keyboardType
{
	UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 35, 185, 30)];
	playerTextField.adjustsFontSizeToFitWidth = YES;
	playerTextField.textColor = [UIColor blackColor];
	playerTextField.placeholder = @"Required";
	if (keyboardType == @"email") {
		playerTextField.keyboardType = UIKeyboardTypeEmailAddress;			
	}
	else if (keyboardType == @"phone") {
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
	playerTextField.delegate = self;
	
	playerTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
	[playerTextField setEnabled: YES];
	
	[cell addSubview:playerTextField];
	
	[playerTextField release];
}

-(void) prepareFieldsArray
{
	[fieldsArray removeAllObjects];
	NSMutableDictionary *tempField = [[NSMutableDictionary alloc] init];
	[tempField setObject:@"Advertiser type" forKey:@"title"];
	[tempField setObject:@"advertiser_type" forKey:@"name"];
	[tempField setObject:@"optional" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Advertiser name" forKey:@"title"];
	[tempField setObject:@"advertiser_name" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"e-mail" forKey:@"title"];
	[tempField setObject:@"email" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"email" forKey:@"text_type"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Phone number" forKey:@"title"];
	[tempField setObject:@"phone" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"phone" forKey:@"text_type"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Subcategory" forKey:@"title"];
	[tempField setObject:@"subcategory" forKey:@"name"];
	[tempField setObject:@"select" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	
	[tempField setObject:@"Ad type" forKey:@"title"];
	[tempField setObject:@"ad_type" forKey:@"name"];
	[tempField setObject:@"optional" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Postal code" forKey:@"title"];
	[tempField setObject:@"post_code" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Title" forKey:@"title"];
	[tempField setObject:@"title" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Body" forKey:@"title"];
	[tempField setObject:@"body" forKey:@"name"];
	[tempField setObject:@"textView" forKey:@"type"];
	[tempField setObject:@"150" forKey:@"height"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Price" forKey:@"title"];
	[tempField setObject:@"price" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Past Your ads images" forKey:@"title"];
	[tempField setObject:@"file_upload_input" forKey:@"name"];
	[tempField setObject:@"image" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
		
	[tempField release];
	if (subcategory.currentCatId != @"0") {
		[self loadExtraFields];
	}	
}

-(void) loadExtraFields
{
	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/extra_forms/%@",subcategory.currentCatId]];
	NSData *extraData = [NSData dataWithContentsOfURL:url];
	NSString *tempExtraDataString = [[NSString alloc] initWithData:extraData 
														  encoding:NSUTF8StringEncoding];
	extraFormsArray =[tempExtraDataString JSONValue];
	
	[tempExtraDataString release];
	[url release];
	// reloadData];
	
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

-(void)viewWillDisappear:(BOOL)animated
{
	appDelegate.needToRefresh = NO;
	
}

- (void)viewWillAppear:(BOOL)animated
{
	
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
	[advertiserTypeForm release];
	[adType release];
	[subcategory release];
	[extraParametres release];
    [super dealloc];
}


@end
