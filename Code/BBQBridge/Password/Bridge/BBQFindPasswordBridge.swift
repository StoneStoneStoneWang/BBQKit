//
//  BBQFindPwdBridge.swift
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

public typealias BBQFindPasswordAction = () -> ()

@objc (BBQFindPwdBridge)
public final class BBQFindPasswordBridge: BBQBaseBridge {
    
    public var viewModel: BBQFindPasswordModel!
}
// MARK:  手机号 201  验证码 202  密码 203  完成按钮 204
extension BBQFindPasswordBridge {
    
    @objc public func createPassword(_ vc: BBQBaseViewController,passwordAction: @escaping BBQFindPasswordAction ) {
        
        if let phone = vc.view.viewWithTag(201) as? UITextField ,let vcode = vc.view.viewWithTag(202) as? UITextField ,let vcodeItem = vcode.rightView as? UIButton,let password = vc.view.viewWithTag(203) as? UITextField, let passwordItem = password.rightView
            as? UIButton ,let completeItem = vc.view.viewWithTag(204) as? UIButton {
            
            let input = BBQFindPasswordModel.WLInput(username: phone.rx.text.orEmpty.asDriver(),
                                              vcode: vcode.rx.text.orEmpty.asDriver() ,
                                              password: password.rx.text.orEmpty.asDriver(),
                                              verifyTaps: vcodeItem.rx.tap.asSignal(),
                                              completeTaps: completeItem.rx.tap.asSignal(),
                                              passwordItemTaps: passwordItem.rx.tap.asSignal())
            
            viewModel = BBQFindPasswordModel(input, disposed: disposed)
            
            // MARK: 完成点击中序列
            viewModel
                .output
                .completing
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    BBQHud.show(withStatus: "找回密码中...")
                    
                })
                .disposed(by: disposed)
            
            // MARK: 完成事件返回序列
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
            // 验证码序列
            viewModel
                .output
                .verifying
                .drive(onNext: { (_) in
                    
                    vc.view.endEditing(true)
                    
                    BBQHud.show(withStatus: "获取验证码中...")
                })
                .disposed(by: disposed)
            // 验证码结果序列
            viewModel
                .output
                .smsRelay
                .asObservable()
                .bind(to: vcodeItem.rx.sms)
                .disposed(by: disposed)
            // 验证码结果序列
            viewModel
                .output
                .verifyed
                .drive(onNext: { [weak self] result in
                    
                    guard let `self` = self else { return }
                    
                    switch result {
                    case let .failed(message: msg):
                        BBQHud.pop()
                        BBQHud.showInfo(msg)
                    case let .ok(msg):
                        BBQHud.pop()
                        BBQHud.showInfo(msg)
                    case let .smsOk(isEnabled: isEnabled, title: title):
                        
                        self.viewModel.output.smsRelay.accept((isEnabled,title))
                    default: break
                        
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .passwordItemed
                .drive(passwordItem.rx.isSelected)
                .disposed(by: disposed)
            
            viewModel
                .output
                .passwordEntryed
                .drive(password.rx.isSecureTextEntry)
                .disposed(by: disposed)
        }
    }
}
