//
//  BBQSettingViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQConfig.h"
@import BBQBridge;
@import BBQTable;
NS_ASSUME_NONNULL_BEGIN

@interface ZSettingTableViewCell : BBQBaseTableViewCell

@property (nonatomic ,strong) ZSettingBean *setting;

@end

typedef void(^ZSettingBlock)(ZSettingActionType type ,ZBaseViewController *vc);

@interface BBQSettingViewController : BBQTableNoLoadingViewConntroller

+ (instancetype)createSettingWithBlock:(ZSettingBlock) block;

@end

NS_ASSUME_NONNULL_END
