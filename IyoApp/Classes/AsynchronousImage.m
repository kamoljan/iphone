//
//  AsynchronousImage.m
//  IyoApp
//
//  Created by yuriy on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsynchronousImage.h"


@implementation AsynchronousImage

- (id)initWithTableViewCell:(UITableViewCell *)cell URLPathToImage:(NSString *)URLToImage{
    self = [super init];
    if (self) {
        // Custom initialization.		
		imageViewToChange = [cell.imageView retain];
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLToImage] 
												 cachePolicy:NSURLRequestReturnCacheDataElseLoad 
											 timeoutInterval:30.0];
		
		imageLoadingConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];		
		
    }
    return self;
}

- (id)initWithImageView:(UIImageView *)imageView 
		 URLPathToImage:(NSString *)URLToImage{
    self = [super init];
    if (self) {
        // Custom initialization.
		imageViewToChange = [imageView retain];
		
		//add activity indicator
		activityImage = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		
		activityImage.hidesWhenStopped = NO;
		[activityImage startAnimating];
		[imageViewToChange addSubview:activityImage];
		[activityImage release];
		//
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLToImage] 
												 cachePolicy:NSURLRequestReturnCacheDataElseLoad 
											 timeoutInterval:30.0];
		
		imageLoadingConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    return self;
}
- (void)setActivityIndicatorPositionIx:(CGFloat )IX IY:(CGFloat )IY IWidth:(CGFloat )IWidth IHeight:(CGFloat )IHeight;{
		
	activityImage.frame = CGRectMake(IX, IY, IWidth, IHeight);
}
#pragma mark NSURLConnection delegate
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
    if (data == nil)
        data = [[NSMutableData alloc] initWithCapacity:2048];
    [data appendData:incrementalData];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
	[activityImage stopAnimating];
	[activityImage removeFromSuperview];
	
	
	UIImage *tempImage = [UIImage imageWithData:data]; 
	// autoscale image using x=(w/h)*y formula
	CGFloat originW = tempImage.size.width;
	CGFloat originH = tempImage.size.height;
	CGFloat imagesW = imageViewToChange.frame.size.width;
	//CGFloat imagesH = imageViewToChange.frame.size.height;
	//CGFloat scalledW = (originW / originH) * imagesH;
	CGFloat scalledH = (originH / originW) * imagesW;	
	CGRect frame = CGRectMake(imageViewToChange.frame.origin.x , imageViewToChange.frame.origin.y, imagesW, scalledH);	
	imageViewToChange.image = tempImage;	
	imageViewToChange.frame = frame;
    [data release], data = nil;	
}
#pragma mark -
-(void)dealloc{
	[imageViewToChange release];
	[imageLoadingConnection release];
	[super dealloc];
}
@end
