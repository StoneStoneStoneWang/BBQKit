//
//  BBQBlackViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "BBQConfig.h"
@import BBQBridge;
@import BBQTable;
@import BBQBean;

NS_ASSUME_NONNULL_BEGIN

@interface BBQBlackTableViewCell : BBQBaseTableViewCell

@property (nonatomic ,strong) BBQBlackBean *black;

@end

@interface BBQBlackViewController : BBQTableLoadingViewController

+ (instancetype)createBlack;

@end

NS_ASSUME_NONNULL_END
