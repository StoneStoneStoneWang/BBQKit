//
//  BBQSettingViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQSettingViewController.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;

@interface BBQSettingTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UISwitch *swiItem;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end

@implementation BBQSettingTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _subTitleLabel;
}
- (UISwitch *)swiItem {
    if (!_swiItem) {
        
        _swiItem = [[UISwitch alloc] initWithFrame:CGRectZero];
        
        _swiItem.onTintColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
        
    }
    return _swiItem;
}
- (void)setSetting:(BBQSettingBean *)setting {
    //    _setting = setting;
    
    self.swiItem.hidden = true;
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.titleLabel.textColor =  [UIColor s_transformToColorByHexColorStr:@"#333333"];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.bottomLineType = BBQBottomLineTypeNormal;
    
    self.subTitleLabel.hidden = true;
    
    self.subTitleLabel.text = setting.subTitle;
    
    self.backgroundColor = [UIColor whiteColor];
    
    switch (setting.type) {
        case BBQSettingTypeLogout:
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.titleLabel.textColor =  [UIColor s_transformToColorByHexColorStr:@BBQColor];
            break;
        case BBQSettingTypeSpace:
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.bottomLineType = BBQBottomLineTypeNone;
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
        case BBQSettingTypePush:
            
            self.swiItem.hidden = false;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
        case BBQSettingTypeClear:
            
            self.subTitleLabel.hidden = false;
            
        default:
            break;
    }
    
    self.titleLabel.text = setting.title;
    
#if BBQUserInfoOne
    
#elif BBQUserInfoTwo
    
#elif BBQUserInfoThree
    
    if (setting.type == BBQSettingTypeSpace) {
        
        self.backgroundColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
    } else {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
#endif

}


- (void)commitInit {
    [super commitInit];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.swiItem];
    
    [self.contentView addSubview:self.subTitleLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.swiItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
@end
@interface BBQSettingViewController ()

@property (nonatomic ,strong) BBQSettingBridge *bridge;

@property (nonatomic ,copy) BBQSettingBlock block;

@end

@implementation BBQSettingViewController

+ (instancetype)createSettingWithBlock:(BBQSettingBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(BBQSettingBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
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
    
    [self.tableView registerClass:[BBQSettingTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    BBQSettingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.setting = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [BBQSettingBridge new];
    
    __weak typeof(self) weakSelf = self;
    
#if BBQUserInfoOne
    [self.bridge createSetting:self hasPlace:true settingAction:^(enum BBQSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#elif BBQUserInfoTwo
    [self.bridge createSetting:self hasPlace:false settingAction:^(enum BBQSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#elif BBQUserInfoThree
    
    [self.bridge createSetting:self hasPlace:true settingAction:^(enum BBQSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#endif
    
    [self updateCache];
}

- (void)updateTableData {
    
    [self.bridge updateTableData:true];
    
    [self updateCache];
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
- (void)updateCache {
    
    NSString *cache = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0];
    
    [self.bridge updateCache:cache];
}
- (void)configNaviItem {
    
    self.title = @"设置";
}
- (BOOL)canPanResponse {
    
    return true;
}

@end
