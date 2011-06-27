//
//  AdType.h
//  navBased
//
//  Created by yuriy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AdvertiserType : UIViewController {
	NSString *advertiserTypeValue; 
}

@property (nonatomic, retain) NSString *advertiserTypeValue;
-(IBAction) choosedPersonal;
-(IBAction) choosedCompany;
@end
