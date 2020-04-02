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

typedef NS_ENUM(NSInteger, BBQUserInfoActionType) {
    BBQUserInfoActionTypeName,
    BBQUserInfoActionTypeSignature,
};

typedef void(^BBQUserInfoBlock)(BBQUserInfoActionType actionType ,BBQBaseViewController *from);

@interface BBQUserInfoViewController : BBQTableNoLoadingViewController

+ (instancetype)createUserInfoWithBlock:(BBQUserInfoBlock )block;

- (void)updateName:(NSString *)name;

- (void)updateSignature:(NSString *)signature;

@end

NS_ASSUME_NONNULL_END
