//
//  BBQProtocolViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQProtocolViewController.h"

@interface BBQProtocolViewController ()

@property (nonatomic ,strong) BBQProtocolBridge *bridge;

@end

@implementation BBQProtocolViewController

+ (instancetype)createProtocol {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [BBQProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}

@end
