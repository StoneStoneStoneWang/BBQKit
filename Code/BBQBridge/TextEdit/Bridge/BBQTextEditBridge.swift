//
//  BBQTextEditBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQBase
import RxCocoa
import RxSwift

@objc(BBQTextEditActionType)
public enum BBQTextEditActionType: Int ,Codable {
    
    case textEdit = 0
    
    case back = 1
}

public typealias BBQTextEditAction = (_ action: BBQTextEditActionType ,_ text: String) -> ()

@objc (BBQTextEditBridge)
public final class BBQTextEditBridge: BBQBaseBridge {
    
    var viewModel: BBQTextEditViewModel!
    
    let orignal: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}

extension BBQTextEditBridge {
    
    @objc public func createTextEdit(_ vc: BBQBaseViewController ,orignalText: String,textEditAction: @escaping BBQTextEditAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let signaturetv = vc.view.viewWithTag(201) as? UITextView ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton ,let placeholder = vc.view.viewWithTag(202){
            
            orignal.accept(orignalText)
            
            let inputs = BBQTextEditViewModel.WLInput(orignal: orignal.asDriver(),
                                                     updated: signaturetv.rx.text.orEmpty.asDriver(),
                                                     completTaps: completeItem.rx.tap.asSignal())
            
            signaturetv.text = orignal.value
            
            viewModel = BBQTextEditViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    textEditAction(.textEdit,result)
                })
                .disposed(by: disposed)
            
            backItem
                .rx
                .tap
                .subscribe(onNext: { (_) in
                    
                    textEditAction(.back,"")
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
