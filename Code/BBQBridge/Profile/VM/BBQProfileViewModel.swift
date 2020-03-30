//
//  BBQProfileViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
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

@objc public final class BBQProfileBean: NSObject {
    
    @objc public var type: BBQProfileType = .space
    
    @objc public var title: String = ""
    
    @objc public static func createProfile(_ type: BBQProfileType ,title: String) -> BBQProfileBean {
        
        let profile = BBQProfileBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    
    static public func createProfileTypes(_ hasPlace: Bool) -> [BBQProfileBean] {
        
        var result: [BBQProfileBean] = []
        
        if hasPlace {
            
            for item in BBQProfileType.types {
                
                result += [BBQProfileBean.createProfile(item, title: item.title)]
            }
            
        } else {
            
            for item in BBQProfileType.placeTypes {
                
                result += [BBQProfileBean.createProfile(item, title: item.title)]
            }
        }
        
        return result
    }
    private override init() {
        
    }
}

@objc (BBQProfileType)
public enum BBQProfileType : Int{
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case space
    
    case myCircle
    
    case order
    
    case address
    
    case characters
}

extension BBQProfileType {
    
    static var placeTypes: [BBQProfileType] {
        
        if BBQConfigure.fetchPType() == .store {
            
            return [.space,userInfo,.order,.address,.space,.contactUS,.privacy,.about,.space,.setting]
        } else if BBQConfigure.fetchPType() == .map {
            
            return [.space,userInfo,.order,.focus,.space,.contactUS,.privacy,.about,.space,.setting]
            
        } else if BBQConfigure.fetchPType() == .game {
            
            return [.space,userInfo,.characters,.space,.contactUS,.privacy,.about,.space,.setting]
            
        } else if BBQConfigure.fetchPType() == .mix {
            
            return [.space,userInfo,.myCircle,.address,.space,.contactUS,.privacy,.about,.space,.setting]
            
        }else {
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    return [.space,userInfo,.myCircle,.focus,.space,.contactUS,.privacy,.about,.space,.setting]
                }
            }
            
            return [.space,userInfo,.space,.contactUS,.privacy,.about,.space,.setting]
        }
    }
    
    static var types: [BBQProfileType] {
        
        if BBQConfigure.fetchPType() == .store {
            
            return [userInfo,.order,.address,.contactUS,.privacy,.about,.setting]
        } else if BBQConfigure.fetchPType() == .map {
            
            return [userInfo,.order,.focus,.contactUS,.privacy,.about,.setting]
            
        } else if BBQConfigure.fetchPType() == .game {
            
            return [userInfo,.characters,.contactUS,.privacy,.about,.setting]
            
        } else if BBQConfigure.fetchPType() == .mix {
            
            return [userInfo,.myCircle,.address,.contactUS,.privacy,.about,.setting]
            
        }else {
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    return [.space,userInfo,.myCircle,.focus,.space,.contactUS,.privacy,.about,.space,.setting]
                }
            }
            
            return [userInfo,.contactUS,.privacy,.about,.setting]
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .space: return 10
            
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
            
        default: return ""
            
        }
    }
}

struct BBQProfileViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<BBQProfileBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let hasPlace: Bool
    }
    
    struct WLOutput {
        
        let zip: Observable<(BBQProfileBean,IndexPath)>
        
        let tableData: BehaviorRelay<[BBQProfileBean]> = BehaviorRelay<[BBQProfileBean]>(value: [])
        
        let userInfo: Observable<BBQUserBean?>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let userInfo: Observable<BBQUserBean?> = BBQUserInfoCache.default.rx.observe(BBQUserBean.self, "userBean")
        
        BBQUserInfoCache.default.userBean = BBQUserInfoCache.default.queryUser()
        
        bbqVoidResp(BBQApi.fetchProfile)
            .mapObject(type: BBQUserBean.self)
            .map({ BBQUserInfoCache.default.saveUser(data: $0) })
            .subscribe(onNext: { (_) in })
            .disposed(by: disposed)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip, userInfo: userInfo)
        
        self.output.tableData.accept(BBQProfileBean.createProfileTypes(input.hasPlace))
    }
}

