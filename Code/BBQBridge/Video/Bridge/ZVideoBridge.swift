//
//  BBQVideoBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/22.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import BBQTransition
import BBQHud
import BBQCache

@objc(BBQVideoActionType)
public enum BBQVideoActionType: Int ,Codable {
    
    case myCircle = 0
    
    case circle = 1
    
    case comment = 2
    
    case watch = 3
    
    case report = 4
    
    case unLogin = 5
    
    case like = 6
    
    case focus = 7
    
    case black = 8
    
    case remove = 9
    
    case share = 10
}

public typealias BBQVideoAction = (_ action: BBQVideoActionType) -> ()

@objc (BBQVideoBridge)
public final class BBQVideoBridge: BBQBaseBridge {
    
    var viewModel: BBQVideoViewModel!
    
    weak var vc: BBQTViewController!
}
extension BBQVideoBridge {
    
    @objc public func createVideo(_ vc: BBQTViewController) {
        
        self.vc = vc
    }
}
extension BBQVideoBridge {
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,action: @escaping BBQVideoAction) {
        
        if !BBQAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        BBQHud.show(withStatus: "添加黑名单中...")
        
        BBQVideoViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                BBQHud.pop()
                
                switch result {
                case .ok(let msg):
                
                    BBQHud.showInfo(msg)
                    
                    action(.black)
                    
                case .failed(let msg):
                    
                    BBQHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool,action: @escaping BBQVideoAction) {
        
        if !BBQAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        BBQHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        BBQVideoViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                BBQHud.pop()
                
                switch result {
                case .ok:
                    
                    action(.focus)
                    
                    BBQHud.showInfo(isFocus ? "取消关注成功" : "关注成功")
                case .failed(let msg):
                    
                    BBQHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }

    @objc public func like(_ encoded: String,isLike: Bool,action: @escaping BBQVideoAction) {
        
        if !BBQAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        BBQHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        BBQVideoViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
                BBQHud.pop()
                
                switch result {
                case .ok(let msg):
                
                    action(.like)
                    
                    BBQHud.showInfo(msg)
                case .failed(let msg):
                    
                    BBQHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
}
