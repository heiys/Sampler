//
//  CanvaseViewController.m
//  Sampler
//
//  Created by SongH on 2015. 2. 4..
//  Copyright (c) 2015년 song. All rights reserved.
//

#import "CanvaseViewController.h"
#define DEFAULT_OBJ_FRAME CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height / 2 - 100, 200.0f, 200.0f)

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
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	AddObjectViewController * controller = [storyBoard instantiateViewControllerWithIdentifier:@"addObjectViewController"];
	[self presentViewController:controller animated:YES completion:nil];
//	//메뉴시트 띄우기
//	UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:lstr(@"Cancel") style:UIAlertActionStyleCancel
//														 handler:nil];
//	
//	UIAlertAction* addViewAction = [UIAlertAction actionWithTitle:lstr(@"View") style:UIAlertActionStyleDefault
//														 handler:^(UIAlertAction * action) {
//															 [self addObjectInCanvas:ObjTypeView];
//														 }];
//
//	
//	UIAlertController * addMenuAlertViewController = [UIAlertController alertControllerWithTitle:lstr(@"SelectMenuItem") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//	[addMenuAlertViewController addAction:addViewAction];
//	[addMenuAlertViewController addAction:cancelAction];
//	[self presentViewController:addMenuAlertViewController animated:YES completion:nil];
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

- (void)addObjectInCanvas:(ObjectType) objType {
	
	if (objType == ObjTypeView) {
		SampleView * view = [SampleView objectWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height / 2 - 100, 200.0f, 200.0f)];
		view.backgroundColor = [UIColor grayColor];
		[self.view addSubview:view];
	}

	if (objType == ObjTypeImageView) {
		SampleView * view = [[SampleView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height / 2 - 100, 200.0f, 200.0f)];
		view.backgroundColor = [UIColor grayColor];
		[self.view addSubview:view];
	}

}





@end
