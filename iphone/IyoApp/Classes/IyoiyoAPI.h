//
//  IyoiyoAPI.h
//  IyoIyoApp
//
//  Created by yuriy on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IyoiyoAPI : NSObject {

}

-(NSArray *) loadStringByURLstring:(NSString *)urlString;
-(NSDictionary *) loadDictionaryByURLString:(NSString *) urlString;
-(UIImage *) loadImageByURLString:(NSString *)urlString;
-(NSArray *) loadCurrentMapItemsByPostCode:(NSString *)postCode;
-(NSArray *) loadRegions;
-(NSArray *) loadCitiesByRegionId:(NSString *)regionId;
-(NSArray *) loadCategoryTree;
-(NSArray *) loadExtraFormsByCategoryId:(NSString *)categoryId;
-(NSArray *) loadAdTypesByCategoryId:(NSString *)categoryId;
-(NSArray *) loadCityAndPrefectureByPostCode:(NSString *)postcode;

-(NSDictionary *) searchWithFilter:(NSArray *)filter;
-(NSDictionary *) loadAdById:(NSString *)adId;
@end
