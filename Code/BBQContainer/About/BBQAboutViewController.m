//
//  BBQAboutViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQAboutViewController.h"
@import SToolsKit;
@import Masonry;
@interface BBQAboutTableHeaderView()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *titleLabel;
#if BBQUserInfoOne

#elif BBQUserInfoTwo

#elif BBQUserInfoThree

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;
#endif


@end

@implementation BBQAboutTableHeaderView

#if BBQUserInfoOne

#elif BBQUserInfoTwo

#elif BBQUserInfoThree

- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
    }
    return _bottomLine;
}
#endif


- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @BBQLogoIcon]];
        
        _iconImageView.layer.cornerRadius = 30;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
        
        _titleLabel.text = [NSString stringWithFormat:@"%@: %@", [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"],[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        
    }
    return _titleLabel;
}
- (void)commitInit {
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.titleLabel];
    
    
#if BBQUserInfoOne
    self.backgroundColor = [UIColor whiteColor];
#elif BBQUserInfoTwo
    self.backgroundColor = [UIColor whiteColor];
#elif BBQUserInfoThree
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.topLine];
    
    [self addSubview:self.bottomLine];
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.bottomLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
#endif
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
#if BBQUserInfoOne
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
#elif BBQUserInfoTwo
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
#elif BBQUserInfoThree
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(@60);
        
        make.centerX.equalTo(self);
        
        make.top.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.bottom.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(8);
        
        make.top.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(8);
        
        make.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
    }];
#endif
}

@end
@interface BBQAboutTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end


@implementation BBQAboutTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _subTitleLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
}
- (void)setAbout:(BBQAboutBean *)about {
    
    self.titleLabel.text = about.title;
    
    self.subTitleLabel.text = about.subTitle;
    
    self.bottomLineType = BBQBottomLineTypeNormal;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (about.type == BBQAboutTypeSpace) {
        
        self.bottomLineType = BBQBottomLineTypeNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
#if BBQUserInfoOne
    
#elif BBQUserInfoTwo
    
#elif BBQUserInfoThree
    
    
#endif
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(15);
        
        make.centerY.equalTo(self);
    }];
}
@end

@interface BBQAboutViewController ()

@property (nonatomic ,strong) BBQAboutBridge *bridge;

@end

@implementation BBQAboutViewController

+ (instancetype)createAbout {
    
    return [self new];
}
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
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[BBQAboutTableViewCell class] forCellReuseIdentifier:@"cell"];
    
#if BBQUserInfoOne
    self.headerView = [[BBQAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
#elif BBQUserInfoTwo
    self.headerView = [[BBQAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
#elif BBQUserInfoThree
    self.headerView = [[BBQAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
#endif
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    BBQAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.about = data;
    
    cell.bottomLineType = BBQBottomLineTypeNormal;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [BBQAboutBridge new];
#if BBQUserInfoOne
    [self.bridge createAbout:self hasPlace:true];
#elif BBQUserInfoTwo
    [self.bridge createAbout:self hasPlace:true];
#elif BBQUserInfoThree
    [self.bridge createAbout:self hasPlace:false];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"关于我们";
}

- (BOOL)canPanResponse {
    
    return true;
}
- (void)configOwnProperties {
    
#if BBQUserInfoOne
    [super configOwnProperties];
#elif BBQUserInfoTwo
    [super configOwnProperties];
#elif BBQUserInfoThree
    [super configOwnProperties];
#endif
    
}
@end
