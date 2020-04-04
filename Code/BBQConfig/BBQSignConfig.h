//
//  BBQSignConfig.h
//  BBQContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#pragma mark ---- BBQSign

#define BBQAPPKEY "0710462304994b6a848f6ae1ec460548"

#define BBQDOMAIN "http://zhihw.ecsoi.com/"

#pragma mark ---- 圈子类型
#define BBQCONFIGURETYPECIRCLE 0
#pragma mark ---- 商城类型
#define BBQCONFIGURETYPESTORE 1
#pragma mark ---- 游戏类型
#define BBQCONFIGURETYPEGAME 0
#pragma mark ---- 地图类型
#define BBQCONFIGURETYPEMAP 0

#define BBQCONFIGURETYPESTOREANDCIRCLE 0

#if BBQCONFIGURETYPECIRCLE

#define BBQCONFIGURETYPE BBQConfigureTypeCircle

#elif BBQCONFIGURETYPESTORE

#define BBQCONFIGURETYPE BBQConfigureTypeStore

#elif BBQCONFIGURETYPEGAME

#define BBQCONFIGURETYPE BBQConfigureTypeGame

#elif BBQCONFIGURETYPESTOREANDCIRCLE

#define BBQCONFIGURETYPE BBQConfigureTypeStoreAndCircle

#else

#define BBQCONFIGURETYPE BBQConfigureTypeMap
#endif


