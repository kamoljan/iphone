//
//  Search.h
//  IyoApp
//
//  Created by yuriy on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Search : NSObject {
	NSMutableArray *dataSource,*imagesSource;
	NSInteger startCount;
}

@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, retain) NSMutableArray *imagesSource;

-(void) searchWithFilter:(NSArray *)filter;
@end
