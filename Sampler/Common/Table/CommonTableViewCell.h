//
//  CommonTableViewCell.h
//  Beadal
//
//  Created by song on 2015. 7. 28..
//  Copyright (c) 2015년 Woowabros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableViewController.h"

@class CommonTableViewSection;

@interface CommonTableViewCell : UITableViewCell

@property(readonly, weak)						CommonTableViewSection	*	parentSection;
@property(readonly)								NSIndexPath             *	indexPath;
@property(readonly)								id                          content;
@property(nonatomic)							UIColor                 *	defaultBackgroundColor;
@property(nonatomic)							UIColor                 *	selectedBackgroundColor;

+ (instancetype)tableViewCell;
+ (CGSize)sizeOfCell:(id)content;
- (CommonTableViewController *)tableViewController;
- (void)willDisplayContent:(id)content;
- (void)didLoadForSection:(CommonTableViewSection *)section atIndexPath:(NSIndexPath *)indexPath;
- (IBAction)respondsToSelect:(id)content;
@end
