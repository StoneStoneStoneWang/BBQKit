//
//  BBQAreaHeaderViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//


#import "BBQConfig.h"
@import BBQCollection;
@import BBQBean;
NS_ASSUME_NONNULL_BEGIN

typedef void(^BBQAreaHeaderBlock)(BBQBaseViewController *from ,BBQAreaBean *pArea ,BBQAreaBean *cArea ,BBQAreaBean *_Nullable rArea);

@interface BBQAreaHeaderViewController : BBQCollectionNoLoadingViewController

+ (instancetype)createAreaHeaderWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger )rid andAreaHeaderBlock:(BBQAreaHeaderBlock) block;

@end

@interface BBQAreaPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

@interface BBQAreaDismissAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

NS_ASSUME_NONNULL_END
