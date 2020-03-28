//
//  BBQTViewController.h
//  ZTransiton
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
@import BBQBase;
NS_ASSUME_NONNULL_BEGIN

@interface BBQTViewController : BBQBaseViewController <UIGestureRecognizerDelegate>

@property(nonatomic,strong,readonly) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (nonatomic ,assign) BOOL canPanResponse;

@end

NS_ASSUME_NONNULL_END
