//
//  AddPosting.m
//  IyoIyoApp
//
//  Created by yuriy on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdPosting.h"
#import "IyoiyoAPI.h"
#import "RequestPostAd.h"


@implementation AdPosting

@synthesize postFields, SIAdvType, SICategories, SIAdTypes, DSIArray, SwIHidePhone, SIPrefectures, SICities,
			currentPrefectureId, currentCityId;

-(id)init
{
	SIAdvType = [[NSMutableArray alloc] init];
	SIAdTypes = [[NSMutableArray alloc] init];
	DSIArray = [[NSMutableArray alloc] init]; 
	SwIHidePhone = [[NSMutableArray alloc] init];
	SICategories = [[NSMutableArray alloc] init];
	SIPrefectures = [[NSMutableArray alloc] init];
	SICities = [[NSMutableArray alloc] init];
	currentPrefectureId = [[NSString alloc] init];
	currentCityId = [[NSString alloc] init];
	//Initialize Advertiser type
	[self initAdvType];
	//Initialize Categories list
	[self initCategories];	
	//Initialize(set default values) Ad Types
	[self initAdTypes];

	//hide or show phone number in ad
	
	postFields = [[NSMutableArray alloc] init];
	//images info(thumb, fid, name) that loaded to server
	images = [[NSMutableArray alloc] init];
	dynamicCategoriesArray = [[NSArray alloc] init];
	hasDynamicCategories = NO;
	[self reloadFields];
	
	return self;
}

#pragma mark -

-(void) initCategories
{
	IyoiyoAPI *iyo = [[IyoiyoAPI alloc] init];
	NSArray *tempCategories = [iyo loadCategoryTree] ;	
	NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
	NSArray *subCat;
	for (int i = 0; i < [tempCategories count]; i++) {		
		[tempDic setObject:[[tempCategories objectAtIndex:i] objectForKey:@"name"] 
					 forKey:@"catName"];
		[tempDic setObject:[[tempCategories objectAtIndex:i] objectForKey:@"id"] 
					 forKey:@"catId"];
		
		[self.SICategories addObject:[NSDictionary dictionaryWithDictionary:tempDic ]];				
		for (int j = 0; j < [[[tempCategories objectAtIndex:i] objectForKey:@"subcategories"] count]; j++) {
			subCat = [[tempCategories objectAtIndex:i] objectForKey:@"subcategories"];
			//[subcategories addObject:subCatName];
			[tempDic setObject:[[subCat objectAtIndex:j] objectForKey:@"name"] 
						 forKey:@"catName"];
			[tempDic setObject:[[subCat objectAtIndex:j] objectForKey:@"id"] 
						 forKey:@"catId"];
			[self.SICategories addObject:[NSDictionary dictionaryWithDictionary:tempDic] ];
		}
	}
	[tempDic release];	
	
	[iyo release];
}

-(void) initAdvType
{
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
	[tempDict setValue:@"Personal" forKey:@"name"];
	[tempDict setValue:@"1" forKey:@"value"];
	[self.SIAdvType addObject:[NSDictionary dictionaryWithDictionary:tempDict]];
	[tempDict setValue:@"Company" forKey:@"name"];
	[tempDict setValue:@"2" forKey:@"value"];
	[self.SIAdvType addObject:[NSDictionary dictionaryWithDictionary:tempDict]];
	[tempDict release];
}

-(void) initPrefectures
{
	IyoiyoAPI *iyo = [[IyoiyoAPI alloc] init];
	self.SIPrefectures = [[iyo loadRegions] copy];
	[iyo release];
}

-(void) loadCitiesByPrefectureId:(NSString *)prefectureId
{
	IyoiyoAPI *iyo = [[IyoiyoAPI alloc] init];
	self.SIPrefectures = [[iyo loadCitiesByRegionId:prefectureId] copy];
	[iyo release];
}

-(void) initAdTypes
{
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
	[tempDict setValue:@"Sell" forKey:@"name"];
	[tempDict setValue:@"1" forKey:@"value"];
	[self.SIAdTypes addObject:[NSDictionary dictionaryWithDictionary:tempDict]];
	[tempDict setValue:@"I`m looking for" forKey:@"name"];
	[tempDict setValue:@"2" forKey:@"value"];
	[self.SIAdTypes addObject:[NSDictionary dictionaryWithDictionary:tempDict]];
	[tempDict release];
}

-(Boolean) sendNewAdForPosting
{
	if ([self checkPostFields] )
	{
		NSLog(@"YES");
		RequestPostAd *request = [[RequestPostAd alloc] init];
		[request postAdWithArray:self.postFields imagesArray:nil toURLString:@"http://www.iyoiyo.jp/ios/post"];
		[request release];
		return YES;
	}	
	NSLog(@" sendNewAdForPosting: fields not ready");
	return NO;	
}

-(Boolean)checkPostFields
{
	for (id postItem in self.postFields) {
		if ([postItem objectForKey:@"required"]) {			
			if ([[postItem objectForKey:@"post_value"] isEqualToString:@""]) {
				return NO;
			}
		}
	}
	return YES;	
}

-(void) categoryWasChoosed
{
	
}

-(void) chooseMapItemsByPostCode:(NSString *)postCode
{
	IyoiyoAPI *iyo = [[IyoiyoAPI alloc] init];
	NSDictionary *tempDic = [[iyo loadCurrentMapItemsByPostCode:postCode] objectAtIndex:0] ;
	self.currentPrefectureId = [tempDic objectForKey:@"prefecture_id"];
	self.currentCityId = [tempDic objectForKey:@"city_id"];

	[iyo release];
}

-(void) emptyFields
{
	dynamicCategoriesArray = nil;
	hasDynamicCategories = NO;
}

-(void) setDynamicFieldsForCategoryWithId:(NSInteger)categoryId
{
	IyoiyoAPI *iyoiyo = [[IyoiyoAPI alloc] init];
	dynamicCategoriesArray = [[iyoiyo loadExtraFormsByCategoryId:[NSString stringWithFormat:@"%i",categoryId]] copy];
	hasDynamicCategories = YES;	
	[self setAdTypesForCategoyWithId:categoryId];
	[iyoiyo release];
}


-(void) setAdTypesForCategoyWithId:(NSInteger)categoryId
{
	IyoiyoAPI *iyoiyo = [[IyoiyoAPI alloc] init];		
	[iyoiyo release];	
}

-(void) chooseAdTypeById:(NSString *)adTypeId
{
	currentAdType = [adTypeId intValue];	
}

-(void) changePostItemWithKey:(NSInteger)itemKey 
				   withValue:(NSString *)itemValue					
{
	
}


-(void) reloadFields
{
	NSMutableDictionary *tempField = [[NSMutableDictionary alloc] init], *tempValueItem = [[NSMutableDictionary alloc] init];
	NSMutableArray *tempValueArray = [[NSMutableArray alloc] init];
	
	[postFields removeAllObjects];
	
	[tempField setObject:@"Advertiser type *" forKey:@"title"];
	[tempField setObject:@"advertiser_type" forKey:@"name"];
	[tempField setObject:@"radio" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];	
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Advertiser name *" forKey:@"title"];
	[tempField setObject:@"advertiser_name" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"60" forKey:@"tag"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"e-mail  *" forKey:@"title"];
	[tempField setObject:@"email" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"62" forKey:@"tag"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"email" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Phone number *" forKey:@"title"];
	[tempField setObject:@"phone" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"65" forKey:@"tag"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"phone" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Subcategory *" forKey:@"title"];
	[tempField setObject:@"subcategory_id" forKey:@"name"];
	[tempField setObject:@"select" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Ad type *" forKey:@"title"];
	[tempField setObject:@"ad_type" forKey:@"name"];
	[tempField setObject:@"radio" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];	
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];	
	[tempField removeAllObjects];
	
	if (hasDynamicCategories) {
		//create values Array	
		NSArray	*availableExtraFormArray;
		for (int i = 0;i < [dynamicCategoriesArray count]; i++) {
			[tempField setObject:[[dynamicCategoriesArray objectAtIndex:i] objectForKey:@"name"] forKey:@"title"];
			[tempField setObject:[[dynamicCategoriesArray objectAtIndex:i] objectForKey:@"name"] forKey:@"name"];
			[tempField setObject:[[dynamicCategoriesArray objectAtIndex:i] objectForKey:@"type"] forKey:@"type"];
			[tempField setObject:[[dynamicCategoriesArray objectAtIndex:i] objectForKey:@"data"] forKey:@"value"];
			[tempField setObject:@"" forKey:@"post_value"];
			[tempField setObject:@"text" forKey:@"text_type"];
			[tempField setObject:@"NO" forKey:@"enabled"];
			[tempField setObject:@"NO" forKey:@"secondary_item"];
			if ([[[dynamicCategoriesArray objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"text"]) {
				[tempField setObject:@"75" forKey:@"height"];
			}
			else {
				[tempField setObject:@"40" forKey:@"height"];
			}
			NSInteger tagNumber = 70 + i;
			[tempField setObject:[NSString stringWithFormat:@"%d", tagNumber] forKey:@"tag"];
			
			//check extra forms for availability in ad_types aray of subcategory
			availableExtraFormArray = [[dynamicCategoriesArray objectAtIndex:i] objectForKey:@"ad_types"];				
			for (int i = 0; i < [availableExtraFormArray count]; i++) {
				if (currentAdType == [[availableExtraFormArray objectAtIndex:i] intValue]) {
					[tempField setObject:@"YES" forKey:@"enabled"];
				}
				
			}
		
			[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
			[tempField removeAllObjects];			
		}
	}
	
	[tempField setObject:@"Postal code *" forKey:@"title"];
	[tempField setObject:@"post_code" forKey:@"name"];
	[tempField setObject:@"postal" forKey:@"type"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Hide address map" forKey:@"title"];
	[tempField setObject:@"hide_map" forKey:@"name"];
	[tempField setObject:@"checkbox" forKey:@"type"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"YES" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	
	
	[tempField setObject:@"Prefecture *" forKey:@"title"];
	[tempField setObject:@"region_id" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"City *" forKey:@"title"];
	[tempField setObject:@"city_id" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Title *" forKey:@"title"];
	[tempField setObject:@"title" forKey:@"name"];
	[tempField setObject:@"text" forKey:@"type"];
	[tempField setObject:@"75" forKey:@"height"];
	[tempField setObject:@"67" forKey:@"tag"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Body *" forKey:@"title"];
	[tempField setObject:@"body" forKey:@"name"];
	[tempField setObject:@"textView" forKey:@"type"];
	[tempField setObject:@"150" forKey:@"height"];
	[tempField setObject:@"90" forKey:@"tag"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"text" forKey:@"text_type"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"YES" forKey:@"required"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Past Your ads images" forKey:@"title"];
	[tempField setObject:@"file_upload_input" forKey:@"name"];
	[tempField setObject:@"image" forKey:@"type"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];
	
	[tempField setObject:@"Post this Ad" forKey:@"title"];
	[tempField setObject:@"sendButton" forKey:@"name"];
	[tempField setObject:@"sendButton" forKey:@"type"];
	[tempField setObject:@"" forKey:@"post_value"];
	[tempField setObject:@"40" forKey:@"height"];
	[tempField setObject:@"YES" forKey:@"enabled"];
	[tempField setObject:@"NO" forKey:@"secondary_item"];
	[postFields addObject:[NSMutableDictionary dictionaryWithDictionary:tempField] ];
	[tempField removeAllObjects];	
	
	[tempValueItem release];
	[tempValueArray release];
	[tempField release];	
}


-(NSString *) getPostItemWithKey:(NSString *)key forKey:(NSString *) keyForValue
{
	for ( id item in postFields) {
		if ([[item objectForKey:@"name"] isEqualToString:key]) {
			return [item objectForKey:keyForValue];
		}
	}
	return nil;
}

-(Boolean) insertValue:(NSString *)value forPostItemWithKey:(NSString *)key
{
	for ( id item in postFields) {
		if ([[item objectForKey:@"name"] isEqualToString:key]) {
			[item setObject:[NSString stringWithString:value] forKey:@"post_value"];
			return YES;
		}
	}
	return NO;
}

-(void) addImage:(UIImage *)adImage
{
	RequestPostAd *request = [[RequestPostAd alloc] init];
	NSDictionary *tempDic = [request addImage:adImage];
	if ([[tempDic objectForKey:@"status"] isEqualToString:@"0"]) {
		[images addObject:[NSDictionary dictionaryWithDictionary:tempDic]];
	}
	else {
		NSLog(@"addImage: error occured while sending image.\n%@",tempDic);
	}

	[request release];
}

- (void)dealloc {
	[SIAdvType release]; 
	[SIAdTypes release];
	[DSIArray release]; 
	[SwIHidePhone release];
	[SICategories release];
	[SIPrefectures release];
	[SICities release];
	[currentPrefectureId release];
	[currentCityId release];
	[postFields release];
	[images release];
	[dynamicCategoriesArray release];	
    [super dealloc];	
}
@end
