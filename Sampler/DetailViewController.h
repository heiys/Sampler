//
//  DetailViewController.h
//  Sampler
//
//  Created by Song Hur on 2014. 11. 25..
//  Copyright (c) 2014년 song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleData.h"

@interface DetailViewController : UIViewController <UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic)				 SampleData * sampleData;
@property (nonatomic, weak)	IBOutlet UILabel * attributedLabel;
@property (nonatomic, weak)	IBOutlet UILabel * contentsFrameSizeLabel;
@property (nonatomic, weak)	IBOutlet UILabel * fontTitleLabel;
@property (nonatomic, weak)	IBOutlet UILabel * fontSizeLabel;
@property (nonatomic, weak)	IBOutlet UIButton * bgButton;
@property (nonatomic, weak)	IBOutlet UIView * drawView;
- (IBAction)respondsToAddImage:(id)sender;
@end
