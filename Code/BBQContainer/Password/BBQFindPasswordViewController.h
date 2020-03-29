//
//  BBQFindPasswordViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "BBQConfig.h"
@import BBQBridge;
@import BBQTransition;
NS_ASSUME_NONNULL_BEGIN
typedef void(^BBQFindPassworBlock)(BBQBaseViewController *vc);
@interface BBQFindPasswordViewController : BBQTViewController

+ (instancetype)createPasswordWithBlock:(BBQFindPassworBlock )block;

@end

NS_ASSUME_NONNULL_END
