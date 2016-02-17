//
//  CommonTableViewController.m
//  Beadal
//
//  Created by song on 2015. 7. 27..
//  Copyright (c) 2015년 Woowabros. All rights reserved.
//

#import "CommonTableViewController.h"
#import "CommonTableViewSection.h"

@implementation CommonTableHeaderView

- (void)layoutSubviews {
    [super layoutSubviews];
    _headerLabel.preferredMaxLayoutWidth = _headerLabel.bounds.size.width;
}

@end


@implementation CommonTableFooterView

- (void)layoutSubviews {
    [super layoutSubviews];
    _footerLabel.preferredMaxLayoutWidth = _footerLabel.bounds.size.width;
}

@end


@implementation CommonTableViewController

+ (instancetype)controllerWithStoryBoard:(NSString *)storyBoardName controllerID:(NSString *)controllerID title:(NSString *)name {
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    CommonTableViewController * instance = [storyBoard instantiateViewControllerWithIdentifier:controllerID];
    if (name.length > 0)
        instance.title = name;
    return instance;
}

+ (instancetype)controllerWithNibName:(NSString *)nibName title:(NSString *)name {
    CommonTableViewController * instance = [[self alloc] initWithNibName:nibName bundle:nil];
    if (name.length > 0)
        instance.title = name;
    return	instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (CommonTableViewSection * section in _defaultSections)
        [section sectionDidLoad:self];
}

#pragma mark – UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UITableView *)tableView {
    for (CommonTableViewSection * section in _defaultSections)
        [section scrollViewWillBeginDragging];
}

- (void)scrollViewDidScroll:(UITableView *)tableView {
    for (CommonTableViewSection * section in _defaultSections)
        [section scrollViewWillBeginDragging];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    for (CommonTableViewSection * section in _defaultSections)
        [section scrollViewWillEndDraggingWithVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)scrollViewDidEndDragging:(UITableView *)tableView willDecelerate:(BOOL)decelerate {
    for (CommonTableViewSection * section in _defaultSections)
        [section scrollViewDidEndDragging];
}

#pragma mark - UITableViewDataSource protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _defaultSections.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    if (_defaultSections.count >= sectionIndex + 1) {
        tableView.rowHeight = [_defaultSections[sectionIndex] sizeOfCell:[NSIndexPath indexPathForRow:0 inSection:sectionIndex]].height;
        return [_defaultSections[sectionIndex] contentsCount];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_defaultSections.count > 0) {
        CommonTableViewSection * section = _defaultSections[indexPath.section];
        return (UITableViewCell *)[section cellForRowAtIndexPath:indexPath];
    }
    return nil;
}


#pragma mark - UITableViewDelegate protocol

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)index {
    if (_defaultSections.count > 0) {
        CommonTableViewSection * section = _defaultSections[index];
        return section.labelTitle.text.length > 0 ? section : nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)index {
    if (_defaultSections.count > 0) {
        CommonTableViewSection * section = _defaultSections[index];
        return section.labelTitle.text.length > 0 ? section.bounds.size.height : 0.0f;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (_defaultSections.count > 0) {
        CommonTableViewSection * currentSection = _defaultSections[section];
        return currentSection.sectionFooterView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_defaultSections.count > 0) {
        CommonTableViewSection * currentSection = _defaultSections[section];
        if (currentSection.sectionFooterView != nil)
            return currentSection.sectionFooterView.bounds.size.height;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_defaultSections.count > 0) {
        return [_defaultSections[indexPath.section] sizeOfCell:indexPath].height;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_defaultSections.count > 0) {
        [_defaultSections[indexPath.section] willDisplayCell:(CommonTableViewCell *)cell forContentAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_defaultSections.count > 0) {
        return [_defaultSections[indexPath.section] willSelectRowAtIndexPath:indexPath];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_defaultSections.count > 0) {
        [_defaultSections[indexPath.section] didSelectRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_defaultSections.count > 0) {
        return [_defaultSections[indexPath.section] willDeselectRowAtIndexPath:indexPath];
    }
    return  nil;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_defaultSections.count > 0) {
        [_defaultSections[indexPath.section] didDeselectRowAtIndexPath:indexPath];
    }
}

@end
