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

-(NSDictionary *) doRequest:(NSData *)imageData;


@end
