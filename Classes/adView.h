//
//  adView.h
//  navBased
//
//  Created by yuriy on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "navBasedAppDelegate.h"


@interface adView : UIViewController {
	IBOutlet UIImageView *imageView;
	IBOutlet UILabel	 *adPriceLabel;
	IBOutlet UITextView	 *adBodyTextView;
	navBasedAppDelegate  *appDelegateView;
	NSMutableDictionary  *currentAd;
	NSString			 *adJsonString;
	UIImage				 *adImage;
	NSString			 *adPrice;
	NSString			 *adBody;
	NSOperationQueue *adQueue;
}
@property(nonatomic,retain) IBOutlet UITextView *adBodyTextView;
@property(nonatomic,retain) IBOutlet UILabel *adPriceLabel;
@property(nonatomic,retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) navBasedAppDelegate *appDelegateView;
@property(nonatomic,retain) NSString			*adPrice;
@property(nonatomic,retain) NSMutableDictionary *currentAd;
@property(nonatomic,retain) UIImage				*adImage;
@property(nonatomic,retain) NSString			*adJsonString;
@property(nonatomic,retain) NSString			*adBody;
@property(nonatomic,retain) NSOperationQueue *adQueue;
-(void) requestForAd:(NSString *) adId;
-(void) prepareAd;
-(void) loadAdImage;
-(void) changeImage;
@end
