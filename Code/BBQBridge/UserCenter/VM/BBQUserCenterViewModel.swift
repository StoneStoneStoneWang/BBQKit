//
//  BBQUserCenterViewModel.swift
//  BBQBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import BBQBean
import BBQSign
import BBQApi
import BBQRReq
import BBQCache

@objc public final class BBQUserCenterBean: NSObject {
    
    @objc public var type: BBQUserCenterType = .userInfo
    
    @objc public var title: String = ""
    
    @objc public static func createUserCenter(_ type: BBQUserCenterType ,title: String) -> BBQUserCenterBean {
        
        let profile = BBQUserCenterBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    
    static public func createUserCenterTypes() -> [BBQUserCenterBean] {
        
        var result: [BBQUserCenterBean] = []
        
        for item in BBQUserCenterType.types {
            
            result += [BBQUserCenterBean.createUserCenter(item, title: item.title)]
        }
        
        return result
    }
    private override init() {
        
    }
}

@objc (BBQUserCenterType)
public enum BBQUserCenterType : Int{
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case myCircle
    
    case order
    
    case address
    
    case characters
    
    case feedBack
}

extension BBQUserCenterType {
    
    static var types: [BBQUserCenterType] {
        
        if BBQConfigure.fetchPType() == .store {
            
            return [userInfo,.order,.address,.contactUS,.privacy,.about,.feedBack,.setting]
        } else if BBQConfigure.fetchPType() == .map {
            
            return [userInfo,.order,.focus,.contactUS,.privacy,.about,.feedBack,.setting]
            
        } else if BBQConfigure.fetchPType() == .game {
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    return [.userInfo,.myCircle,.focus,.contactUS,.privacy,.about,.feedBack,.setting]
                }
            }
            
            return [userInfo,.myCircle,.characters,.contactUS,.privacy,.about,.feedBack,.setting]
            
        } else if BBQConfigure.fetchPType() == .mix {
            
            return [userInfo,.myCircle,.address,.contactUS,.privacy,.about,.feedBack,.setting]
            
        }else {
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    return [.userInfo,.myCircle,.focus,.contactUS,.privacy,.about,.feedBack,.setting]
                }
            }
            
            return [userInfo,.contactUS,.privacy,.about,.feedBack,.setting]
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
            
        default: return 55
        }
    }
    
    var title: String {
        
        switch self {
            
        case .about: return "关于我们"
            
        case .contactUS: return "联系我们"
            
        case .userInfo: return "用户资料"
            
        case .setting: return "设置"
            
        case .privacy: return "隐私政策"
            
        case .focus: return "我的关注"
            
        case .myCircle: return "我的发布"
            
        case .address: return "我的地址"
            
        case .order: return "我的订单"
            
        case .characters: return "角色信息"
            
        case .feedBack: return "意见建议"
        default: return ""
            
        }
    }
}

struct BBQUserCenterViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<BBQUserCenterBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(BBQUserCenterBean,IndexPath)>
        
        let tableData: BehaviorRelay<[BBQUserCenterBean]> = BehaviorRelay<[BBQUserCenterBean]>(value: [])
        
        let userInfo: Observable<BBQUserBean?>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let userInfo: Observable<BBQUserBean?> = BBQUserInfoCache.default.rx.observe(BBQUserBean.self, "userBean")
        
        BBQUserInfoCache.default.userBean = BBQUserInfoCache.default.queryUser()
        
        bbqDictResp(BBQApi.fetchProfile)
            .mapObject(type: BBQUserBean.self)
            .map({ BBQUserInfoCache.default.saveUser(data: $0) })
            .subscribe(onNext: { (_) in })
            .disposed(by: disposed)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip, userInfo: userInfo)
        
        self.output.tableData.accept(BBQUserCenterBean.createUserCenterTypes())
    }
}

