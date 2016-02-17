//
//  CommonTableViewCell.m
//  Beadal
//
//  Created by song on 2015. 7. 28..
//  Copyright (c) 2015년 Woowabros. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "CommonTableViewSection.h"

@implementation CommonTableViewCell

+ (instancetype)tableViewCell {
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
	return	[nib objectAtIndex:0];
}

+ (CGSize)sizeOfCell:(id)content {
	CommonTableViewCell * cell = [[self class] tableViewCell];
	return cell.frame.size;
}

- (void)willDisplayContent:(id)content {
	_content = content;
}

- (CommonTableViewController *)tableViewController {
	return _parentSection.parentViewController;
}


- (void)didLoadForSection:(CommonTableViewSection *)section atIndexPath:(NSIndexPath *)indexPath
{
	_indexPath = indexPath;
	_parentSection = section;
}

- (IBAction)respondsToSelect:(id)content {}

@end
