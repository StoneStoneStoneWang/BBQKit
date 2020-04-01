//
//  BBQAddressEditViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "BBQAddressEditViewController.h"
@import SToolsKit;
@import BBQBridge;
@import Masonry;
@import JXTAlertManager;
@import BBQTextField;

@protocol BBQAddressEditTableViewCellDelegate <NSObject>

- (void)onSwitchTap:(BOOL)value;

- (void)onTextChanged:(NSString *)changed andType:(BBQAddressEditType )type;

@end

@interface BBQAddressEditTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) BBQBaseTextField *subTitleLabel;

@property (nonatomic ,strong) BBQAddressEditBean *addressEdit;

@property (nonatomic ,strong) UISwitch *swi;

@property (nonatomic ,weak) id<BBQAddressEditTableViewCellDelegate> mDelegate;

@end

@implementation BBQAddressEditTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _titleLabel;
}

- (BBQBaseTextField *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [[BBQBaseTextField alloc] initWithFrame:CGRectZero];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _subTitleLabel;
}
- (UISwitch *)swi {
    
    if (!_swi) {
        
        _swi = [UISwitch new];
        
        _swi.on = true;
    }
    return _swi;
}
- (void)setAddressEdit:(BBQAddressEditBean *)addressEdit {
    _addressEdit = addressEdit;
    self.titleLabel.text = addressEdit.title;
    
    self.bottomLineType = BBQBottomLineTypeNormal;
    
    self.subTitleLabel.placeholder = addressEdit.placeholder;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.subTitleLabel.userInteractionEnabled = true;
    
    self.subTitleLabel.text = addressEdit.value;
    
    self.swi.hidden = true;
    
    [self.subTitleLabel set_editType:BBQTextFiledEditTypeDefault];
    
    [self.subTitleLabel set_maxLength:999];
    
    switch (addressEdit.type) {
        case BBQAddressEditTypeName:
            
            
            break;
        case BBQAddressEditTypeDef:
            
            self.subTitleLabel.userInteractionEnabled = false;
            
            self.swi.hidden = false;
            
            break;
        case BBQAddressEditTypeArea:
            
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            self.subTitleLabel.userInteractionEnabled = false;
            
            NSLog(@"name =%@======" ,addressEdit.rArea.name);
            
            if (addressEdit.rArea.name && ![addressEdit.rArea.name isEqualToString:@""]) {
                
                self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@%@",addressEdit.pArea.name,addressEdit.cArea.name,addressEdit.rArea.name];
                
            } else {
                
                self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@",addressEdit.pArea.name,addressEdit.cArea.name];
                
            }
            break;
        case BBQAddressEditTypePhone:
            
            [self.subTitleLabel set_editType:BBQTextFiledEditTypePhone];
            
            [self.subTitleLabel set_maxLength:11];
            break;
        default:
            break;
    }
    
}


- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.swi];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.swi addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) weakSelf = self;
    
    [self.subTitleLabel set_textChanged:^(BBQBaseTextField * _Nonnull tf) {
        
        [weakSelf.mDelegate onTextChanged:tf.text andType:weakSelf.addressEdit.type];
    }];
    
}

- (void)onSwitchValueChanged:(UISwitch *)swi {
    
    [self.mDelegate onSwitchTap:swi.isOn];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.width.mas_equalTo(CGRectGetWidth(self.bounds) / 2);
        
        make.centerY.equalTo(self);
    }];
    
    [self.swi mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
        
        make.width.mas_equalTo(50);
        
        make.height.mas_equalTo(25);
    }];
}

@end

@interface BBQAddressEditViewController() <BBQAddressEditTableViewCellDelegate>

@property (nonatomic ,strong) BBQAddressEditBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) BBQAddressBean *addressBean;

@property (nonatomic ,copy) BBQAddressEditBlock block;

@end

@implementation BBQAddressEditViewController

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
+ (instancetype)creatAddressEditWithAddressBean:(BBQAddressBean *)addressBean andAddressEditBlock:(BBQAddressEditBlock)block {
    
    return [[self alloc] initWithAddressBean:addressBean andAddressEditBlock:block];
}
- (instancetype)initWithAddressBean:(BBQAddressBean *)addressBean andAddressEditBlock:(BBQAddressEditBlock)block {
    
    if (self = [super init]) {
        
        self.addressBean = addressBean;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[BBQAddressEditTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    BBQAddressEditTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[BBQAddressEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.addressEdit = data;
    
    cell.mDelegate = self;
    
    return cell;
    
}
- (void)onSwitchTap:(BOOL)value {
    
    [self.bridge updateAddressEditDefWithIsDef:value];
}
- (void)onTextChanged:(NSString *)changed andType:(BBQAddressEditType)type {
    
    [self.bridge updateAddressEditWithType:type value:changed];
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    BBQAddressEditBean *edit = (BBQAddressEditBean *)data;
    
    switch (edit.type) {
        case BBQAddressEditTypeArea:
        {
            self.block(self, BBQAddressEditActionTypeArea,self.addressBean, edit);
        }
            break;
            
        default:
            break;
    }
}
- (void)updateAddressEditArea:(BBQAddressEditBean *)addressEditBean {
    
    [self updatePArea:addressEditBean.pArea andCArea:addressEditBean.cArea andRArea:addressEditBean.rArea];
}
- (void)updatePArea:(BBQAreaBean *)pArea andCArea:(BBQAreaBean *)cArea andRArea:(BBQAreaBean *)rArea {
    
    [self.bridge updateAddressEditAreaWithPid:pArea.areaId pName:pArea.name cid:cArea.areaId cName:cArea.name rid:rArea.areaId rName:rArea.name];
}
- (void)configNaviItem {
    
    self.title = self.addressBean ? @"编辑地址" : @"新增地址";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
}
- (void)configViewModel {
    
    self.bridge = [BBQAddressEditBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createAddressEdit:self temp:self.addressBean editAction:^(BBQAddressBean * _Nullable addressBean) {
        
        weakSelf.block(weakSelf,BBQAddressEditActionTypeCompleted, addressBean, nil);
    }];
    
    if (self.addressBean) {
        
        [self.bridge updateAddressEditDefWithIsDef:self.addressBean.isdel];
        
        [self.bridge updateAddressEditWithType:BBQAddressEditTypeName value:self.addressBean.name];
        
        [self.bridge updateAddressEditWithType:BBQAddressEditTypePhone value:self.addressBean.phone];
        
        [self.bridge updateAddressEditWithType:BBQAddressEditTypeDetail value:self.addressBean.addr];
        
        [self.bridge updateAddressEditAreaWithPid:self.addressBean.plcl pName:self.addressBean.plclne cid:self.addressBean.city cName:self.addressBean.cityne rid:self.addressBean.region rName:self.addressBean.regionne];
        
        [self.tableView reloadData];
    }
    
}
@end
