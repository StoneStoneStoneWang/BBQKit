//
//  BBQHandlerConfig.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "BBQSignConfig.h"

#if DEBUG

#else

#define BBQWelcomeCollectionViewCell BBQWelcomeCollectionViewCell111

#define BBQWelcomeViewController BBQWelcomeViewController111

#define BBQRootManager BBQRootManager111

#define BBQNavigationConfigImpl BBQNavigationConfigImpl111

#define RootManager RootManager111

#define makeRoot makeRoot111

#define bbqSkipTap bbqSkipTap111

#define rootShared rootShared111

#define bbqUnLogin bbqUnLogin11

#define bbqPresentLogin bbqPresentLogin111

#define bbqRootViewController bbqRootViewController11


#define BBQLoginBlock BBQLoginBlock111

#define createLoginWithBlock createLoginWithBlock111

#define BBQLoginViewController BBQLoginViewController111

#define BBQRegBlock BBQRegBlock111

#define BBQRegViewController BBQRegViewController111

#define createRegWithBlock createRegWithBlock111

#define createProtocol createProtocol111

#define BBQProtocolViewController BBQProtocolViewController111

#define BBQFindPassworBlock BBQFindPassworBlock111

#define BBQFindPasswordViewController BBQFindPasswordViewController111

#define createPasswordWithBlock createPasswordWithBlock111

#define BBQModifyPasswordBlock BBQModifyPasswordBlock111

#define BBQModifyPasswordViewController BBQModifyPasswordViewController111

#pragma mark ---- 圈子类型
#if BBQCONFIGURETYPECIRCLE

#pragma mark ---- 商城类型
#elif BBQCONFIGURETYPESTORE


#pragma mark ---- 游戏类型
#elif BBQCONFIGURETYPEGAME


#pragma mark ---- 地图类型
#else



#endif
#endif


