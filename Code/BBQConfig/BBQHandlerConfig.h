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

#define bbqPushReg bbqPushReg111

#define bbqPushProtocol bbqPushProtocol111

#define bbqPushFindPassword bbqPushFindPassword111

#define bbqPushModifyPassword bbqPushModifyPassword111

#define bbqPushSetting bbqPushSetting111

#define bbqPushUserInfo bbqPushUserInfo1111

#define bbqPushName bbqPushName111

#define bbqPushSignature bbqPushSignature111

#define bbqLogout bbqLogout111

#define bbqDismiss bbqDismiss111

#define bbqPop bbqPop111

#define bbqTokenInvalid bbqTokenInvalid111

#define bbqCheckLogin bbqCheckLogin1111

#define bbqCreateProfile bbqCreateProfile111

#define bbqPushPrivacy bbqPushPrivacy111

#define bbqPushAbout bbqPushAbout111

#define bbqPushFeedBack bbqPushFeedBack111

#define bbqCreateCarousel bbqCreateCarousel1111

#define bbqPushReport bbqPushReport111

#if BBQCONFIGURETYPEGAME

#define bbqPushCharacters bbqPushCharacters111

#endif

#if BBQCONFIGURETYPESTORE

#define bbqPushAddress bbqPushAddress111

#define bbqPushAddressSelected bbqPushAddressSelected111

#define bbqPushAddressEdit bbqPushAddressEdit111

#define bbqPushAddressEditAdd bbqPushAddressEditAdd111

#define bbqPushArea bbqPushArea111

#define BBQAddressViewController BBQAddressViewController111

#define createAddressWithBlock createAddressWithBlock1111

#define BBQAddressBlock BBQAddressBlock111

#define BBQAddressSelectedViewController BBQAddressSelectedViewController111

#define BBQAddressSelectedBlock BBQAddressSelectedBlock111

#define createAddressSelectedWithBlock createAddressSelectedWithBlock111

#define BBQAddressTableViewCell BBQAddressTableViewCell111

#define BBQAddressSelectedTableViewCell BBQAddressSelectedTableViewCell111
#define updateAddress updateAddress111
#define insertAddress insertAddress111
#define BBQAddressEditBlock BBQAddressEditBlock111
#define BBQAddressEditActionType BBQAddressEditActionType111
#define BBQAddressEditViewController BBQAddressEditViewController111
#define creatAddressEditWithAddressBean creatAddressEditWithAddressBean111
#define updateAddressEditArea updateAddressEditArea111
#endif


#define BBQLoginBlock BBQLoginBlock111

#define createLoginWithBlock createLoginWithBlock111

#define BBQLoginViewController BBQLoginViewController111

#define BBQRegBlock BBQRegBlock111

#define BBQRegViewController BBQRegViewController111

#define createRegWithBlock createRegWithBlock111

#define BBQProtocolViewController BBQProtocolViewController111

#define BBQFindPassworBlock BBQFindPassworBlock111

#define BBQFindPasswordViewController BBQFindPasswordViewController111

#define createPasswordWithBlock createPasswordWithBlock111

#define BBQModifyPasswordBlock BBQModifyPasswordBlock111

#define BBQModifyPasswordViewController BBQModifyPasswordViewController111

#define BBQSettingTableViewCell BBQSettingTableViewCell111

#define BBQSettingBlock BBQSettingBlock111

#define BBQSettingViewController BBQSettingViewController111

#define createSettingWithBlock createSettingWithBlock111

#define BBQUserInfoActionType BBQUserInfoActionType111

#define BBQUserInfoBlock BBQUserInfoBlock111

#define BBQUserInfoViewController BBQUserInfoViewController111

#define BBQUserInfoTableViewCell BBQUserInfoTableViewCell111

#define createUserInfoWithBlock createUserInfoWithBlock111

#define BBQFeedBackViewController BBQFeedBackViewController111

#define BBQAboutViewController BBQAboutViewController111

#define BBQAboutTableHeaderView BBQAboutTableHeaderView111

#define BBQAboutTableViewCell BBQAboutTableViewCell111

#define BBQReportViewController BBQReportViewController111

#define BBQReportTableViewCell BBQReportTableViewCell111

#define BBQReportBlock BBQReportBlock111

#define BBQCarouselViewController BBQCarouselViewController111

#define BBQCarouselFormTwoLayout BBQCarouselFormTwoLayout111

#define BBQCarouselFormOneLayout BBQCarouselFormOneLayout111

#define BBQCarouselCollectionViewCell BBQCarouselCollectionViewCell111

#define BBQUserCenterCollectionViewCell BBQUserCenterCollectionViewCell111

#define BBQUserCentereBlock BBQUserCentereBlock111

#define BBQUserCenterViewController BBQUserCenterViewController111

#define createUserCenterWithBlock createUserCenterWithBlock111

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


