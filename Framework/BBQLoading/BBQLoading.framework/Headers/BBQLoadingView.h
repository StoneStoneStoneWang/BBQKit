//
//  BBQLoadingView.h
//  TSUIKit
//
//  Created by three stone 王 on 2018/7/10.
//  Copyright © 2018年 three stone 王. All rights reserved.
//
@import UIKit;
@import BBQTransition;

typedef NS_ENUM(NSInteger,BBQLoadingStatus) {
    
    BBQLoadingStatusBegin,
    
    BBQLoadingStatusLoading,
    
    BBQLoadingStatusSucc,
    
    BBQLoadingStatusFail,
    
    BBQLoadingStatusReload
};

@protocol BBQLoadingViewDelegate <NSObject>

- (void)onReloadItemClick;

@end

@interface BBQLoadingView : UIView

+ (instancetype)loadingWithContentViewController:(BBQTViewController *)contentViewController;

/*
 设置加载状态
 BBQLoadingStatusBegin 请在viewwillappear里
 BBQLoadingStatusLoading 请在设置begin之后 viewwillappear里
 BBQLoadingStatusSucc 加载成功
 BBQLoadingStatusFail 加载失败
 BBQLoadingStatusReload 重新加载 屏幕上有 点击屏幕重新加载按钮
 */
@property (nonatomic ,assign ,readonly) BOOL isLoading;

@property (nonatomic ,assign)BBQLoadingStatus status;

- (void)changeLoadingStatus:(BBQLoadingStatus )status;

@property (nonatomic ,weak) id<BBQLoadingViewDelegate> mDelegate;


@end
