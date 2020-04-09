//
//  BBQAMapViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//
#import <MAMapKit/MAMapKit.h>
@import BBQTransition;
NS_ASSUME_NONNULL_BEGIN

@class BBQAMapView;
@class BBQLocation;

NS_SWIFT_NAME(BBQAMapViewController)
@interface BBQAMapViewController : BBQTViewController <MAMapViewDelegate>

+ (instancetype)createAMapWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon;

@property (nonatomic ,strong ,readonly) BBQAMapView *bbqMapView;

@property (nonatomic ,strong ,readonly) BBQLocation *bbqLocation;

@property (nonatomic ,assign) CLLocationDegrees lat;

@property (nonatomic ,assign) CLLocationDegrees lon;

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation;

- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated;

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views;

- (void)bbqFetchLocaiton:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
