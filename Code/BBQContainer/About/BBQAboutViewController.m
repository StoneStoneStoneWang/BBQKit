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
@end

@implementation BBQAboutTableHeaderView

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
    
#if BBQBGNORMAL || BBQBGFULL
    
    self.backgroundColor = [UIColor whiteColor];
#elif BBQBGITEMFULL
    
    self.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.titleLabel.textColor = [UIColor whiteColor];
#endif
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
    
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
#if BBQBGNORMAL || BBQBGFULL
    
#elif BBQBGITEMFULL
    
    self.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.subTitleLabel.textColor = [UIColor whiteColor];
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
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@BBQColor]];
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[BBQAboutTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headerView = [[BBQAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
    
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
    
    [self.bridge createAbout:self];
}

- (void)configNaviItem {
    
    self.title = @"关于我们";
}

- (BOOL)canPanResponse {
    
    return true;
}
- (void)configOwnProperties {
    
#if BBQBGNORMAL || BBQBGITEMFULL
    [super configOwnProperties];
    
#elif BBQBGFULL
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    
#endif
}
@end
