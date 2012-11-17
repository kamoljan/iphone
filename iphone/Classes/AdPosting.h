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
	NSString *SwIHidePhone, *currentPrefectureId, *currentCityId;
	
	NSMutableArray *postFields, *images;
	NSArray *dynamicCategoriesArray;
	NSInteger currentAdType;
	Boolean hasDynamicCategories;
}

@property (nonatomic, readonly) NSMutableArray *postFields;
@property (nonatomic, retain) NSMutableArray *SIAdvType;
@property (nonatomic, retain) NSMutableArray *SICategories;
@property (nonatomic, retain) NSMutableArray *SIPrefectures;
@property (nonatomic, retain) NSMutableArray *SICities;
@property (nonatomic, retain) NSMutableArray *SIAdTypes;
@property (nonatomic, retain) NSMutableArray *DSIArray;
@property (nonatomic, retain) NSString *SwIHidePhone;
@property (nonatomic, retain) NSString *currentPrefectureId;
@property (nonatomic, retain) NSString *currentCityId;

-(Boolean) sendNewAdForPosting;
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
-(void) setDynamicFieldsForCategoryWithId:(NSInteger)categoryId;
-(void) setAdTypesForCategoyWithId:(NSInteger)categoryId;

-(void) chooseAdTypeById:(NSString *)adTypeId;

//This method is used to add values from view
-(void) changePostItemWithKey:(NSInteger)itemKey withValue:(NSString *)itemValue;
-(void) reloadFields;
-(NSString *) getPostItemWithKey:(NSString *)key forKey:(NSString *) keyForValue;
-(Boolean) insertValue:(NSString *)value forPostItemWithKey:(NSString *)key;

//Method for adding images
-(void) addImage:(UIImage *)adImage;

@end
