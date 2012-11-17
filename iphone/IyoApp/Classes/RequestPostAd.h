//
//  RequestPostAd.h
//  AdPosting
//
//  Created by yuriy on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestPostAd : NSObject {
//	NSData *imageData;
	NSURL *urlToRequest;
}

@property (nonatomic, retain) NSURL *urlToRequest;

//uses for sending images to server
-(NSDictionary *) addImage:(UIImage *)image;

//uses for sending ad 
-(NSDictionary *) postAdWithArray:(NSArray *)postArray toURLString:(NSString *)urlString;
@end
