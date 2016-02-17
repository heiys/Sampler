//
//  RootViewController.h
//  LabelSampler
//
//  Created by Song Hur on 2014. 11. 21..
//  Copyright (c) 2014년 Song Hur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleData.h"
#import "SampleListTableViewCell.h"

#define kSaveDataUserDefaultKey @"SaveDataUserDefaultKey"

@interface RootViewController : UITableViewController <UIAlertViewDelegate>
@property (nonatomic, strong) IBOutlet SampleListTableViewCell * cellTemplate;
@property (nonatomic, strong) 	NSMutableArray * dataListArr;
+ (instancetype)sharedInstance;
- (void)removeDataListAtIndex:(NSUInteger)index;
- (void)insertDataListAtIndex:(NSUInteger)index data:(NSDictionary *)data;
- (IBAction)respondsToAddScene:(id)sender;
@end

