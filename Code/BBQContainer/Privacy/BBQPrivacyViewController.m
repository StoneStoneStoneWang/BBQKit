//
//  BBQPrivacyViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQPrivacyViewController.h"
@import SToolsKit;
@interface BBQPrivacyViewController ()

@property (nonatomic ,strong) BBQProtocolBridge *bridge;


#if BBQUserInfoOne

#elif BBQUserInfoTwo

#elif BBQUserInfoThree

@property (nonatomic ,strong) UIView *topLine;
#else


#endif
@end

@implementation BBQPrivacyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if BBQUserInfoOne
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
#elif BBQUserInfoTwo
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
#elif BBQUserInfoThree
    
#if BBQCONTAINDRAWER
    
    [self.navigationController setNavigationBarHidden:false];
#endif
    
#endif
}
#if BBQUserInfoOne


#elif BBQUserInfoTwo

#elif BBQUserInfoThree

- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
#else


#endif
+ (instancetype)createPrivacy {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [BBQProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
#if BBQUserInfoOne
    
    
#elif BBQUserInfoTwo
    
#elif BBQUserInfoThree
    
    [self.view addSubview:self.topLine];
#else
    
    
#endif
    
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if BBQUserInfoOne
    
#elif BBQUserInfoTwo
    
    
#elif BBQUserInfoThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:NSClassFromString(@"BBQLoginViewController")]) {
        
        CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.bounds);
        
        self.topLine.frame = CGRectMake(15, h, CGRectGetWidth(self.view.bounds) - 30, 8);
        
    } else {
        
        CGFloat h = KTOPLAYOUTGUARD;
        
        self.topLine.frame = CGRectMake(15, h, CGRectGetWidth(self.view.bounds) - 30, 8);
    }
    
    CGRect initFrame = self.textView.frame;
    
    CGRect finalFrame = CGRectOffset(initFrame, 0, 8);
    
    self.textView.frame = finalFrame;
    
#else
    
    
#endif
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if BBQUserInfoOne
    
#elif BBQUserInfoTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.textView.layer.masksToBounds = false;
    
#elif BBQUserInfoThree
    
    
#else
    
    
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"隐私与协议";
}
- (BOOL)canPanResponse {
    return true;
}
@end
