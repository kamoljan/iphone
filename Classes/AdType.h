//
//  AdType.h
//  navBased
//
//  Created by yuriy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AdType : UIViewController {
	NSString *adTypeValue;
}

@property (nonatomic, retain) NSString *adTypeValue;

-(IBAction) choosedSell;
-(IBAction) choosedLooking;
-(IBAction) choosedAid;

@end
