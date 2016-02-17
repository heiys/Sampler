//
//  CommonTableViewSection.m
//  Beadal
//
//  Created by song on 2015. 7. 28..
//  Copyright (c) 2015년 Woowabros. All rights reserved.
//

#import "CommonTableViewSection.h"

@interface		CommonTableViewSection ()
@property		NSMutableArray	*	contents;
@end


@implementation CommonTableViewSection

+ (instancetype)tableViewSection {
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
    NSAssert(objects.count > 0, @"CommonTableViewSection Nib must have only one top level object");
    for (NSObject * section in objects) {
        if ([section isKindOfClass:[CommonTableViewSection class]] == YES)
            return (CommonTableViewSection *)section;
    }
    return nil;
}

- (NSString *)templateOfCell {
    return NSStringFromClass(_classOfCell);
}

- (void)setTemplateOfCell:(NSString *)cell {
    _classOfCell = NSClassFromString(cell);
}

- (UITableView *)tableView {
    return self.parentViewController.tableView;
}

- (void)sectionDidLoad:(CommonTableViewController *)owner {
    NSAssert(self.classOfCell != nil, @"Section Must have class of cell!");
    _parentViewController = owner;
    NSString * cellIdentifier = NSStringFromClass(self.classOfCell);
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.contents = [NSMutableArray new];
}

- (void)willDisplayCell:(CommonTableViewCell *)cell forContentAtIndexPath:(NSIndexPath *)indexPath {
    [cell willDisplayContent:self.contents[indexPath.row]];
}

- (NSUInteger)contentsCount {
    return _contents.count;
}

- (CGSize)sizeOfCell:(NSIndexPath *)indexPath {
    return [_classOfCell sizeOfCell:[_contents objectAtIndex:indexPath.row]];
}


#pragma mark - Implement scroll event handler
- (void)scrollViewWillBeginDragging {
}

- (void)scrollViewDidScroll {
}

- (void)scrollViewWillEndDraggingWithVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
}

- (void)scrollViewDidEndDragging {
}

#pragma mark - Implement TableViewDataSource


- (CommonTableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString            *	identifier = NSStringFromClass(self.classOfCell);
    CommonTableViewCell	*	cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
        cell = [self.classOfCell tableViewCell];
    [cell didLoadForSection:self atIndexPath:indexPath];
    return cell;
}

#pragma mark - Implement TableView Select Event

- (NSIndexPath *)willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.parentViewController.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSIndexPath *)willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
