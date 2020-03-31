//
//  BBQNameViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQNameViewController.h"
@import Masonry;
@import SToolsKit;
@import BBQTextField;

@interface BBQNameViewController ()

@property (nonatomic ,strong) BBQNickNameTextField *textField;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) BBQNameBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) BBQNameBlock block;

@end

@implementation BBQNameViewController

+ (instancetype)createNickname:(BBQNameBlock)block {
    
    return [[self alloc] initWithBlock:block];
    
}
- (instancetype)initWithBlock:(BBQNameBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (BBQNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[BBQNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField bbq_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField bbq_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 201;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = @"请输入昵称";
    }
    return _textField;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        if ([@BBQColor isEqualToString:@"#ffffff"]) {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666680"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666650"] forState:UIControlStateDisabled];
            
        } else {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"] forState:UIControlStateDisabled];
        }
    }
    return _completeItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backItem;
}
- (void)addOwnSubViews {
    
    [self.view addSubview:self.textField];
    
}
- (void)configOwnSubViews {
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD);
        
        make.height.mas_equalTo(48);
    }];
}

- (void)configNaviItem {
    
    self.title = @"修改昵称";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
    [self.backItem setImage:[UIImage imageNamed:@BBQBackIcon] forState:UIControlStateNormal];
    
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
}
- (void)configViewModel {
    
    self.bridge = [BBQNameBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createName:self nameAction:^(enum BBQNameActionType actionType) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf ;
        
        strongSelf.block(actionType, strongSelf);
    }];
}
- (void)configOwnProperties {
    
#if BBQNameOne
    [super configOwnProperties];
    
#elif BBQNameTwo
    
//    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
#endif
    
//#if BBQBGITEMFULL
//
//    self.textField.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
//
//    self.textField.textColor = [UIColor whiteColor];
//
//    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入昵称" attributes:@{NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"],NSFontAttributeName: [UIFont systemFontOfSize:15]}];
//
//#endif
    
}
@end
