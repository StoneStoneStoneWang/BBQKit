//
//  BBQNameBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQBase
import BBQHud
import BBQBean
import RxCocoa
import BBQCache
import RxSwift

@objc(BBQNameActionType)
public enum BBQNameActionType: Int ,Codable {
    
    case name = 0
    
    case back = 1
}

public typealias BBQNameAction = (_ action: BBQNameActionType ) -> ()

@objc (BBQNameBridge)
public final class BBQNameBridge: BBQBaseBridge {
    
    var viewModel: BBQNameViewModel!
    
    let nickname: BehaviorRelay<String> = BehaviorRelay<String>(value: BBQUserInfoCache.default.userBean.nickname)
}

extension BBQNameBridge {
    
    @objc public func createName(_ vc: BBQBaseViewController ,nameAction: @escaping BBQNameAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let name = vc.view.viewWithTag(201) as? UITextField ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton{
            
            let inputs = BBQNameViewModel.WLInput(orignal: nickname.asDriver(),
                                                       updated: name.rx.text.orEmpty.asDriver(),
                                                       completTaps: completeItem.rx.tap.asSignal())
            
            name.text = nickname.value
            
            viewModel = BBQNameViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
                    
                    name.resignFirstResponder()
                    
                    BBQHud.show(withStatus: "修改昵称中...")
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    BBQHud.pop()
                    
                    switch result {
                    case let .updateUserInfoSucc(_, msg: msg):
                        
                        BBQHud.showInfo(msg)
                        
                        nameAction(.name)
                        
                    case let .failed(msg):
                        
                        BBQHud.showInfo(msg)
                    default: break
                        
                    }
                })
                .disposed(by: disposed)
            
            backItem
                .rx
                .tap
                .subscribe(onNext: { (_) in
                    
                    nameAction(.back)
                })
                .disposed(by: disposed)
        }
    }
}
