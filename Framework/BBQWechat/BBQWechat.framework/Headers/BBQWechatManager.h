//
//  BBQWechatManager.h
//  ZWechat
//
//  Created by three stone 王 on 2019/8/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PayReq;

typedef NS_ENUM(NSInteger ,BBQWXActionType) {
    
    BBQWXActionTypeCancle NS_SWIFT_NAME(cancle) = 1,
    
    BBQWXActionTypeConfirm NS_SWIFT_NAME(confirm) = 2,
    
    BBQWXActionTypeRefused NS_SWIFT_NAME(refused) = 3,
    
    BBQWXActionTypeNone NS_SWIFT_NAME(none) = 4
};

typedef void(^BBQWXApiBlock)(BBQWXActionType type,NSString *_Nonnull msg);

NS_SWIFT_NAME(BBQWechat)
@interface BBQWechatManager : NSObject

+ (BOOL)initWithAppKey:(NSString *)appKey universalLink:(NSString * _Nullable)universalLink;

+ (void)wxLoginWithApiBlock:(BBQWXApiBlock )apiBlock;

+ (void)wxPayWithPayReq:(PayReq *_Nonnull)payReq andApiBlock:(BBQWXApiBlock )apiBlock;

+ (void)wxShareWithTitle:(NSString * _Nonnull)title
                 andDesc:(NSString * _Nonnull)desc
           andThumbImage:(NSString * _Nullable)thumbImage
           andWebPageUrl:(NSString * _Nullable)webpageUrl
                andScene:(int)scene
             andApiBlock:(BBQWXApiBlock )apiBlock;

+ (BOOL)handleOpenUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
