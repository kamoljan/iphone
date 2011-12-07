//
//  IyoiyoAPI.m
//  IyoIyoApp
//
//  Created by yuriy on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IyoiyoAPI.h"
#import "JSON.h"


@implementation IyoiyoAPI

-(NSArray *) loadStringByURLstring:(NSString *)urlString
{
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	NSData *urlData = [NSData dataWithContentsOfURL:url];
	NSString *urlDataString = [[NSString alloc] initWithData:urlData 
														  encoding:NSUTF8StringEncoding];
	NSArray *resultArray = [urlDataString JSONValue];
	
	[urlDataString release];
	[url release];
	
	return resultArray;
}

-(NSDictionary *) loadDictionaryByURLString:(NSString *) urlString{
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	NSData *urlData = [NSData dataWithContentsOfURL:url];
	NSString *urlDataString = [[NSString alloc] initWithData:urlData 
													encoding:NSUTF8StringEncoding];
	NSDictionary *resultDict = [urlDataString JSONValue];
	
	[urlDataString release];
	[url release];
	
	return resultDict;
}

-(UIImage *) loadImageByURLString:(NSString *)urlString
{	
	if (![urlString isKindOfClass:[NSNull class]] ) {
		NSURL *URL = [NSURL URLWithString:urlString];		
		NSData *imageData = [NSData dataWithContentsOfURL:URL];	
		if ( imageData ){
			return [UIImage imageWithData:imageData];
		}	
		return NULL;
	}
	return NULL;
}

-(NSArray *) loadCurrentMapItemsByPostCode:(NSString *)postCode
{
	return [self loadStringByURLstring:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/postcodes/%@",postCode]];
}

-(NSArray *) loadRegions
{		
	return [self loadStringByURLstring:@"http://www.iyoiyo.jp/ajax/regions"];
}
-(NSArray *) loadCitiesByRegionId:(NSString *)regionId
{
	return [self loadStringByURLstring:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/cities/%@",regionId]];
}
-(NSArray *) loadCategoryTree
{
	return [self loadStringByURLstring:@"http://www.iyoiyo.jp/ajax/category_tree"];
}
-(NSArray *) loadExtraFormsByCategoryId:(NSString *)categoryId
{
	return [self loadStringByURLstring:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/extra_forms/%@", categoryId]];
}
-(NSArray *) loadAdTypesByCategoryId:(NSString *)categoryId
{
	return [self loadStringByURLstring:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/adtypes/%@",categoryId]];
}
-(NSArray *) loadCityAndPrefectureByPostCode:(NSString *)postcode
{
	return [self loadStringByURLstring:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ajax/postcodes/%@",postcode]];
}
-(NSDictionary *) searchWithFilter:(NSArray *)filter{
	/*
	   'key'   = '';
	   'value' = '';
	*/
	NSString *tempStr = @"";
	for (id item in filter) {
//		tempStr = [NSString stringWithFormat:@"%@=%@&"];
		tempStr = [tempStr stringByAppendingFormat:@"%@=%@&",[item objectForKey:@"key"],[item objectForKey:@"value"]];
	}
	if (filter == nil) {		
		return [self loadDictionaryByURLString:@"http://www.iyoiyo.jp/ios/search?start=0&limit=9"];
	}
	return [self loadDictionaryByURLString:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ios/search?%@limit=8",tempStr]];
}

#pragma mark -
-(NSDictionary *) loadAdById:(NSString *)adId{
	return [self loadStringByURLstring:[NSString stringWithFormat:@"http://www.iyoiyo.jp/ios/ad/%@",adId]];
}
@end
