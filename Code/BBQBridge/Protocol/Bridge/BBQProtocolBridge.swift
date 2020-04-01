//
//  BBQProtocolBridge.swift
//  BBQBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQTextInner

@objc (BBQProtocolBridge)
public final class BBQProtocolBridge: BBQBaseBridge {
    
    public var viewModel: BBQProtocolViewModel!
    
}

extension BBQProtocolBridge {
    
    @objc public func createProtocol(_ vc: BBQTextInnerViewController) {
        
        let inputs = BBQProtocolViewModel.WLInput()
        
        viewModel = BBQProtocolViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: {(value) in
                
                DispatchQueue.main.async {
                    
                    vc.loadHtmlString(htmlString: value)
                }
                
            })
            .disposed(by: disposed)
    }
}
