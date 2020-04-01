//
//  BBQAreaViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "BBQAreaViewController.h"
@import Masonry;
@import SToolsKit;
@import BBQBean;

@interface BBQAreaTableViewCell : BBQBaseTableViewCell

@property (nonatomic ,strong) BBQAreaBean *areaBean;

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation BBQAreaTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
    
}
- (void)setAreaBean:(BBQAreaBean *)areaBean {
    _areaBean = areaBean;
    
    self.titleLabel.text = areaBean.name;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    if (areaBean.isSelected) {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@BBQColor];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        
        make.centerY.equalTo(self);
    }];
}
@end

@interface BBQAreaViewController()

@property (nonatomic ,assign) BBQAreaType type;

@property (nonatomic ,copy) BBQAreaBlock block;

@property (nonatomic ,strong) BBQAreaBridge *bridge;
@end

@implementation BBQAreaViewController

+ (instancetype)createAreaWithType:(BBQAreaType)type andAreaBlock:(BBQAreaBlock)block {
    
    return [[self alloc] initWithType:type andAreaBlock:block];
}
- (instancetype)initWithType:(BBQAreaType)type andAreaBlock:(BBQAreaBlock)block {
    
    if (self = [super init]) {
        
        self.type = type;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[BBQAreaTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}
- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    BBQAreaTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[BBQAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.areaBean = data;
    
    return cell;
}

- (void)selectedArea:(NSInteger )sid andBlock:(BBQAreaBlock)block {
    
    switch (self.type) {
        case BBQAreaTypeProvince:
            
            block(self, [self.bridge fetchAreaWithId:sid], self.type, [self.bridge fetchCitys:sid].count);
            break;
        case BBQAreaTypeCity:
            block(self, [self.bridge fetchAreaWithId:sid], self.type, [self.bridge fetchRegions:sid].count);
            break;
        default:
            break;
    }
}
- (void)updateAreas:(NSInteger )sid {
    
    [self.bridge updateDatas:sid areas:@[]];
}
- (void)configViewModel {
    
    self.bridge = [BBQAreaBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createArea:self type:self.type areaAction:^(BBQAreaBean * _Nonnull areaBean, enum BBQAreaType areaType, BOOL hasNext) {
       
        weakSelf.block(weakSelf, areaBean, areaType, hasNext);
    }];

}

- (BBQAreaBean *)fetchAreaWithId:(NSInteger)sid {
    
    return [self.bridge fetchAreaWithId:sid];
}

@end
