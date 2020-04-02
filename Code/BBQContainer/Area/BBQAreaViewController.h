//
//  BBQAreaViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import BBQTable;
@import BBQBridge;
#import "BBQConfig.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^BBQAreaBlock)(BBQBaseViewController *from ,BBQAreaBean *selectedArea ,BBQAreaType type ,BOOL hasNext);

@interface BBQAreaViewController : BBQTableNoLoadingViewController

+ (instancetype)createAreaWithType:(BBQAreaType )type andAreaBlock:(BBQAreaBlock) block;

- (void)selectedArea:(NSInteger )sid andBlock:(BBQAreaBlock)block;

- (void)updateAreas:(NSInteger )sid ;

- (BBQAreaBean *)fetchAreaWithId:(NSInteger)sid ;
@end

NS_ASSUME_NONNULL_END
