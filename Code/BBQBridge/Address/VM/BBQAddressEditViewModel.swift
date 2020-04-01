//
//  BBQAddressEditViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/20.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLBaseResult
import WLReqKit
import BBQBean
import RxDataSources
import BBQApi
import BBQRReq
import WLToolsKit

@objc (BBQAddressEditBean)
public class BBQAddressEditBean: NSObject ,IdentifiableType{
    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    @objc public var type: BBQAddressEditType = .name
    
    @objc public var title: String {
        
        return type.title
    }
    
    @objc public var value: String = ""
    
    @objc public var pArea: BBQAreaBean = BBQAreaBean()
    
    @objc public var cArea: BBQAreaBean = BBQAreaBean()
    
    @objc public var rArea: BBQAreaBean = BBQAreaBean()
    
    @objc public var isDef: Bool = true
    
    @objc public var placeholder: String {
        
        return type.placeholder
    }
    
    public static var editTypes: [BBQAddressEditBean] {
        
        let name = BBQAddressEditBean()
        
        name.type = .name
        
        let phone = BBQAddressEditBean()
        
        phone.type = .phone
        
        let area = BBQAddressEditBean()
        
        area.type = .area
        
        let detail = BBQAddressEditBean()
        
        detail.type = .detail
        
        let def = BBQAddressEditBean()
        
        def.type = .def
        
        def.isDef = true
        
        return [name,phone,area,detail,def]
    }
}

@objc (BBQAddressEditType)
public enum BBQAddressEditType:Int {
    case name
    
    case phone
    
    case area
    
    case detail
    
    case def
}

extension BBQAddressEditType {
    
    public var title: String {
        
        switch self {
        case .name: return "收货人"
            
        case .phone: return "手机号码"
            
        case .area: return "所在地区"
            
        case .detail: return "详细地址"
            
        case .def: return "默认地址"
        }
    }
    
    public static var types: [BBQAddressEditType] {
        
        return [.name,.phone,.area,.detail,.def]
    }
    
    public var placeholder: String {
        
        switch self {
        case .name: return "请填写收货人姓名"
            
        case .phone: return "请填写收货人手机号"
            
        case .area: return "请选择所在地区"
            
        case .detail: return "请填写街道、门牌号"
            
        case .def: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        
        return 48
    }
}


struct BBQAddressEditViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<BBQAddressEditBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let encode: String
        
        let name: Driver<String>
        
        let phone: Driver<String>
        
        let detail: Driver<String>
        
        let province: Driver<BBQAreaBean>
        
        let city: Driver<BBQAreaBean>
        
        let region: Driver<BBQAreaBean>
        
        let def: Driver<Bool>
    }
    
    struct WLOutput {
        
        let zip: Observable<(BBQAddressEditBean,IndexPath)>
        
        let completing: Driver<Void>
        
        let completed: Driver<WLBaseResult>
        
        let tableData: BehaviorRelay<[BBQAddressEditBean]> = BehaviorRelay<[BBQAddressEditBean]>(value: BBQAddressEditBean.editTypes)
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let completing: Driver<Void> = input.completeTaps.flatMap { Driver.just($0) }
        
        let uap = Driver.combineLatest(input.name
            ,input.phone,input.detail,input.province, input.city,input.region,input.def)
        
        let completed: Driver<WLBaseResult> = input
            .completeTaps
            .withLatestFrom(uap)
            .flatMapLatest {
                
                if $0.0.wl_isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请填写收货人姓名"))
                }
                if $0.1.wl_isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请填写收货人手机号"))
                }
                if !String.validPhone(phone: $0.1) {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请填写收货人11位手机号"))
                }
                
                if $0.3.name.wl_isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请选择所在地区"))
                }
                
                if $0.2.wl_isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请填写详细地址"))
                }
                
                return bbqDictResp(BBQApi.editAddress(input.encode, name: $0.0, phone: $0.1, plcl: $0.3.areaId, plclne: $0.3.name, city: $0.4.areaId, cityne: $0.4.name, region: $0.5.areaId, regionne: $0.5.name, addr: $0.2, isdef: $0.6, zipCode: ""))
                    .mapObject(type: BBQAddressBean.self)
                    .map({ WLBaseResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        self.output = WLOutput(zip: zip, completing: completing,completed: completed)
        
    }
}

