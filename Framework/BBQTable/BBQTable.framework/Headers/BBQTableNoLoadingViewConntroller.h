//
//  BBQTableNoLoadingViewConntroller.h
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import BBQTransition;
#import "BBQTableHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BBQTableNoLoadingViewConntroller : BBQTViewController

@property (nonatomic ,strong) UITableView *tableView;

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (CGFloat )caculateForCell:(id )data forIndexPath:(NSIndexPath *)ip;

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip;

@property (nonatomic ,strong) BBQTableHeaderView *headerView;

@end


NS_ASSUME_NONNULL_END
