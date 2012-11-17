//
//  ClickableImage.h
//  IyoApp
//
//  Created by yuriy on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BigImageView.h"

@interface ClickableImage : UIImageView {
	NSString *imagePath;
	IBOutlet BigImageView *vc;
	UINavigationController *navigationController;
}

-(id) init;
-(id) initWithFrame:(CGRect)frame;
-(void) setSourceURLString:(NSString *)sourceURLString;
@end
