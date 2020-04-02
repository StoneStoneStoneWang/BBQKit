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

@interface BBQSettingTableViewCell : BBQBaseTableViewCell

@property (nonatomic ,strong) BBQSettingBean *setting;

@end

typedef void(^BBQSettingBlock)(BBQSettingActionType actionType ,BBQBaseViewController *from);

@interface BBQSettingViewController : BBQTableNoLoadingViewController

+ (instancetype)createSettingWithBlock:(BBQSettingBlock) block;

- (void)updateTableData;
@end

NS_ASSUME_NONNULL_END
