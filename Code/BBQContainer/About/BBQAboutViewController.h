//
//  BBQAboutViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//


#import "BBQConfig.h"
@import BBQBridge;
@import BBQTable;
NS_ASSUME_NONNULL_BEGIN

@interface BBQAboutTableHeaderView : BBQTableHeaderView

@end

@interface BBQAboutTableViewCell : BBQBaseTableViewCell

@property (nonatomic ,strong) BBQAboutBean *about;

@end

@interface BBQAboutViewController : BBQTableNoLoadingViewController

+ (instancetype)createAbout;

@end

NS_ASSUME_NONNULL_END
