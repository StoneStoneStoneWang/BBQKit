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

+ (instancetype)createProtocol {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [BBQProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}

- (void)configOwnProperties {
    [super configOwnProperties];
    
#if BBQLoginOne
    
#elif BBQLoginTwo
    
    self.textView.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.textView.layer.masksToBounds = false;
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
