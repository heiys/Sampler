//
//  DetailViewController.m
//  Sampler
//
//  Created by Song Hur on 2014. 11. 25..
//  Copyright (c) 2014년 song. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
	bool	isBeginLongpressEvent;
	UIImage * selectedImage;
}
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIColor * color = ((SampleLabelData *)_sampleData).attributedStr[NSBackgroundColorAttributeName];
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:((SampleLabelData *)_sampleData).attributedStr];
	[dict removeObjectForKey:NSBackgroundColorAttributeName];
	NSAttributedString * attrbStr = [[NSAttributedString alloc] initWithString:_sampleData.dataName attributes:dict];
	_bgButton.selected = YES;
	
	[_attributedLabel setAttributedText:attrbStr];
	[_attributedLabel setBackgroundColor:color];

	CGSize maximumLabelSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
	CGSize expectSize = [_attributedLabel sizeThatFits:maximumLabelSize];
	
	[_contentsFrameSizeLabel setText:[NSString stringWithFormat:@"{%.0f / %.0f}", expectSize.width, expectSize.height]];
	_fontTitleLabel.text = _attributedLabel.font.fontName;
	_fontSizeLabel.text = [NSString stringWithFormat:@"%.0f", _attributedLabel.font.fontDescriptor.pointSize];
	
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(beginLongpressEvent:)];
	[longPress setDelegate:self];
	[_attributedLabel addGestureRecognizer:longPress];
	_attributedLabel.layer.borderColor = [UIColor redColor].CGColor;

	//	CGRect rect = _attributedLabel.frame;
	//	rect.origin.x = rect.origin.x + rect.size.width;
	//	rect.origin.y = rect.origin.y + rect.size.height;
	//	rect.size = _contentsFrameSizeLabel.frame.size;
	//	[_contentsFrameSizeLabel setValue:@YES forKeyPath:@"translatesAutoresizingMaskIntoConstraints"];
	//	[_contentsFrameSizeLabel setFrame:rect];
}

- (IBAction)respondsToLabelOnBG:(id)sender
{
	_bgButton.selected = !_bgButton.selected;
	UIColor * color = _bgButton.selected ? ((SampleLabelData *)_sampleData).attributedStr[NSBackgroundColorAttributeName] : [UIColor clearColor];
	[_attributedLabel setBackgroundColor:color];
}

- (CGPoint)checkMovableBound:(CGPoint)point targetView:(UIView *)target
{
	if ((point.x < target.frame.size.width / 2.0f) && (point.y < target.frame.size.height / 2.0f))
		return CGPointMake(target.frame.size.width / 2.0f, target.frame.size.height / 2.0f);
	else if ((point.x < target.frame.size.width / 2.0f) && (point.y > _drawView.frame.size.height - (target.frame.size.height / 2.0f)))
		return CGPointMake(target.frame.size.width / 2.0f, _drawView.frame.size.height - (target.frame.size.height / 2.0f));
	else if ((point.x > _drawView.frame.size.width - (target.frame.size.width / 2.0f)) && (point.y < target.frame.size.height / 2.0f))
		return CGPointMake(_drawView.frame.size.width - (target.frame.size.width / 2.0f), target.frame.size.height / 2.0f);
	else if ((point.x > _drawView.frame.size.width - (target.frame.size.width / 2.0f)) && (point.y > _drawView.frame.size.height - (target.frame.size.height / 2.0f)))
		return CGPointMake(_drawView.frame.size.width - (target.frame.size.width / 2.0f), _drawView.frame.size.height - (target.frame.size.height / 2.0f));
	else if (point.x < target.frame.size.width / 2.0f)
		return CGPointMake(target.frame.size.width / 2.0f, point.y);
	else if (point.x > _drawView.frame.size.width - (target.frame.size.width / 2.0f))
		return CGPointMake(_drawView.frame.size.width - (target.frame.size.width / 2.0f), point.y);
	else if (point.y < target.frame.size.height / 2.0f)
		return CGPointMake(point.x, target.frame.size.height / 2.0f);
	else if (point.y > _drawView.frame.size.height - (target.frame.size.height / 2.0f))
		return CGPointMake(point.x, _drawView.frame.size.height - (target.frame.size.height / 2.0f));

	isBeginLongpressEvent = NO;
	return point;
}

#pragma mark - Longpress Gesture Callback method

- (void)beginLongpressEvent:(UILongPressGestureRecognizer *)sender
{
	UIView *view = sender.view;
	CGPoint point = [sender locationInView:view.superview];
	
	if (sender.state == UIGestureRecognizerStateBegan)
	{
		isBeginLongpressEvent = YES;
		_attributedLabel.layer.borderWidth = 3.0f;
	}
	else if (sender.state == UIGestureRecognizerStateChanged)
	{
		_attributedLabel.center = [self checkMovableBound:point targetView:sender.view];
	}
	else if (sender.state == UIGestureRecognizerStateEnded)
	{
		_attributedLabel.layer.borderWidth = 0.0f;
		isBeginLongpressEvent = NO;
	}
}

- (IBAction)respondsToAddImage:(id)sender
{
	UIImagePickerController * imagePicker = [UIImagePickerController new];
	imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	imagePicker.delegate = self;
	[self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissViewControllerAnimated:YES completion:^{
	
		if (info[@"UIImagePickerControllerOriginalImage"] != nil)
		{
			selectedImage = info[@"UIImagePickerControllerOriginalImage"];
			UIImageView * imageView = [[UIImageView alloc] initWithImage:selectedImage];
			CGRect rect = imageView.frame;
			rect.size = CGSizeMake(rect.size.width / 10, rect.size.height / 10);
			imageView.frame = rect;
			[self.view addSubview:imageView];
		}
	}];
}



@end
