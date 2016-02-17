//
//  RootViewController.m
//  LabelSampler
//
//  Created by Song Hur on 2014. 11. 21..
//  Copyright (c) 2014년 Song Hur. All rights reserved.
//

#import "RootViewController.h"
#import "CanvaseViewController.h"
#import "DetailViewController.h"


@interface RootViewController ()
{
	UIAlertView * addSceneAlert;
}
@end

@implementation RootViewController

static NSString *cellIdentifier = @"SampleListTableViewCell";

+ (instancetype)sharedInstance
{
	static id instance;
	static dispatch_once_t once;
	if (instance == nil)
	{
		dispatch_once(&once, ^{
			instance = [self new];
		});
	}
	return instance;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[RootViewController sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self loadDataList];
}

- (NSString *)dataPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"Samples.plist"];
}

- (NSUserDefaults *)userDefault
{
	return [NSUserDefaults standardUserDefaults];
}

- (void)loadDataList
{
	[RootViewController sharedInstance].dataListArr = [[NSMutableArray alloc] initWithCapacity:0];

	if ([self.userDefault objectForKey:kSaveDataUserDefaultKey] != nil)
	{
		NSData * data = [self.userDefault objectForKey:kSaveDataUserDefaultKey];
		NSMutableArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];

		for (NSDictionary * sampleDict in array)
		{
			if ([sampleDict[@"type"] isEqualToString:@"0"] == YES)
				[[RootViewController sharedInstance].dataListArr insertObject:[SampleLabelData sampleWithDict:sampleDict] atIndex:0];
		}
	}
	[self.tableView reloadData];
}

- (void)removeDataListAtIndex:(NSUInteger)index
{
	[[RootViewController sharedInstance].dataListArr removeObjectAtIndex:index];
	[self.tableView reloadData];
}

- (void)insertDataListAtIndex:(NSUInteger)index data:(NSDictionary *)data
{
	SampleData * sampleData = nil;
	NSMutableArray * array = nil;

	if ([data[@"type"] isEqualToString:@"0"] == YES)
		sampleData = [SampleLabelData sampleWithDict:data];
		
	[[RootViewController sharedInstance].dataListArr insertObject:sampleData atIndex:0];
	
	NSData * saveData = [self.userDefault objectForKey:kSaveDataUserDefaultKey];

	if (saveData == nil)
		array = [NSMutableArray arrayWithObject:data];
	else
	{
		array = [NSKeyedUnarchiver unarchiveObjectWithData:saveData];
		[array insertObject:data atIndex:0];
	}
	NSData * insertData = [NSKeyedArchiver archivedDataWithRootObject:array];
	[self.userDefault setValue:insertData forKey:kSaveDataUserDefaultKey];
	[self.tableView reloadData];
}

#pragma mark - UITableViewControllerDelegate method


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [RootViewController sharedInstance].dataListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString	*	identifier = cellIdentifier;
	SampleListTableViewCell	*cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
	SampleData * data = [[RootViewController sharedInstance].dataListArr objectAtIndex:indexPath.row];
	[cell.textLabel setText:data.dataName];
	return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Make sure your segue name in storyboard is the same as this line
	if ([[segue identifier] isEqualToString:@"DetailViewController"])
	{
		NSUInteger index = ((NSIndexPath*)[self.tableView indexPathForCell:sender]).row;
		SampleData * data = [[RootViewController sharedInstance].dataListArr objectAtIndex:index];
		DetailViewController *controller = [segue destinationViewController];
		[controller setSampleData:data];
	}
}

#pragma mark - IBAction methods
- (IBAction)respondsToAddScene:(id)sender
{
	addSceneAlert = [[UIAlertView alloc] initWithTitle:lstr(@"AddScene") message:nil delegate:self cancelButtonTitle:lstr(@"Cancel") otherButtonTitles:lstr(@"OK"), nil];
	addSceneAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
	[addSceneAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView == addSceneAlert)
	{
		UITextField *textfield = [alertView textFieldAtIndex: 0];
		switch (buttonIndex) {
			case 1:
				if (![textfield.text isEqual:@""])
				{
					UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
					CanvaseViewController * controller = [storyBoard instantiateViewControllerWithIdentifier:@"CanvaseViewController"];
					controller.title = textfield.text;
					[self presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
				}
				break;
				
			default:
				NSLog(@"Nothing to do");
				break;
		}
	}
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
	UITextField *textField = [alertView textFieldAtIndex:0];
	if ([textField.text length] == 0)
	{
		return NO;
	}
	return YES;
}




@end
