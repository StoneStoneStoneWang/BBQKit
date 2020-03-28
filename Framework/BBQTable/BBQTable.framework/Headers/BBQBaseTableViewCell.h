//
//  BBQBaseTableViewCell.h
//  ZTable
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,BBQBottomLineType) {
    
    BBQBottomLineTypeNormal NS_SWIFT_NAME(normal),
    
    BBQBottomLineTypeNone NS_SWIFT_NAME(none) ,
    
    BBQBottomLineTypeCustom NS_SWIFT_NAME(custom)
};

@interface BBQBaseTableViewCell : UITableViewCell

@property (nonatomic ,strong ,readonly) UIImageView *bottomView;

@property (nonatomic ,assign) BBQBottomLineType bottomLineType;

- (void)commitInit;
@end

NS_ASSUME_NONNULL_END
