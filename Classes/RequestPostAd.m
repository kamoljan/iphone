//
//  RequestPostAd.m
//  AdPosting
//
//  Created by yuriy on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RequestPostAd.h"
#import "JSON.h"

@implementation RequestPostAd

@synthesize urlToRequest;

- (id)init
{
    if (self) {
        // Custom initialization
//		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"jpg"];
//		imageData = [NSData dataWithContentsOfFile:filePath];
//		if (imageData) {

//		}
	
		urlToRequest = [NSURL URLWithString:@"http://www.iyoiyo.jp/ios/upload"];
    }
    return self;
}

-(NSDictionary *) doRequest:(NSData *)imageData
{
	// setting up the request object now
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:urlToRequest];
	[request setHTTPMethod:@"POST"];
	
	/*
	 add some header info now
	 we always need a boundary when we post a file
	 also we need to set the content type
	 
	 You might want to generate a random boundary.. this is just the same
	 as my output from wireshark on a valid html post
	 */
	NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	/*
	 now lets create the body of the post
	 */
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	// file name located here
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"image_file\"; filename=\"iyoiyoAdImage.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	// setting the body of the post to the reqeust
	[request setHTTPBody:body];
		
	// now lets make the connection to the web
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding] autorelease];
	
	return [returnString JSONValue];	
}

- (void)dealloc {
	
    [super dealloc];
}
@end
