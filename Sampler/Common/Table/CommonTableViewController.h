//
//  CommonTableViewController.h
//  Beadal
//
//  Created by song on 2015. 7. 27..
//  Copyright (c) 2015년 Woowabros. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonTableViewSection;

@interface CommonTableHeaderView : UIView
@property (nonatomic, weak) IBOutlet UILabel * headerLabel;
@end

@interface CommonTableFooterView : UIView
@property (nonatomic, weak) IBOutlet UILabel * footerLabel;
@end


@interface CommonTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet                    UITableView         *       tableView;
@property (nonatomic, weak) IBOutlet                    UIView              *       tableHeaderView;
@property (nonatomic, weak) IBOutlet                    UIView              *       tableFooterView;

@property IBOutletCollection(CommonTableViewSection)    NSMutableArray		*       defaultSections;

+ (instancetype)controllerWithStoryBoard:(NSString *)storyBoardName controllerID:(NSString *)controllerID title:(NSString *)name;
+ (instancetype)controllerWithNibName:(NSString *)nibName title:(NSString *)name;

@end
