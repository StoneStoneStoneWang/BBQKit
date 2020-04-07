//
//  BBQSearch.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AMapSearchKit;

NS_ASSUME_NONNULL_BEGIN

typedef void(^BBQRegeoSearchBlock)(NSString *city,NSString *street);

typedef void(^BBQTipSearchBlock)(NSArray<AMapTip *> *tips);

@interface BBQSearch : NSObject

- (void)bbqGeoSearchResp:(AMapGeoPoint *)location andResp:(BBQRegeoSearchBlock) resp;

/* 根据关键字来搜索POI. */
- (void)onTipSearchRespWithKeywords:(NSString *) keywords andCity:(NSString *)city andResp:(BBQTipSearchBlock) resp;

/* 根据ID来搜索POI. */
- (void)bbqTipSearchRespWithID:(NSString *)uid;

@property (nonatomic ,strong ,readonly) AMapSearchAPI *searchApi;

@end

NS_ASSUME_NONNULL_END
