//
//  ImagePostingView.h
//  navBased
//
//  Created by yuriy on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePostingView : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UITableViewDelegate, UITableViewDataSource>
{
	NSMutableArray *imagesArray;
	NSMutableArray *thumbs;
	UIImagePickerController *pickerController;
	IBOutlet UIButton *addImageButton;
	IBOutlet UIButton *addCameraImageButton;
	IBOutlet UITableView *imagetableView;
}

@property (nonatomic, retain) NSMutableArray *imagesArray;

-(IBAction) addImageToAd:(id)sender;
-(void) removeImageAtPosition:(id)sender;
@end
