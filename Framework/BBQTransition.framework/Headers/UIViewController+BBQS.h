//
//  UIViewController+ZSnapshot.h
//  ZTransiton
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BBQS)

/**
 *屏幕快照
 */
@property (nonatomic, strong ,nullable) UIView *snapshot;

@property (nonatomic, strong ,nullable)UIView *topSnapshot;

@property (nonatomic, strong ,nullable)UIView *viewSnapshot;

@property (nonatomic, strong ,nullable) UIView *tabbarSnapshot;

@end

NS_ASSUME_NONNULL_END
