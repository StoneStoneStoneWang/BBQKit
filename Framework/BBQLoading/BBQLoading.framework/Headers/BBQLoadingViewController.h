//
//  BBQLoadingViewController.h
//  TSUIKit
//
//  Created by three stone 王 on 2018/7/10.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

@import BBQTransition;
#import "BBQLoadingView.h"
@interface BBQLoadingViewController : BBQTViewController

@property (nonatomic ,strong ,readonly) BBQLoadingView *loadingView;

@property (nonatomic ,assign) BBQLoadingStatus loadingStatus;

// 重新加载
- (void)onReloadItemClick;

@end
