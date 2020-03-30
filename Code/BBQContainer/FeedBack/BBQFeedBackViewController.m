//
//  BBQFeedBackViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQFeedBackViewController.h"
@import Masonry;
@import SToolsKit;
@import BBQTextField;
@import JXTAlertManager;

@interface BBQFeedBackViewController ()

@property (nonatomic ,strong) UITextView *signaturetv;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) BBQFeedBackBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) UITextView *placeholder;

@property (nonatomic ,strong) UIView *whiteView;

@property (nonatomic ,strong) BBQNickNameTextField *textField;

@end

@implementation BBQFeedBackViewController

+ (instancetype)createFeedBack{
    
    return [self new];
}

- (BBQNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[BBQNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField bbq_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField bbq_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 201;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = @"请输入手机号";
        
        [_textField set_editType:BBQTextFiledEditTypePhone];
    }
    return _textField;
}

- (UIView *)whiteView {
    
    if (!_whiteView) {
        
        _whiteView = [UIView new];
        
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (UITextView *)signaturetv {
    
    if (!_signaturetv) {
        
        _signaturetv = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _signaturetv.font = [UIFont systemFontOfSize:15];
        
        _signaturetv.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _signaturetv.tag = 201;
        
        _signaturetv.backgroundColor = [UIColor clearColor];
    }
    return _signaturetv;
}
- (UITextView *)placeholder {
    
    if (!_placeholder) {
        
        _placeholder = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _placeholder.font = [UIFont systemFontOfSize:15];
        
        _placeholder.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _placeholder.tag = 202;
        
        _placeholder.backgroundColor = [UIColor whiteColor];
        
        _placeholder.userInteractionEnabled = false;
        
        _placeholder.text = @"请输入个性昵称";
        
        _placeholder.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _placeholder;
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
    
    [self.view addSubview:self.whiteView];
    
    [self.view addSubview:self.placeholder];
    
    [self.view addSubview:self.signaturetv];
    
    [self.view addSubview:self.textField];
}
- (void)configOwnSubViews {
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.equalTo(self.signaturetv.mas_bottom).offset(10);
        
        make.height.mas_equalTo(55);
    }];
}

- (void)configNaviItem {
    
    self.title = @"意见与建议";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
}

- (void)configViewModel {
    
    self.bridge = [BBQFeedBackBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createFeedBack:self feedBackAction:^{
        
        [weakSelf jxt_showAlertWithTitle:@"您的反馈非常重要,我们会尽快处理您的反馈" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.addActionDefaultTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            [weakSelf.navigationController popViewControllerAnimated:true];
        }];
    }];
    
}
- (void)configOwnProperties {
    
#if BBQBGNORMAL || BBQBGITEMFULL
    [super configOwnProperties];
    
#elif BBQBGFULL
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
#endif
    
#if BBQBGITEMFULL
    
    self.whiteView.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.placeholder.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.placeholder.textColor = [UIColor whiteColor];
    
    self.signaturetv.textColor = [UIColor whiteColor];
    
    self.textField.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.textField.textColor = [UIColor whiteColor];
    
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff90"],NSFontAttributeName: [UIFont systemFontOfSize:15]}];
#endif
}
@end
