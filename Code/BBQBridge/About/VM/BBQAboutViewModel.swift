//
//  BBQAboutViewModel.swift
//  BBQBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLToolsKit

@objc public final class BBQAboutBean: NSObject {
    
    @objc public var type: BBQAboutType = .space
    
    @objc public var title: String = ""
    
    @objc public var subTitle: String = ""
    
    @objc public static func createAbout(_ type: BBQAboutType ,title: String ,subTitle: String) -> BBQAboutBean {
        
        let about = BBQAboutBean()
        
        about.type = type
        
        about.title = title
        
        about.subTitle = subTitle
        
        return about
    }
    private override init() { }
}

@objc (BBQAboutType)
public enum BBQAboutType: Int {
    
    case version
    
    case email
    
    case wechat
    
    case space
    
    case check
}

extension BBQAboutType {
    
    static var types: [BBQAboutType] {
        
        return [.version,.email,.wechat,.check]
    }
    
    static var placeTypes: [BBQAboutType] {
        
        return [.space,.version,.email,.wechat,.check]
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .space: return 10
            
        default: return 55
            
        }
    }
    
    var title: String {
        
        switch self {
            
        case .version: return "版本号"
            
        case .email: return "官方邮箱"
            
        case .wechat: return "官方微信"
            
        case .check: return "检查更新"
            
        case .space: return ""
        }
    }
    
    var subtitle: String {
        
        switch self {
            
        case .version: return "当前版本: \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
            
        case .email:
            
            guard let info = Bundle.main.infoDictionary else { return "" }
            
            return (info["CFBundleDisplayName"] as? String ?? "").transformToPinYin() + "@163.com"
            
        case .wechat: return ""
            
//            guard let info = Bundle.main.infoDictionary else { return "" }
//
//            return info["CFBundleDisplayName"] as? String ?? ""
            
        case .check: return ""
        case .space: return ""
        }
    }
}

struct BBQAboutViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<BBQAboutType>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let hasPlace: Bool
    }
    struct WLOutput {
        
        let zip: Observable<(BBQAboutType,IndexPath)>
        
        let tableData: BehaviorRelay<[BBQAboutType]> = BehaviorRelay<[BBQAboutType]>(value: [])
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip)
        
        self.output.tableData.accept(input.hasPlace ? BBQAboutType.placeTypes : BBQAboutType.types)
    }
}
