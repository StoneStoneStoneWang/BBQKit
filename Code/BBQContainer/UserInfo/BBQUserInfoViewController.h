//
//  BBQUserInfoViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "BBQConfig.h"
@import BBQBridge;
@import BBQTable;

NS_ASSUME_NONNULL_BEGIN

@interface BBQUserInfoTableViewCell : BBQBaseTableViewCell

@property (nonatomic ,strong) BBQUserInfoBean *userInfo;

@end

@interface BBQUserInfoViewController : BBQTableNoLoadingViewConntroller

+ (instancetype)createUserInfo;

@end

NS_ASSUME_NONNULL_END
