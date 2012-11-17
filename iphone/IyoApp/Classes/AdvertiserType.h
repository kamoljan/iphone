//
//  AdvertiserType.h
//  IyoApp
//
//  Created by yuriy on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IyoAppAppDelegate.h"

@interface AdvertiserType : UIViewController {
	IyoAppAppDelegate *appDelegate;
	int postItemNumber;
	UILabel *viewLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *viewLabel;

-(void) setPostFieldNumber:(int)number;
-(IBAction) choosedPersonal;
-(IBAction) choosedCompany;
@end
