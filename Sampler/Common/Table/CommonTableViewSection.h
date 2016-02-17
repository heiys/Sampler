//
//  CommonTableViewSection.h
//  Beadal
//
//  Created by song on 2015. 7. 28..
//  Copyright (c) 2015년 Woowabros. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommonTableViewController.h"
#import "CommonTableViewCell.h"

@interface CommonTableViewSection : UIView

@property(readonly)                 NSString                    *	sectionName;
@property(readonly, weak)           CommonTableViewController	*	parentViewController;
@property(readonly)                 NSMutableArray              *	contents;
@property(readonly)                 NSUInteger                      contentsCount;
@property IBOutlet                  UILabel                     *	labelTitle;
@property IBOutlet                  UIView                      *	sectionFooterView;

@property                           Class                           classOfCell;
@property                           NSString                    *   templateOfContent;

@property(getter=isSectionVisible)	BOOL                            visibleSection;


+ (instancetype)tableViewSection;

/*!
 Section did load into the CommonViewController.
 */
- (void)sectionDidLoad:(CommonTableViewController *)owner;

- (void)willDisplayCell:(CommonTableViewCell *)cell forContentAtIndexPath:(NSIndexPath *)indexPath;

- (CGSize)sizeOfCell:(NSIndexPath *)indexPath;
- (CommonTableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableView *)tableView;
- (NSUInteger)contentsCount;

// scroll event
- (void)scrollViewWillBeginDragging;
- (void)scrollViewDidScroll;
- (void)scrollViewWillEndDraggingWithVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDragging;

// select event
- (NSIndexPath *)willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
