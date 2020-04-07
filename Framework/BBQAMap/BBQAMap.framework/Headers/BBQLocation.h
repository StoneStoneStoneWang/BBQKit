//
//  BBQLocation.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AMapLocationKit;
@import CoreLocation;

NS_ASSUME_NONNULL_BEGIN

typedef void(^BBQLocationBlock)(CLLocation *location);

@interface BBQLocation : NSObject

@property (nonatomic ,strong ,readonly) AMapLocationManager *bbqAmlocation;

@property (nonatomic ,strong ,readonly) CLLocationManager *cllocation;

- (void)requestLocationWithReGeocodeWithCompletionBlock:(AMapLocatingCompletionBlock)completionBlock;

@property (nonatomic ,assign) CLAuthorizationStatus authStatus;

// 开始定位
- (void)bbqStartLocation:(BBQLocationBlock )location;

// 停止定位
- (void)bbqStopLocation;

@end

NS_ASSUME_NONNULL_END
