//
//  BBQMessageViewModel.swift
//  BBQBridge
//
//  Created by 王磊 on 2020/4/13.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLBaseResult
import BBQApi
import BBQBean
import BBQRReq

struct BBQMessageViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<BBQMessageBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
    }
    
    struct WLOutput {
        
        let zip: Observable<(BBQMessageBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[BBQMessageBean]> = BehaviorRelay<[BBQMessageBean]>(value: [])
        
        let endHeaderRefreshing: Driver<WLBaseResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in
                return BBQArrayResp(BBQApi.fetchSystemMsg(1))
                    .mapArray(type: BBQMessageBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    output.collectionData.accept(items as! [BBQMessageBean])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
extension BBQMessageViewModel {
    
    static func messageRead(_ encode: String) -> Driver<WLBaseResult> {
        
        return BBQVoidResp(BBQApi.readMsg(encode))
            .flatMapLatest({ return Driver.just(WLBaseResult.ok("")) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    static func fetchFirstMessage() -> Driver<WLBaseResult> {
        
        return BBQArrayResp(BBQApi.fetchFirstMsg)
            .mapArray(type: BBQMessageBean.self)
            .flatMapLatest({ return Driver.just(WLBaseResult.fetchList($0)) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
