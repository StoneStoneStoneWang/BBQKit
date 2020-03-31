//
//  BBQFocusViewController.h
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

@interface BBQFocusTableViewCell : BBQBaseTableViewCell

@property (nonatomic ,strong) BBQFocusBean *focus;

@end
typedef void(^BBQFocusBlock)(void);

@interface BBQFocusViewController : BBQTableLoadingViewController

+ (instancetype)createBlackWithBlock:(BBQFocusBlock) block;

@end

NS_ASSUME_NONNULL_END
