//
//  AdPostingForm.m
//  navBased
//
//  Created by yuriy on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdPostingForm.h"
#import "JSON.h"
#import "RequestPostAd.h"


@implementation AdPostingForm

//@synthesize advertiserTypeForm, subcategory, extraParametres, tableView,
//fieldsArray, shouldChangePostItem, changingIndexAtPostArray, pickerViewValues;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		activeCatId = [[NSString alloc] initWithString:@"9"];
		appDelegate = (navBasedAppDelegate *)[[UIApplication sharedApplication] 
											  delegate];
		shouldChangePostItem = NO;
		changingIndexAtPostArray = -1;
		changingValueType = [[NSString alloc] initWithFormat:@"no_type"];
		changingValueKey = [[NSString alloc] initWithFormat:@"no_key"];
		
		pickerViewValues = [[NSMutableArray alloc] init];
		fieldsArray = [[NSMutableArray alloc] init];
		postArray = [[NSMutableArray alloc] init];

		//Init Subcategories form
		subcategory = [[Subcategory alloc] init];
		NSURL *iyoURL = [NSURL URLWithString:@"http://www.iyoiyo.jp/ajax/category_tree"];
		[subcategory loadDataWithURLArray:iyoURL];		
		//Initialize Advertiser Type Form
		advertiserTypeForm = [[AdvertiserType alloc] init];
		//Init Extra parametres view
		extraParametres = [[ExtraForms alloc] init];	
		addPostDataView = [[AddPostDataView alloc] init];
		addPostDataSelectView = [[AddPostDataSelectView alloc] init];
		imagePostingView = [[ImagePostingView alloc] init];
		locationForm = [[LocationForm alloc] init];
		
		
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
	[self shouldChangePostData:YES 
				atIndexPostion:indexPath.row
						forType:[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"type"] 
						forKey:[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
	
	if ([[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"name"] == @"subcategory_id") {		
		[self.navigationController pushViewController:subcategory animated:YES];	
	}
	else if ([[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"name"] isEqualToString:@"post_code"] ) {
		[self.navigationController pushViewController:locationForm animated:YES];
	}
	else if ([[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"name"] == @"ad_type")
	{		
		[addPostDataView loadOptionsDataByurl:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/adtypes/%@",activeCatId] ];
		[self.navigationController pushViewController:addPostDataView animated:YES];		
	}
	else if ([[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"name"] isEqualToString:@"file_upload_input" ])
	{
		[self.navigationController pushViewController:imagePostingView animated:YES];
	}
	else if ([[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"radio" ])
	{			
		[addPostDataView setOptionsData:[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"value"]];
		[self.navigationController pushViewController:addPostDataView animated:YES];
	}
	else if ([[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"select" ])
	{
		[addPostDataSelectView setPickerData:[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"value"] startFrom:1];
		[self.navigationController pushViewController:addPostDataSelectView animated:YES];
	}
	else if ([[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"sendButton" ]) {
		RequestPostAd *postRequest = [[RequestPostAd alloc] init];
		//[postRequest postAddWithArray:postArray toURLString:[NSString stringWithFormat:@"http://iyoiyo.jp/ios/post"]];		
		[postRequest postAddWithArray:postArray toURLString:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ios/post"]];
		[postRequest release];		
	}

}

-(UITableViewCell *) tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:@"adCell"] autorelease];
	
	[self addLabel:[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"title"] toCell:cell];
	
	NSString *fieldType = [[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"type"];	
	if (fieldType == @"textView") {
		[self addTextViewToCell:cell];
	}
	else if ([fieldType isEqualToString:@"text" ]) {		
		[self addTextFieldToCell:cell
				withKeyboardType:[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"text_type"]
						 withTag:[[[fieldsArray objectAtIndex:indexPath.row] objectForKey:@"tag"] intValue]];
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
	for (int i = 0; i < [fieldsArray count]; i++) {
		if ([[[fieldsArray objectAtIndex:i] objectForKey:@"name"] isEqualToString:@"body"] ) {
			for (id item in postArray) {
				if ([[item objectForKey:@"name"] isEqualToString:[[fieldsArray objectAtIndex:i] objectForKey:@"name"]]) {
					adTextView.text = [item objectForKey:@"value"];
				}
			}
		}
	}
	//adTextView.text = @"Your Ad`s body text here";
	adTextView.backgroundColor = [UIColor whiteColor];
	adTextView.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
	adTextView.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
	adTextView.textAlignment = UITextAlignmentLeft;
	adTextView.delegate = self;
	
	[cell addSubview:adTextView];
	
	[adTextView release];
}

-(void) addTextFieldToCell:(UITableViewCell *)cell 
		  withKeyboardType:(NSString *)keyboardType
				   withTag:(NSInteger)tag
{
	UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 35, 185, 30)];
	playerTextField.tag = tag;
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
	
	//playerTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
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
	
	for (int i = 0; i < [fieldsArray count]; i++) {
		if ([[[fieldsArray objectAtIndex:i] objectForKey:@"tag"] intValue] ==  tag) {
		//	NSLog(@"%@",[fieldsArray objectAtIndex:i]);
			for (id item in postArray) {
				if ([[item objectForKey:@"name"] isEqualToString:[[fieldsArray objectAtIndex:i] objectForKey:@"name"]]) {
					playerTextField.text = [item objectForKey:@"value"];
				}
			}
		}
	}
	
	[cell addSubview:playerTextField];
	
	[playerTextField release];
}

-(void) prepareFieldsArray
{
	NSMutableDictionary *tempField = [[NSMutableDictionary alloc] init], *tempValueItem = [[NSMutableDictionary alloc] init];
	NSMutableArray *tempValueArray = [[NSMutableArray alloc] init];

	[fieldsArray removeAllObjects];
		
	[tempField setObject:@"Advertiser type" forKey:@"title"];
	[tempField setObject:@"advertiser_type" forKey:@"name"];
	[tempField setObject:@"radio" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	
	[tempValueItem setObject:@"Personal" forKey:@"name"];
	[tempValueItem setObject:@"1" forKey:@"value"];
	[tempValueArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempValueItem] ];
	[tempValueItem removeAllObjects];	
	[tempValueItem setObject:@"Company" forKey:@"name"];
	[tempValueItem setObject:@"2" forKey:@"value"];
	[tempValueArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempValueItem]];
	[tempValueItem removeAllObjects];
	
	[tempField setObject:[[tempValueArray copy] autorelease] forKey:@"value"];
	[tempValueArray removeAllObjects];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Advertiser name" forKey:@"title"];
	[tempField setObject:@"advertiser_name" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"60" forKey:@"tag"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"e-mail" forKey:@"title"];
	[tempField setObject:@"email" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"62" forKey:@"tag"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"email" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Phone number" forKey:@"title"];
	[tempField setObject:@"phone" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"65" forKey:@"tag"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"phone" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Subcategory" forKey:@"title"];
	[tempField setObject:@"subcategory_id" forKey:@"name"];
	[tempField setObject:@"select" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	if ([subcategory.extraFormsArray count] > 0) {		
		//create values Array	
		for (int i = 0;i < [subcategory.extraFormsArray count]; i++) {
			[tempField setObject:[[subcategory.extraFormsArray objectAtIndex:i] objectForKey:@"name"] forKey:@"title"];
			[tempField setObject:[[subcategory.extraFormsArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
			
			[tempField setObject:[[subcategory.extraFormsArray objectAtIndex:i] 
								  objectForKey:@"type"] forKey:@"type"];
			[tempField setObject:[[subcategory.extraFormsArray objectAtIndex:i] objectForKey:@"data"] 
						  forKey:@"value"];			
			[tempField setObject:@"" forKey:@"post_value"];
			[tempField setObject:@"text" forKey:@"text_type"];
			[tempField setObject:@"YES" forKey:@"enbled"];
			if ([[[subcategory.extraFormsArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"text"]) {
				[tempField setObject:@"75" forKey:@"height"];
			}
			else {
				[tempField setObject:@"40" forKey:@"height"];
			}
			NSInteger tagNumber = 70 + i;
			[tempField setObject:[NSString stringWithFormat:@"%d", tagNumber] forKey:@"tag"];

			
			[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
			[tempField removeAllObjects];			
		}
	}
	
	[tempField setObject:@"Ad type" forKey:@"title"];
	[tempField setObject:@"ad_type" forKey:@"name"];
	[tempField setObject:@"radio" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"YES" forKey:@"enbled"];

	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];	
	[tempField removeAllObjects];
	
	[tempField setObject:@"Postal code" forKey:@"title"];
	[tempField setObject:@"post_code" forKey:@"name"];
	[tempField setObject:@"postal" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Title" forKey:@"title"];
	[tempField setObject:@"title" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"67" forKey:@"tag"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Body" forKey:@"title"];
	[tempField setObject:@"body" forKey:@"name"];
	[tempField setObject:@"textView" forKey:@"type"];
	[tempField setObject:@"150" forKey:@"height"];
	
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
/*	
	[tempField setObject:@"Price" forKey:@"title"];
	[tempField setObject:@"price" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"YES" forKey:@"enbled"]
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
*/	
	[tempField setObject:@"Past Your ads images" forKey:@"title"];
	[tempField setObject:@"file_upload_input" forKey:@"name"];
	[tempField setObject:@"image" forKey:@"type"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
		
	[tempField setObject:@"Post this Ad" forKey:@"title"];
	[tempField setObject:@"sendButton" forKey:@"name"];
	[tempField setObject:@"sendButton" forKey:@"type"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"YES" forKey:@"enbled"];
	[fieldsArray addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	
	[tempValueItem release];
	[tempValueArray release];
	[tempField release];
	
	
	[tableView reloadData];
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

	for (int i = 0; i < [fieldsArray count]; i++) {		
		if ( [[[fieldsArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"text"] )
		{			
			if ([[[fieldsArray objectAtIndex:i] objectForKey:@"tag"] intValue] == textField.tag) {
				[self addPostString:textField.text 
							 forKey:[[fieldsArray objectAtIndex:i] objectForKey:@"name"]];
				[[fieldsArray objectAtIndex:i] setObject:[NSString stringWithString:textField.text] forKey:@"post_value"];
			}
		}
	}	
	return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
		
		for (int i = 0; i < [fieldsArray count]; i++) {		
			if ( [[[fieldsArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"textView"] )
			{			
				[self addPostString:textView.text 
							 forKey:[[fieldsArray objectAtIndex:i] objectForKey:@"name"]];
			}
			
			
		}
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

-(void) fillFieldsWithData
{

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[tableView scrollRectToVisible:CGRectMake(0, 600, 320, 75) animated:YES];

	return YES;
}
#pragma mark -
-(void) shouldChangePostData:(Boolean)change 
			  atIndexPostion:(NSInteger)indexAtPostArray 
					 forType:(NSString *)type
					  forKey:(NSString *)key
{
	shouldChangePostItem = change;
	changingIndexAtPostArray = indexAtPostArray;
	changingValueType =type ;
	changingValueKey = key ;
}

-(void) didUploadPostArray
{
	NSString *resultValue = [NSString stringWithFormat:@""];
	if (shouldChangePostItem) {

		if ( [changingValueKey isEqualToString:@"subcategory_id"]) {
			[self addPostString:subcategory.resultValue forKey:@"subcategory_id"];
			resultValue = subcategory.resultValue;
			subcategory.resultValue = @"";
		}
		else if ([changingValueKey isEqualToString:@"post_code"])
		{
			//[self addPostArray:locationForm.resultArray];
			[self addPostString:locationForm.resultPostCode forKey:changingValueKey];
			[self addPostString:locationForm.resultRegionId forKey:@"region_id"];
			[self addPostString:locationForm.resultCityId forKey:@"city_id"];
		}
		else if ([changingValueKey isEqualToString:@"file_upload_input"]) {
			[self addPostArray:imagePostingView.imagesArray];
		}

		else if ([changingValueType isEqualToString:@"radio"]) {
			[self addPostString:addPostDataView.resultValue forKey:changingValueKey];
			resultValue = addPostDataView.resultValue;
			addPostDataView.resultValue = @"";
			}
		else if ( [changingValueType isEqualToString:@"select"])
			{
				[self addPostString:addPostDataSelectView.resultValue forKey:changingValueKey];
				resultValue = addPostDataSelectView.resultValue;
				addPostDataSelectView.resultValue = @"";
				}
		NSLog(@"_________________________________________");

		[[fieldsArray objectAtIndex:changingIndexAtPostArray] setObject:resultValue
																 forKey:changingValueKey];

		shouldChangePostItem = NO;
		changingIndexAtPostArray = -1;
		changingValueType = @"no_type";
		changingValueKey = @"no_key";

	}
 }
#pragma mark -
-(void) addPostString:(NSString *)postString forKey:(NSString *)postKey
{
	Boolean containsPostItem = NO;
	if ([postArray count] > 0) {
		for (int i = 0; i<[postArray count]; i++) {
			if ([[[postArray objectAtIndex:i] objectForKey:@"name"] isEqualToString:postKey]) {
				containsPostItem = YES;			
				[[postArray objectAtIndex:i] setObject:postString forKey:@"value"];
			}
		}
		if (!containsPostItem) {
			NSMutableArray *keys = [NSArray arrayWithObjects:@"name", @"value", nil];
			NSMutableArray *values = [NSArray arrayWithObjects:postKey, postString, nil];			
			[postArray addObject:[NSMutableDictionary dictionaryWithObjects:values 
															 forKeys:keys]];
			
		}
	}
	else
	{
		NSMutableArray *keys = [NSArray arrayWithObjects:@"name", @"value", nil];
		NSMutableArray *values = [NSArray arrayWithObjects:postKey, postString, nil];			
		[postArray addObject:[NSMutableDictionary dictionaryWithObjects:values 
														 forKeys:keys]];
	}
//	NSLog(@"postArray: %@", postArray);
}

-(void) addPostArray:(NSArray *)postItemArray
{
	NSLog(@"images Array: %@", postItemArray);
}
#pragma mark -
#pragma mark standart Form methods

-(void)viewWillDisappear:(BOOL)animated
{
	appDelegate.needToRefresh = NO;
}

- (void)viewWillAppear:(BOOL)animated
{	
	[self prepareFieldsArray];
	if (![subcategory.currentCatId isEqual:@"-1"]) {
		activeCatId = subcategory.currentCatId;
	}
	[self didUploadPostArray];
//	[self fillFieldsWithData];
	[tableView reloadData];

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
	//[changingValueType release];
	//[changingValueKey release];
	
	[activeCatId release];
	[fieldsArray release];
	[pickerViewValues release];
	[tableView release];
	//[appDelegate release];
	[advertiserTypeForm release];
	[subcategory release];
	[addPostDataView release];
	[addPostDataSelectView release];
	[extraParametres release];
	[imagePostingView release];
	[locationForm release];
    [super dealloc];
}


@end
