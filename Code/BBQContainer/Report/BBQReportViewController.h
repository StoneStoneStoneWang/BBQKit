//
//  BBQReportViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "BBQConfig.h"
#if BBQCONFIGURETYPECIRCLE

@import BBQTable;
@import BBQBridge;
NS_ASSUME_NONNULL_BEGIN

@interface BBQReportTableViewCell : BBQBaseTableViewCell

@property (nonatomic ,strong) BBQReportBean * reportBean;

@end

typedef void(^BBQReportBlock)(BBQBaseViewController *from);
@interface BBQReportViewController : BBQTableNoLoadingViewController

+ (instancetype)createReportWithUid:(NSString *)uid andEncode:(NSString *)encode andBlock:(BBQReportBlock) block;

@end


NS_ASSUME_NONNULL_END
#endif
