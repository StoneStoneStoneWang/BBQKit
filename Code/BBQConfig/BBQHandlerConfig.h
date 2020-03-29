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


