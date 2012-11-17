//
//  ClickableImage.m
//  IyoApp
//
//  Created by yuriy on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClickableImage.h"
#import "AsynchronousImage.h"
#import "IyoAppAppDelegate.h"

@implementation ClickableImage

-(id) init{
	self = [super init];
    if (self) {
		super.userInteractionEnabled = YES;
	}
	return self;
}

-(id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		super.userInteractionEnabled = YES;
		IyoAppAppDelegate *ad = (IyoAppAppDelegate *)[[UIApplication sharedApplication] delegate];
		navigationController = ad.navigationController;
		vc = [[BigImageView alloc] init];
		
	}
	return self;
}

-(void) setSourceURLString:(NSString *)sourceURLString{
	imagePath = [sourceURLString retain];
}
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event{
	[super touchesEnded:touches withEvent:event];
	CGFloat x = ([UIScreen mainScreen].bounds.size.width )/2 - 30;
	CGFloat y = ([UIScreen mainScreen].bounds.size.height )/2 - 70;	
	[navigationController pushViewController:vc animated:YES];	
	AsynchronousImage *asyncImage = [[AsynchronousImage alloc] initWithImageView:vc.imageView
																  URLPathToImage:imagePath];
	[asyncImage setActivityIndicatorPositionIx:x IY:y IWidth:40 IHeight:40];
	
	[asyncImage autorelease];
	
}

-(void)dealloc{	
	[super dealloc];
}
@end
