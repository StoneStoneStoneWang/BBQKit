//
//  BBQSettingViewController.m
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQSettingViewController.h"
@interface ZSettingTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UISwitch *swiItem;
@end

@implementation ZSettingTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _titleLabel;
}
- (UISwitch *)swiItem {
    if (!_swiItem) {
        
        _swiItem = [[UISwitch alloc] initWithFrame:CGRectZero];
        
        _swiItem.onTintColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
        
    }
    return _swiItem;
}
- (void)setSetting:(ZSettingBean *)setting {
    //    _setting = setting;
    
    self.swiItem.hidden = true;
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.titleLabel.textColor =  [UIColor s_transformToColorByHexColorStr:@"#333333"];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.bottomLineType = ZBottomLineTypeNormal;
    
    self.backgroundColor = [UIColor whiteColor];
    
    switch (setting.type) {
        case ZSettingTypeLogout:
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.titleLabel.textColor =  [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
            break;
        case ZSettingTypeSpace:
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.bottomLineType = ZBottomLineTypeNone;
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
        case ZSettingTypePush:
            
            self.swiItem.hidden = false;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
        default:
            break;
    }
    
    self.titleLabel.text = setting.title;
}


- (void)commitInit {
    [super commitInit];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.swiItem];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
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

@property (nonatomic ,strong) ZSettingBridge *bridge;

@property (nonatomic ,copy) ZSettingBlock block;

@end

@implementation BBQSettingViewController

+ (instancetype)createSettingWithBlock:(ZSettingBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(ZSettingBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZSettingTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZSettingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.setting = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZSettingBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createSetting:self settingAction:^(enum ZSettingActionType type, ZBaseViewController * _Nonnull vc) {
        
        weakSelf.block(type, vc);
    }];
}

- (void)configNaviItem {
    
    self.title = @"设置";
}
- (BOOL)canPanResponse {
    
    return true;
}

@end
