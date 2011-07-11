//
//  LocationForm.h
//  navBased
//
//  Created by yuriy on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPostDataSelectView.h"


@interface LocationForm : UIViewController 
<UITextFieldDelegate>
{
	IBOutlet UILabel *regionLabel;
	IBOutlet UILabel *cityLabel;
	IBOutlet UITextField *postalTextField;
	NSMutableArray *currentRegionArray;
	NSMutableArray *regionsArray, *citiesArray;
	NSString *resultPostCode;
	NSString *resultRegionId;
	NSString *resultCityId;
	AddPostDataSelectView *selectRegion;
	AddPostDataSelectView *selectCity;
}

@property (nonatomic, retain) NSString *resultPostCode;
@property (nonatomic, retain) NSString *resultRegionId;
@property (nonatomic, retain) NSString *resultCityId;

-(IBAction) chooseAnotherRegionForm;
-(IBAction) chooseAnotherCityForm;
-(NSMutableArray *) getArrayByURL:(NSString *) URLString;

@end
