//
//  BBQModifyPwdBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQBase
import BBQHud
import RxCocoa
import RxSwift
import BBQCocoa

public typealias ZModifyPasswordAction = () -> ()

@objc (BBQModifyPwdBridge)
public final class BBQModifyPasswordBridge: BBQBaseBridge {
    
    public var viewModel: BBQModifyPasswordViewModel!
}
// MARK:  旧密码201 新密码 202 确认密码 203 修改密码
extension BBQModifyPasswordBridge {
    
    @objc public func createPassword(_ vc: BBQBaseViewController ,passwordAction: @escaping ZModifyPasswordAction) {
        
        if let oldpassword = vc.view.viewWithTag(201) as? UITextField ,let password = vc.view.viewWithTag(202) as? UITextField ,let passwordAgain = vc.view.viewWithTag(203) as? UITextField ,let completeItem = vc.view.viewWithTag(204) as? UIButton {
            
            let input = BBQModifyPasswordViewModel.WLInput(oldpassword: oldpassword.rx.text.orEmpty.asDriver(),
                                                      password: password.rx.text.orEmpty.asDriver() ,
                                                      passwordAgain: passwordAgain.rx.text.orEmpty.asDriver(),
                                                      completeTaps: completeItem.rx.tap.asSignal())
            
            viewModel = BBQModifyPasswordViewModel(input, disposed: disposed)
            
            // MARK: 修改密码 点击
            viewModel
                .output
                .completing
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    BBQHud.show(withStatus: "修改密码中...")
                    
                })
                .disposed(by: disposed)
            
            // MARK: 修改密码 完成
            viewModel
                .output
                .completed
                .drive(onNext: {
                    
                    BBQHud.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): BBQHud.showInfo(msg)
                        
                    case let .ok(msg):
                        
                        BBQHud.showInfo(msg)
                        
                        passwordAction()
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
        }
    }
}
