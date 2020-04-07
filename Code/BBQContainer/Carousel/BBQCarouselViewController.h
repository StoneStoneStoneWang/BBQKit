//
//  BBQCarouselViewController.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "BBQConfig.h"
@import BBQCollection;

NS_ASSUME_NONNULL_BEGIN

@interface BBQCarouselViewController : BBQCollectionNoLoadingViewController

#if BBQCarouselTwo

+ (instancetype)createCarousel;
#elif BBQCarouselOne

+ (instancetype)createCarousel;
#elif BBQCarouselThree
+ (instancetype)createCarouselWithTitle:(NSString *)title;
#endif


@end

NS_ASSUME_NONNULL_END
