//
//  BBQLoginViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

@import BBQTransition;
#import "BBQConfig.h"
NS_ASSUME_NONNULL_BEGIN
@import BBQBridge;
typedef void(^BBQLoginBlock)(BBQLoginActionType actionType ,BBQBaseViewController *vc);
@interface BBQLoginViewController : BBQTViewController

+ (instancetype)createLoginWithBlock:(BBQLoginBlock)block;

@end

NS_ASSUME_NONNULL_END
