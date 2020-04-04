//
//  BBQProtocolViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQProtocolViewController.h"
@import SToolsKit;
@interface BBQProtocolViewController ()

@property (nonatomic ,strong) BBQProtocolBridge *bridge;


#if BBQLoginOne


#elif BBQLoginTwo

#elif BBQLoginThree

@property (nonatomic ,strong) UIView *topLine;
#else


#endif
@end

@implementation BBQProtocolViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if BBQLoginOne
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@BBQColor] ];
#elif BBQLoginTwo
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor] ];
    
#else
    
    
#endif
}
#if BBQLoginOne


#elif BBQLoginTwo

#elif BBQLoginThree

- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
#else


#endif
+ (instancetype)createProtocol {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [BBQProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.topLine];
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if BBQLoginOne
    
#elif BBQLoginTwo
    
    
#elif BBQLoginThree
    
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
    
#if BBQLoginOne
    
#elif BBQLoginTwo
    
    self.textView.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.textView.layer.masksToBounds = false;
    
#elif BBQLoginThree
    
    
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
