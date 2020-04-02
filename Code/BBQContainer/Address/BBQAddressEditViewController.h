//
//  BBQAddressEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import BBQTable;
#import "BBQConfig.h"
@import BBQBean;
@import BBQBridge;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,BBQAddressEditActionType) {
    
    BBQAddressEditActionTypeArea,
    
    BBQAddressEditActionTypeCompleted
};

typedef void(^BBQAddressEditBlock)(BBQBaseViewController *from,BBQAddressEditActionType actionType, BBQAddressBean *_Nullable addressBean ,BBQAddressEditBean *_Nullable addressEditBean);

@interface BBQAddressEditTableViewCell : BBQBaseTableViewCell


@end

@interface BBQAddressEditViewController : BBQTableNoLoadingViewController

+ (instancetype)creatAddressEditWithAddressBean:(BBQAddressBean *_Nullable)addressBean andAddressEditBlock:(BBQAddressEditBlock) block ;

- (void)updateAddressEditArea:(BBQAddressEditBean *) addressEditBean;

@end

NS_ASSUME_NONNULL_END
