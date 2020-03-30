//
//  BBQFeedBackBridge.swift
//  BBQBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import BBQBase
import BBQHud

public typealias BBQFeedBackAction = () -> ()

@objc (BBQFeedBackBridge)
public final class BBQFeedBackBridge: BBQBaseBridge {
    
    var viewModel: BBQFeedBackViewModel!
}

extension BBQFeedBackBridge {
    
    @objc public func createFeedBack(_ vc: BBQBaseViewController ,feedBackAction: @escaping BBQFeedBackAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let feedBack = vc.view.viewWithTag(201) as? UITextView ,let placeholder = vc.view.viewWithTag(202) ,let phone = vc.view.viewWithTag(203) as? UITextField{
            
            let inputs = BBQFeedBackViewModel.WLInput(feedBack: feedBack.rx.text.orEmpty.asDriver(),
                                                      phone: phone.rx.text.orEmpty.asDriver(),
                                                      completTaps: completeItem.rx.tap.asSignal())
            
            viewModel = BBQFeedBackViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
                    
                    BBQHud.show(withStatus: "意见建议提交中...")
                    
                    vc.view.endEditing(true)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    BBQHud.pop()
                    
                    switch result {
                    case let .ok(msg):
                        
                        BBQHud.showInfo(msg)
                        
                        feedBackAction()
                        
                    case let .failed(msg):
                        
                        BBQHud.showInfo(msg)
                    default: break
                        
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .placeholderHidden
                .drive(placeholder.rx.isHidden)
                .disposed(by: disposed)
        }
    }
}
