//
//  BBQBaseAnimation.h
//  ZTransiton
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import Foundation;
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

@interface BBQBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

// push or pop
@property(nonatomic,assign,readonly) UINavigationControllerOperation transitionType;

@property(nonatomic,strong,readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;

/**
 *  主要构造方法
 *  @param  transitionType      动画类型 push or pop
 *  @param  duration            间隔时间
 */
- (instancetype)initWithType:(UINavigationControllerOperation)transitionType
                    Duration:(NSTimeInterval)duration;

#pragma mark - push pop方法，具体交给子类实现
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext;
@end

NS_ASSUME_NONNULL_END
