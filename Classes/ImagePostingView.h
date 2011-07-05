//
//  ImagePostingView.h
//  navBased
//
//  Created by yuriy on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImagePostingView : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	NSMutableArray *imagesArray;
	UIImagePickerController *pickerController;
	IBOutlet UIButton *addImageButton;

}

@property (nonatomic, retain) NSMutableArray *imagesArray;

-(IBAction) addImageToAd;
-(void) removeImageAtPosition:(NSInteger)removingImageIndex;
@end
