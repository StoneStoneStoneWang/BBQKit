//
//  BBQFindPasswordViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQFindPasswordViewController.h"
@import BBQTextField;
@import SToolsKit;
@import Masonry;

@interface BBQFindPasswordViewController ()

@property (nonatomic ,strong) BBQFindPasswordBridge *bridge;

@property (nonatomic ,strong) BBQLeftImageTextField *phone;

@property (nonatomic ,strong) BBQVCodeImageTextField *vcode;

@property (nonatomic ,strong) BBQPasswordImageTextFiled *password;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) BBQFindPassworBlock block;
#if ZLoginFormOne

@property (nonatomic ,strong) UIView *topView;

@property (nonatomic ,strong) UIImageView *logoImgView;

#elif ZLoginFormTwo

#else

#endif
@end

@implementation BBQFindPasswordViewController

+ (instancetype)createPasswordWithBlock:(BBQFindPassworBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(BBQFindPassworBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (BBQLeftImageTextField *)phone {
    
    if (!_phone) {
        
        _phone = [[BBQLeftImageTextField alloc] initWithFrame:CGRectZero];
        
        _phone.tag = 201;
        
        _phone.leftImageName = @BBQPhoneIcon;
        
        _phone.placeholder = @"请输入11位手机号";
        
        [_phone set_editType:BBQTextFiledEditTypePhone];
        
        [_phone set_maxLength:11];
        
        [_phone set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
    }
    return _phone;
}

- (BBQVCodeImageTextField *)vcode {
    
    if (!_vcode) {
        
        _vcode = [[BBQVCodeImageTextField alloc] initWithFrame:CGRectZero];
        
        _vcode.tag = 202;
        
        _vcode.leftImageName = @BBQVCodeIcon;
        
        _vcode.placeholder = @"请输入6位验证码";
        
        [_vcode set_editType:BBQTextFiledEditTypeVcode_length6];
        
        [_vcode set_maxLength:6];
        
        [_vcode set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
    }
    return _vcode;
}

- (BBQPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[BBQPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 203;
        
        _password.normalIcon = @BBQPasswordNormalIcon;
        
        _password.selectedIcon = @BBQPasswordSelectIcon;
        
        _password.leftImageName = @BBQPasswordIcon;
        
        _password.placeholder = @"请输入6-18位密码";
        
        [_password set_editType:BBQTextFiledEditTypeSecret];
        
        [_password set_maxLength:18];
        
        [_password set_bottomLineColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
    }
    return _password;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 204;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@BBQColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@BBQColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.cornerRadius = 24;
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _completeItem;
}

- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.vcode];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.completeItem];
    
#if ZLoginFormOne
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.logoImgView];
#elif ZLoginFormTwo
    
#else
    
#endif
}

#if ZLoginFormOne

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

#elif ZLoginFormTwo

#else

#endif
- (void)configNaviItem {
    
#if ZLoginFormOne
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.title = @"忘记密码";
    
#elif ZLoginFormTwo
    
#else
    
#endif
}
- (void)configOwnSubViews {
    
#if ZLoginFormOne
    
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
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.topView.mas_bottom).offset(10);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    [self.phone set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@BBQColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@BBQColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.vcode set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    [self.password set_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
#elif ZLoginFormTwo
    
#else
    
#endif
    
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if ZLoginFormOne
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#elif ZLoginFormTwo
    
#else
    
#endif
}
- (void)configViewModel {
    
    self.bridge = [BBQFindPasswordBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createPassword:self passwordAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
}

- (BOOL)canPanResponse {
    
    return true ;
}


@end
