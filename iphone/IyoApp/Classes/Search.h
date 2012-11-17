//
//  Search.h
//  IyoApp
//
//  Created by yuriy on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imageLoadingQueue.h"

@interface Search : NSObject {
	NSArray *dataSource;
	NSMutableArray *imagesSource;
	NSInteger startCount;
	imageLoadingQueue *asyncLoad;
	
}

@property (nonatomic, retain) NSArray *dataSource;
@property (nonatomic, retain) NSMutableArray *imagesSource;

-(void) searchWithFilter:(NSArray *)filter;
-(void) startLoadingImages;
-(void) setTbView:(UITableView *)tableView;
-(void) stopLoadingImages;
@end
