//
//  BBQSignConfig.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#pragma mark ---- BBQSign

#define BBQAPPKEY "e4b3ad47f0ad45808d6b742482bde513"

#define BBQDOMAIN "http://zhihw.ecsoi.com/"

#pragma mark ---- 圈子类型
#define BBQCONFIGURETYPECIRCLE 0
#pragma mark ---- 商城类型
#define BBQCONFIGURETYPESTORE 0
#pragma mark ---- 游戏类型
#define BBQCONFIGURETYPEGAME 1
#pragma mark ---- 地图类型
#define BBQCONFIGURETYPEMAP 0

#if BBQCONFIGURETYPECIRCLE

#define BBQCONFIGURETYPE BBQConfigureTypeCircle

#elif BBQCONFIGURETYPESTORE

#define BBQCONFIGURETYPE BBQConfigureTypeStore

#elif BBQCONFIGURETYPEGAME

#define BBQCONFIGURETYPE BBQConfigureTypeGame
#else

#define BBQCONFIGURETYPE BBQConfigureTypeMap

#endif


