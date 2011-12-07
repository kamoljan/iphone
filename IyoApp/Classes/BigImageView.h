//
//  BigImageView.h
//  IyoApp
//
//  Created by yuriy on 11/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BigImageView : UIViewController {
	UIImageView *imageView;
}

@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@end
