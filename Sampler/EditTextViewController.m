//
//  EditTextViewController.m
//  LabelSampler
//
//  Created by Song Hur on 2014. 11. 21..
//  Copyright (c) 2014년 Song Hur. All rights reserved.
//

#import "EditTextViewController.h"
#import "RootViewController.h"

@interface EditTextViewController ()
{
	CGFloat			fontSize;
	NSArray		*	fontList;
}
@property (nonatomic, weak) IBOutlet UITextView * textView;
@property (nonatomic, weak) IBOutlet UIButton * bgColorButton;
@property (nonatomic, weak) IBOutlet UIButton * boldButton;
@property (nonatomic, weak) IBOutlet UILabel * fontNameLabel;
@property (nonatomic, weak) IBOutlet UILabel * fontSizeLabel;

@property (nonatomic) UIColor * textBgColor;
@property (nonatomic) UIAlertController * clearAlertController;
@property (nonatomic) UIAlertController * saveCompleteAlertController;

@property (nonatomic) NSMutableAttributedString * attributedString;
@end

@implementation EditTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[_textView becomeFirstResponder];
	fontList = @[@"AppleSDGothicNeo-Thin", @"AppleSDGothicNeo-Light", @"AppleSDGothicNeo-Regular", @"AppleSDGothicNeo-Medium", @"AppleSDGothicNeo-SemiBold", @"AppleSDGothicNeo-Bold"];
	
	//get AttrStr from TextView
	_attributedString = (NSMutableAttributedString*)self.textView.attributedText;
	
	NSRange range = NSMakeRange(0, _textView.attributedText.string.length);
	_attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
	NSDictionary * fontAttributes = [_attributedString attributesAtIndex:0 effectiveRange:&range];
	_textBgColor = fontAttributes[NSBackgroundColorAttributeName];

	[_attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, _textView.attributedText.length)];
	
	UIFont * font = fontAttributes[NSFontAttributeName];
	
	[_fontNameLabel setText:[font.fontDescriptor objectForKey:@"NSFontNameAttribute"]];
	[_fontSizeLabel setText:[NSString stringWithFormat:@"%@",[font.fontDescriptor objectForKey:@"NSFontSizeAttribute"]]];
	
	
	[self setBgColorButton:_bgColorButton];
	
	//prepare clearAlert
	_clearAlertController = [UIAlertController
										  alertControllerWithTitle:nil
										  message:@"Clear?"
										  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction
								   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
								   style:UIAlertActionStyleCancel
								   handler:^(UIAlertAction *action)
								   {
									   NSLog(@"Cancel action");
								   }];
	
	UIAlertAction *okAction = [UIAlertAction
							   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
							   style:UIAlertActionStyleDefault
							   handler:^(UIAlertAction *action)
							   {
								   [_textView setAttributedText:[[NSAttributedString alloc] initWithString:@""]];
								   [_textView setText:@""];
							   }];
	[_clearAlertController addAction:cancelAction];
	[_clearAlertController addAction:okAction];
	
	//prepare saveAlert
	_saveCompleteAlertController = [UIAlertController
							 alertControllerWithTitle:nil
							 message:@"Save"
							 preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *saveAction = [UIAlertAction
							   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
							   style:UIAlertActionStyleDefault
							   handler:^(UIAlertAction *action)
							   {
								   NSRange range = NSMakeRange(0, _textView.attributedText.length);
								   NSDictionary * fontAttributes = [_attributedString attributesAtIndex:0 effectiveRange:&range];

								   NSDictionary * dict = @{@"type":[NSString stringWithFormat:@"%d",kLabelDataType],
														   @"title":_textView.attributedText.string,
														   @"data":fontAttributes};

								   [[RootViewController sharedInstance] insertDataListAtIndex:0 data:dict];
								   [self dismissViewControllerAnimated:YES completion:nil];
							   }];
	[_saveCompleteAlertController addAction:saveAction];
}


- (IBAction)increaseFontSize:(id)sender
{
	if (_textView.attributedText.length == 0) return;
	_attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
	NSRange range = NSMakeRange(0, _textView.attributedText.length);
	NSDictionary * fontAttributes = [_attributedString attributesAtIndex:0 effectiveRange:&range];
	UIFont * font = fontAttributes[NSFontAttributeName];
	font = [UIFont fontWithName:font.fontName size:font.pointSize + 1.0f];
	range = NSMakeRange(0, _textView.attributedText.length);
	[_attributedString addAttribute:NSFontAttributeName value:font range:range];
	_textView.attributedText = _attributedString;
	[_fontSizeLabel setText:[NSString stringWithFormat:@"%@",[font.fontDescriptor objectForKey:@"NSFontSizeAttribute"]]];

	//code for separated attribute
//	NSRange range = NSMakeRange(_textView.attributedText.length - 1, 1);
//	NSAttributedString *newAttString = [[NSAttributedString alloc] initWithString:@" " attributes:[_textView.attributedText attributesAtIndex:range.location effectiveRange:&range]];
//	
//	_attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
//	[_attributedString appendAttributedString:newAttString];
//	_textView.attributedText = _attributedString;
//	range = NSMakeRange(_textView.attributedText.length - 2, 1);
//	NSDictionary * fontAttributes = [_attributedString attributesAtIndex:_textView.attributedText.length - 1 effectiveRange:&range];
//	UIFont * font = fontAttributes[NSFontAttributeName];
//	font = [UIFont fontWithName:font.fontName size:font.pointSize + 1.0f];
//	[_attributedString addAttribute:NSFontAttributeName value:font range:range];
//	[_attributedString replaceCharactersInRange:NSMakeRange(_textView.attributedText.length - 1, 1) withAttributedString:[[NSAttributedString alloc] initWithString:@""]];
//	_textView.attributedText = _attributedString;
}

- (IBAction)decreaseFontSize:(id)sender
{
	if (_textView.attributedText.length == 0) return;
	_attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
	NSRange range = NSMakeRange(0, _textView.attributedText.length);
	NSDictionary * fontAttributes = [_attributedString attributesAtIndex:0 effectiveRange:&range];
	UIFont * font = fontAttributes[NSFontAttributeName];
	
	if (font.pointSize == 1.0f) return;
	font = [UIFont fontWithName:font.fontName size:font.pointSize - 1.0f];
	range = NSMakeRange(0, _textView.attributedText.length);
	[_attributedString addAttribute:NSFontAttributeName value:font range:range];
	_textView.attributedText = _attributedString;
	[_fontSizeLabel setText:[NSString stringWithFormat:@"%@",[font.fontDescriptor objectForKey:@"NSFontSizeAttribute"]]];

	//code for separated attribute
//	[_attributedString replaceCharactersInRange:NSMakeRange(_textView.attributedText.length - 1, 1) withAttributedString:[[NSAttributedString alloc] initWithString:@""]];

	//code for separated attribute
//	NSRange range = NSMakeRange(_textView.attributedText.length - 1, 1);
//	NSAttributedString *newAttString = [[NSAttributedString alloc] initWithString:@" " attributes:[_textView.attributedText attributesAtIndex:range.location effectiveRange:&range]];
//	
//	_attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
//	[_attributedString appendAttributedString:newAttString];
//	_textView.attributedText = _attributedString;
//	range = NSMakeRange(_textView.attributedText.length - 2, 1);
//	NSDictionary * fontAttributes = [_attributedString attributesAtIndex:_textView.attributedText.length - 1 effectiveRange:&range];
//	UIFont * font = fontAttributes[NSFontAttributeName];
//	font = [UIFont fontWithName:font.fontName size:font.pointSize - 1.0f];
//	[_attributedString addAttribute:NSFontAttributeName value:font range:range];
//	[_attributedString replaceCharactersInRange:NSMakeRange(_textView.attributedText.length - 1, 1) withAttributedString:[[NSAttributedString alloc] initWithString:@""]];
//	_textView.attributedText = _attributedString;
}

- (IBAction)closeEditModal:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearText:(id)sender
{
	[_textView setAttributedText:[[NSAttributedString alloc] initWithString:@""]];
	[_textView setText:@""];
	
	//clear modal
//	[self presentViewController:_clearAlertController animated:YES completion:nil];
}

- (IBAction)respondsToSave:(id)sender
{
	[self presentViewController:_saveCompleteAlertController animated:YES completion:nil];
}

- (IBAction)respondsToBoldButton:(id)sender
{
	[self setBoldButton:(UIButton*)sender];
}

- (void)setBoldButton:(UIButton *)boldButton
{
	if (_textView.attributedText.length == 0) return;
	NSRange range = NSMakeRange(0, _textView.attributedText.string.length);
	_attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];

	
	NSDictionary * fontAttributes = [_attributedString attributesAtIndex:0 effectiveRange:&range];
	UIFont * font = fontAttributes[NSFontAttributeName];
	
	for (int index = 0; index < fontList.count ; index++)
	{
		if ([fontList[index] isEqualToString:font.fontName] == YES)
		{
			if (index == fontList.count - 1)
				font = [UIFont fontWithName:fontList[0] size:(CGFloat)[_fontSizeLabel.text intValue]];
			else
				font = [UIFont fontWithName:fontList[index+1] size:(CGFloat)[_fontSizeLabel.text intValue]];
			break;
		}
	}
	[_fontNameLabel setText:font.fontName];
	[_attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _textView.attributedText.string.length)];
	_textView.attributedText = _attributedString;
}

- (IBAction)respondsToBgColorButton:(id)sender
{
	[self setBgColorButton:(UIButton*)sender];
}

- (void)setBgColorButton:(UIButton *)bgColorButton
{
	if (_textView.attributedText.length == 0) return;
	_attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
	[_attributedString addAttribute:NSBackgroundColorAttributeName value:bgColorButton.selected ? [UIColor clearColor] : _textBgColor range:NSMakeRange(0, _textView.attributedText.length)];
	bgColorButton.selected = !bgColorButton.selected;
	_textView.attributedText = _attributedString;
}

- (IBAction)saveCurrentText:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
