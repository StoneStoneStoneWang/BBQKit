//
//  BBQNavigationController.h
//  ZNavi
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+BackgroundColor.h"
#import "UIBarButtonItem+BBQBBI.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBQNavigationConfig <NSObject>

@property (nonatomic ,assign) CGFloat BBQFontSize;

@property (nonatomic ,strong) UIColor *BBQNormalTitleColor;

@property (nonatomic ,strong) UIColor *BBQLoginTitleColor;

@property (nonatomic ,strong) UIColor *BBQNormalBackgroundColor;

@property (nonatomic ,strong) UIColor *BBQLoginBackgroundColor;

@property (nonatomic ,copy) NSString *BBQNormalBackImage;

@property (nonatomic ,copy) NSString *BBQLoginBackImage;

@end

@interface BBQNavigationController : UINavigationController

+ (void)initWithConfig:(id <BBQNavigationConfig>) config;

@end

NS_ASSUME_NONNULL_END
