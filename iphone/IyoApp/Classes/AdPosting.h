//
//  AddPosting.h
//  IyoIyoApp
//
//  Created by yuriy on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AdPosting : NSObject {
	
	//data arrays which will choosed by interface(by tableview and pickerview)
	// SI Selectable Item, SwI Switchable Item, DSI Dynamic Selectable Items
	NSMutableArray *SIAdvType, *SIAdTypes, *DSIArray, *SICategories, *SIPrefectures, *SICities;
	NSString *SwIHidePhone, *currentPrefectureId, *currentCityId, *currentCity, *currentCat;
	NSString *currentCatId;
	NSMutableArray *postFields, *postValues, *images;
	NSArray *dynamicCategoriesArray;
	NSString *currentAdType;
	Boolean hasDynamicCategories;
}

@property (nonatomic, readonly) NSMutableArray *postFields;
@property (nonatomic, readonly) NSMutableArray *postValues;
@property (nonatomic, retain) NSMutableArray *SIAdvType;
@property (nonatomic, retain) NSMutableArray *SICategories;
@property (nonatomic, retain) NSMutableArray *SIPrefectures;
@property (nonatomic, retain) NSMutableArray *SICities;
@property (nonatomic, retain) NSMutableArray *SIAdTypes;
@property (nonatomic, retain) NSMutableArray *DSIArray;
@property (nonatomic, retain) NSString *SwIHidePhone;
@property (nonatomic, retain) NSString *currentPrefectureId;
@property (nonatomic, retain) NSString *currentPrefecture;
@property (nonatomic, retain) NSString *currentCityId;
@property (nonatomic, retain) NSString *currentCity;
@property (nonatomic, retain) NSString *currentCatId;
@property (nonatomic, retain) NSString *currentAdType;
@property (nonatomic, retain) NSMutableArray *images;

-(NSDictionary *) sendNewAdForPosting;
-(Boolean) checkPostFields;
//methods for initializing selectable items
-(void) initCategories;
-(void) initAdvType;
-(void) initPrefectures;
-(void) loadCitiesByPrefectureId:(NSString *)prefectureId;
//set default two Ad Type values
-(void)initAdTypes;


-(void) categoryWasChoosed;
-(void) chooseMapItemsByPostCode:(NSString *)postCode;
-(void) emptyFields;
-(void) setDynamicFieldsForCategoryWithId:(NSString *)categoryId;
-(void) setAdTypesForCategoyWithId:(NSString *)categoryId;

-(void) chooseAdTypeById:(NSString *)adTypeId;

-(void) reloadFields;
-(NSString *) getPostItemWithKey:(NSString *)key forKey:(NSString *) keyForValue;
-(void) insertValue:(NSString *)postValue labelValue:(NSString *)labelValue forPostItemWithKey:(NSString *)key;
-(NSString *) postValueItemWithKey:(NSString *)key;
-(NSString *) postValueWithKey:(NSString *)key;
-(void) insertImagesToPost;

//Method for adding images
-(void) addImage:(UIImage *)adImage;

//used for get count of NOT hided post items
-(NSInteger) getPostItemsCount;

@end
