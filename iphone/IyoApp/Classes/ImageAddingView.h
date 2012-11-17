//
//  ImageAddingView.h
//  IyoApp
//
//  Created by yuriy on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IyoAppAppDelegate.h"

@interface ImageAddingView : UIViewController 
<UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UITableViewDelegate, UITableViewDataSource>
{
	IyoAppAppDelegate *appDelegate;
	NSMutableArray *imagesArray;
	NSMutableArray *thumbs;
	UIImagePickerController *pickerController;
	IBOutlet UILabel *viewLabel;
	IBOutlet UIButton *addImageButton;
	IBOutlet UIButton *addCameraImageButton;
	IBOutlet UITableView *imagetableView;
	int postItemNumber;
}

@property (nonatomic, retain) NSMutableArray *imagesArray;

-(void) setPostFieldNumber:(int)number;
-(IBAction) addImageToAd:(id)sender;
-(void) removeImageAtPosition:(id)sender;
-(IBAction) didOK;
@end
