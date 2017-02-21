//
//  SKSTableView.h
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import <UIKit/UIKit.h>



@class EPFoldTableView;

@class EPFoldTableViewCell;

#pragma mark - SKSTableViewDelegate

@protocol EPFoldTableViewDelegate <UITableViewDataSource, UITableViewDelegate>
// 代理
@required
/**
 *  subrow 的行数
 *
 *  @param tableView tableview
 *  @param indexPath indexpath
 *
 *  @return 行数
 *
 *  @since 1.0
 */
- (NSInteger)tableView:(EPFoldTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  返回cell
 *
 *  @param tableView tableview
 *  @param indexPath indexpath
 *
 *  @return return value description
 *
 *  @since 1.0
 */
- (UITableViewCell *)tableView:(EPFoldTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 *  选中的行
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 *
 *  @since 1.0
 */
- (void)tableView:(EPFoldTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  是否初始化展开
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 *
 *  @return return value description
 *
 *  @since 1.0
 */
- (BOOL)tableView:(EPFoldTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface EPFoldTableView : UITableView
// 代理
@property (nonatomic, weak) id <EPFoldTableViewDelegate> SKSTableViewDelegate;
// 是否只展开一行
@property (nonatomic, assign) BOOL shouldExpandOnlyOneCell;
/**
 *  刷新
 *
 *  @since 1.0
 */
- (void)refreshData;
/**
 *  刷新并滚动到相应的行
 *
 *  @param indexPath indexPath description
 *
 *  @since 1.0
 */
- (void)refreshDataWithScrollingToIndexPath:(NSIndexPath *)indexPath;
/**
 *
 *
 *  @since 1.0
 */
- (void)collapseCurrentlyExpandedIndexPaths;

@end

#pragma mark - NSIndexPath (EPFoldTableView)

@interface NSIndexPath (EPFoldTableView)

@property (nonatomic) NSUInteger epsection;
@property (nonatomic) NSUInteger eprow;
@property (nonatomic) NSUInteger epsubRow;

+ (NSIndexPath *)indexPathForSubRow:(NSInteger)subrow inRow:(NSInteger)row inSection:(NSInteger)section;

@end
