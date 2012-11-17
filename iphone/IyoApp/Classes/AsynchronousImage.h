//
//  AsynchronousImage.h
//  IyoApp
//
//  Created by yuriy on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AsynchronousImage : NSObject {
	NSURLConnection *imageLoadingConnection;
	UITableView *tableViewToReload;
	UIImageView *imageViewToChange;
	NSMutableData *data;
	UIActivityIndicatorView *activityImage;	
}

- (id)initWithTableViewCell:(UITableViewCell *)cell
		 URLPathToImage:(NSString *)pathToImage;
- (id)initWithImageView:(UIImageView *)imageView 
		 URLPathToImage:(NSString *)URLToImage;
- (void)setActivityIndicatorPositionIx:(CGFloat )IX IY:(CGFloat )Iy IWidth:(CGFloat )IWidth IHeight:(CGFloat )IHeight;
@end
