//
//  BBQModifyPasswordViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQModifyPasswordViewController.h"
@import BBQTextField;
@import SToolsKit;
@import Masonry;

@interface BBQModifyPasswordViewController ()
@property (nonatomic ,strong) BBQModifyPasswordBridge *bridge;

@property (nonatomic ,strong) BBQPasswordImageTextFiled *oldpassword;

@property (nonatomic ,strong) BBQPasswordImageTextFiled *password;

@property (nonatomic ,strong) BBQPasswordImageTextFiled *againpassword;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) BBQModifyPasswordBlock block;
#if BBQLoginOne

@property (nonatomic ,strong) UIView *topView;

@property (nonatomic ,strong) UIImageView *logoImgView;

#elif BBQLoginTwo

@property (nonatomic ,strong) UIImageView *logoImgView;

#else

#endif
@end

@implementation BBQModifyPasswordViewController

+ (instancetype)createPasswordWithBlock:(BBQModifyPasswordBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(BBQModifyPasswordBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (BBQPasswordImageTextFiled *)oldpassword {
    
    if (!_oldpassword) {
        
        _oldpassword = [[BBQPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _oldpassword.tag = 201;
        
        _oldpassword.leftImageName = @BBQPasswordIcon;
        
        _oldpassword.placeholder = @"请输入6-18位旧密码";
        
        _oldpassword.normalIcon = @BBQPasswordNormalIcon;
        
        _oldpassword.selectedIcon = @BBQPasswordSelectIcon;
        
        _oldpassword.leftImageName = @BBQPasswordIcon;
        
        [_oldpassword set_editType:BBQTextFiledEditTypeSecret];
        
        [_oldpassword set_maxLength:18];
        
        [_oldpassword set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
    }
    return _oldpassword;
}
- (BBQPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[BBQPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.leftImageName = @BBQPasswordIcon;
        
        _password.placeholder = @"请输入6-18位新密码";
        
        _password.normalIcon = @BBQPasswordNormalIcon;
        
        _password.selectedIcon = @BBQPasswordSelectIcon;
        
        _password.leftImageName = @BBQPasswordIcon;
        
        [_password set_editType:BBQTextFiledEditTypeSecret];
        
        [_password set_maxLength:18];
        
        [_password set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
    }
    return _password;
}

- (BBQPasswordImageTextFiled *)againpassword {
    
    if (!_againpassword) {
        
        _againpassword = [[BBQPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _againpassword.tag = 203;
        
        _againpassword.leftImageName = @BBQPasswordIcon;
        
        _againpassword.placeholder = @"请输入6-18位确认密码";
        
        _againpassword.normalIcon = @BBQPasswordNormalIcon;
        
        _againpassword.selectedIcon = @BBQPasswordSelectIcon;
        
        _againpassword.leftImageName = @BBQPasswordIcon;
        
        [_againpassword set_editType:BBQTextFiledEditTypeSecret];
        
        [_againpassword set_maxLength:18];
        
        [_againpassword set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
    }
    return _againpassword;
}


- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 204;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@BBQColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@BBQColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.cornerRadius = 24;
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _completeItem;
}

- (void)addOwnSubViews {
    
    [self.view addSubview:self.oldpassword];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.againpassword];
    
    [self.view addSubview:self.completeItem];
    
#if BBQLoginOne
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.logoImgView];
#elif BBQLoginTwo
    
    [self.view addSubview:self.logoImgView];
#else
    
#endif
}

#if BBQLoginOne

- (UIView *)topView {
    
    if (!_topView) {
        
        _topView = [UIView new];
        
        _topView.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    }
    return _topView;
}

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@BBQLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@BBQColor].CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}

#elif BBQLoginTwo
- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@BBQLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@BBQColor].CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
#else

#endif
- (void)configNaviItem {
    
#if BBQLoginOne
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.title = @"忘记密码";
    
#elif BBQLoginTwo
    
#else
    
#endif
}
- (void)configOwnSubViews {
    
#if BBQLoginOne
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.mas_equalTo(@0);
        
        make.height.mas_equalTo(@(w / 2));
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.topView.mas_centerX);
        
        make.centerY.mas_equalTo(self.topView.mas_centerY);
        
        make.width.height.mas_equalTo(@80);
    }];
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.topView.mas_bottom).offset(10);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    [self.oldpassword set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    [self.password set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    [self.againpassword set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.againpassword.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
        
    }];
    
#elif BBQLoginTwo
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(60);
        
        make.width.height.mas_equalTo(@80);
    }];
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(60);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    self.oldpassword.layer.cornerRadius = 24;
    
    self.oldpassword.layer.masksToBounds = true;
    
    [self.oldpassword set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    self.againpassword.layer.cornerRadius = 24;
    
    self.againpassword.layer.masksToBounds = true;
    
    [self.againpassword set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.againpassword.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@BBQColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@BBQColor]] forState:UIControlStateHighlighted];
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#else
    
#endif
    
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if BBQLoginOne
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#elif BBQLoginTwo
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
#else
    
#endif
}
- (void)configViewModel {
    
    self.bridge = [BBQModifyPasswordBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createPassword:self passwordAction:^{
        
        weakSelf.block(weakSelf);
    }];
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
