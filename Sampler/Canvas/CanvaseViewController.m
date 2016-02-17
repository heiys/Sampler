//
//  CanvaseViewController.m
//  Sampler
//
//  Created by SongH on 2015. 2. 4..
//  Copyright (c) 2015년 song. All rights reserved.
//

#import "CanvaseViewController.h"

@interface CanvaseViewController ()
{
	UIAlertView * quiteAlertView;
}
@end

@implementation CanvaseViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self addTripleTapGesture];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methods
- (IBAction)respondsToAddView:(id)sender
{
	//메뉴시트 띄우기
	UIAlertAction* addViewAction = [UIAlertAction actionWithTitle:lstr(@"ViewItem") style:UIAlertActionStyleDefault
														  handler:^(UIAlertAction * action) {}];
	
	UIAlertController * addMenuAlertViewController = [UIAlertController alertControllerWithTitle:lstr(@"SelectMenuItem") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	[addMenuAlertViewController addAction:addViewAction];
	[self presentViewController:addMenuAlertViewController animated:YES completion:nil];
}

#pragma mark - TapGestureRecognizer
- (void)addTripleTapGesture
{
	UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTripleTap:)];
	tripleTap.numberOfTapsRequired = 3;
	[self.view addGestureRecognizer:tripleTap];
}

- (void)handleTripleTap:(UIGestureRecognizer *)gestureRecognizer
{
	quiteAlertView = [[UIAlertView alloc] initWithTitle:lstr(@"Quite") message:nil delegate:self cancelButtonTitle:lstr(@"Cancel") otherButtonTitles:lstr(@"OK"), nil];
	[quiteAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView == quiteAlertView)
	{
		if (buttonIndex)
			[self dismissViewControllerAnimated:YES completion:nil];
	}
}





@end
