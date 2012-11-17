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

-(UIImage *) loadImageByURLString:(NSString *)urlString
{	
	NSURL *URL = [NSURL URLWithString:urlString];		
	NSData *imageData = [NSData dataWithContentsOfURL:URL];	

	if ( imageData ){
		return [UIImage imageWithData:imageData];
	}	
	return nil;
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

@end
