//
//  imageLoadingQueue.m
//  IyoIyoApp
//
//  Created by yuriy on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "imageLoadingQueue.h"
#import "IyoiyoAPI.h"


@implementation imageLoadingQueue
@synthesize tbView;


-(id)init
{
	/*
	self = [super init];
    if (self) {
        // Custom initialization
		//NSAutoreleasePool *imageLoadingPool = [[NSAutoreleasePool alloc] init];
		
		//[imageLoadingPool release];
		
		//
    }
	 */
	
	NSAutoreleasePool *imageLoadingPool = [[NSAutoreleasePool alloc] init];
	backgroundThread = [NSOperationQueue new];
	[backgroundThread setMaxConcurrentOperationCount:10];
	queueItems = [[NSMutableArray alloc] init];
	[imageLoadingPool release];
    return self;

}


-(void) startImageLoadingThreadForObject:(id)object withURLString:(NSString *)urlString
{	
	//Adding items to queues array
	NSNumber *index=[NSNumber numberWithInt:[queueItems count]];
		
	NSDictionary *queueItem = [NSDictionary	dictionaryWithObjects:[NSArray arrayWithObjects:object, index, nil]
														  forKeys:[NSArray arrayWithObjects:@"object", @"index", nil]];
	
	UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityView.frame = CGRectMake(0, 0, 30, 30);
	activityView.hidesWhenStopped = YES;
	[activityView startAnimating];
	[object setImage:nil];
	[object addSubview:activityView];
	[activityView release];
	
	[queueItems addObject:queueItem];
		
	//Start loading image in background thread
	NSDictionary *objectInfo = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:object, urlString, nil] 
														   forKeys:[NSArray arrayWithObjects:@"object", @"imageURLString", nil]];
	
	NSInvocationOperation *loadingOperation = [[NSInvocationOperation alloc]
											   initWithTarget:self
													 selector:@selector(loadImage:)
													   object:objectInfo];	

	[backgroundThread addOperation:loadingOperation];	
	[loadingOperation release];	
	 
}

-(void) loadImage:(NSDictionary *)objectInfo
{
	IyoiyoAPI *iyoAPI = [[IyoiyoAPI alloc] init];
	UIImage *image;
	if (![[objectInfo objectForKey:@"imageURLString"] isKindOfClass:[NSNull class]]) {					
		image = [iyoAPI loadImageByURLString:[objectInfo objectForKey:@"imageURLString"]];
	}
	else {
		image = [UIImage imageNamed:@"empty.PNG"];
	}
	if ( (image == nil) || (image == NULL)) {
		image = [UIImage imageNamed:@"empty.PNG"];
	}
	
	NSMutableDictionary *imageInfo = [NSMutableDictionary dictionaryWithDictionary:objectInfo];
	[imageInfo setObject:image forKey:@"image"];	
		
	[self performSelectorOnMainThread:@selector(changeObjectImage:) withObject:imageInfo 
						waitUntilDone:NO];	
	[iyoAPI release];
}

-(void)changeObjectImage:(NSDictionary *)objectInfo
{
	for (int i = 0 ; i < [queueItems count]; i++) {
		id obj = [[queueItems objectAtIndex:i] objectForKey:@"object"];
		id currObj = [objectInfo objectForKey:@"object"];		
		if (&obj == &currObj) {
			[queueItems removeObjectAtIndex:i];
		}		
	}
	//[objectInfo setValue:[objectInfo objectForKey:@"image"] forKey:@"Object"];
	for (UIView *item in [[objectInfo objectForKey:@"object"] subviews]) {
		[item removeFromSuperview];
	}	
	[[objectInfo objectForKey:@"object"] setImage:[objectInfo objectForKey:@"image"]];
	if ([tbView retainCount] > 1) {
		[tbView reloadData];
	}
	
}

-(void) stopImageLoadingThreadForObject:(id)object
{	
	for ( int i = 0; i < [queueItems count]; i++) {
		id obj = [[queueItems objectAtIndex:i] objectForKey:@"object"];		
		if (obj == object) {
			[queueItems removeObjectAtIndex:i];
			[[[backgroundThread operations] objectAtIndex:i] cancel];								
		}
	};
}

-(void) stopAllImageLoadingThreads
{
	[backgroundThread cancelAllOperations];
	[queueItems removeAllObjects];		
}

-(void)dealloc{	
	[backgroundThread release];
	[super dealloc];	
}
@end
