//
//  imageLoadingQueue.h
//  IyoIyoApp
//
//  Created by yuriy on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface imageLoadingQueue : NSObject {
	NSOperationQueue *backgroundThread;
	NSMutableArray *queueItems;
	UITableView *tbView;	
}

@property (nonatomic,assign) UITableView *tbView;
-(void)changeObjectImage:(NSDictionary *)objectInfo;
-(void) loadImage:(NSDictionary *)objectInfo;
-(void) startImageLoadingThreadForObject:(id)object withURLString:(NSString *)urlString;
-(void) stopImageLoadingThreadForObject:(id)object;
-(void) stopAllImageLoadingThreads;


@end
