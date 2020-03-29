//
//  BBQPrivacyBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQInner

@objc (BBQPrivacyBridge)
public final class BBQPrivacyBridge: BBQBaseBridge {
    
    public var viewModel: BBQPrivacyViewModel!
    
}

extension BBQPrivacyBridge {
    
    @objc public func createPrivacy(_ vc: BBQInnerViewController) {
        
        let inputs = BBQPrivacyViewModel.WLInput()
        
        viewModel = BBQPrivacyViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: {(value) in
                
                DispatchQueue.main.async {
                    
                    vc.loadHtml(value)
                }
                
            })
            .disposed(by: disposed)
    }
}
