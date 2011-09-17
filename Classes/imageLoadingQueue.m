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
	UIImage *image = [iyoAPI loadImageByURLString:[objectInfo objectForKey:@"imageURLString"]];


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
	[[objectInfo objectForKey:@"object"] setImage:[objectInfo objectForKey:@"image"]];
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
	[queueItems removeAllObjects];
	[backgroundThread cancelAllOperations];	
}

-(void)dealloc
{
	[backgroundThread release];
	[super dealloc];	
}
@end
