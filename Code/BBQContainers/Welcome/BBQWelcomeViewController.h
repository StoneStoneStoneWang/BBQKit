//
//  BBQWelcomeViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

@import BBQCollection;
#import "BBQConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface BBQWelcomeCollectionViewCell : UICollectionViewCell

@property (nonatomic ,copy) NSString *icon;

@end

typedef void(^BBQWelcomeBlock)(BBQBaseViewController *from);

@interface BBQWelcomeViewController : BBQCollectionNoLoadingViewController

+ (instancetype)createWelcomeWithSkipBlock:(BBQWelcomeBlock )block;

@end

NS_ASSUME_NONNULL_END
