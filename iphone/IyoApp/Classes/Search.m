//
//  Search.m
//  IyoApp
//
//  Created by yuriy on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Search.h"
#import "IyoiyoAPI.h"

@implementation Search
@synthesize dataSource, imagesSource;

-(id)init{
	startCount = 0;	
	asyncLoad = [[imageLoadingQueue alloc] init];
	imagesSource = [[NSMutableArray alloc] init];	
	
	return self;
}
-(void) searchWithFilter:(NSArray *)filter{	
	IyoiyoAPI *iyo = [[IyoiyoAPI alloc] init];
	self.dataSource = [[iyo searchWithFilter:filter] objectForKey:@"ads"];
	if ([self.imagesSource count] > 0) {
		[self startLoadingImages];
	}
	[iyo release];	
}
-(void) startLoadingImages{
	for (int i = 0; i < [self.dataSource count]; i++) {
		NSString *imagePath = [[self.dataSource objectAtIndex:i] objectForKey:@"thumb_url"];							
		[asyncLoad startImageLoadingThreadForObject:[imagesSource objectAtIndex:i] withURLString:imagePath];
	}
}

-(void) setTbView:(UITableView *)tableView{	
	asyncLoad.tbView = tableView;
}
-(void) stopLoadingImages{
	[asyncLoad stopAllImageLoadingThreads];	
}
-(void)dealloc{
	[asyncLoad release];
	[imagesSource release];	
	[super dealloc];
}
@end
