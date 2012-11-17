//
//  TextView.h
//  IyoApp
//
//  Created by yuriy on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextView : UIViewController 
<UITextFieldDelegate>
{
	NSString *returnValue;
	NSString *returnValueLabel;
}

@property(nonatomic,retain) NSString *returnValue;
@property(nonatomic,retain) NSString *returnValueLabel;

@end
