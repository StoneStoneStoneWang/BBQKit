//
//  BBQAccountCache.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQBean

@objc (BBQAccountCache)
public final class BBQAccountCache: NSObject {
    @objc (shared)
    public static let `default`: BBQAccountCache = BBQAccountCache()
    
    private override init() { }
    
    @objc public var token: String = ""
    
    public var phone: String = ""
    
    @objc public var uid: String = ""
}

extension BBQAccountCache {
    
    @objc public func isPushOn() -> Bool {
        
        return UserDefaults.standard.bool(forKey: "\(uid)_push")
    }
    @objc public func setPushOn(_ isOn: Bool) {
        
        UserDefaults.standard.set(isOn, forKey: "\(uid)_push")
    }
    
    @objc public func isFirstLoad() -> Bool {
        
        return UserDefaults.standard.bool(forKey: "isFirstLoad")
    }
    @objc public func setFirstLoad(_ isFirstLoad: Bool) {
        
        UserDefaults.standard.set(isFirstLoad, forKey: "isFirstLoad")
    }
    
    @objc public func isLogin() -> Bool {
        
        return !token.isEmpty && token != ""
    }
    
    public func saveAccount(acc: BBQAccountBean) -> BBQAccountBean {
        
        UserDefaults.standard.setValue(acc.token, forKey: "token")
        
        UserDefaults.standard.setValue(acc.phone, forKey: "phone")
        
        UserDefaults.standard.setValue("\(acc.encoded)", forKey: "uid")
        
        token = acc.token
        
        phone = acc.phone
        
        uid = "\(acc.encoded)"
        
        UserDefaults.standard.synchronize()
        
        return acc
    }
    
    public func queryAccount() -> BBQAccountBean! {
        
        guard let id = UserDefaults.standard.object(forKey: "uid") else {
            
            return nil
        }
        
        var acc = BBQAccountBean()
        
        acc.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        
        acc.phone = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
        
        UserDefaults.standard.synchronize()
        
        acc.encoded = Int(id as! String)!
        
        token = acc.token
        
        phone = acc.phone
        
        uid = "\(acc.encoded)"
        
        return acc
    }
    
    @objc public func wl_queryAccount() {
        
        guard let id = UserDefaults.standard.object(forKey: "uid") else {
            
            return
        }
        
        var acc = BBQAccountBean()
        
        acc.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        
        acc.phone = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
        
        UserDefaults.standard.synchronize()
        
        acc.encoded = Int(id as! String)!
        
        token = acc.token
        
        phone = acc.phone
        
        uid = "\(acc.encoded)"
    }
    
    @objc public func clearAccount() {
        
        UserDefaults.standard.removeObject(forKey: "token")
        
        UserDefaults.standard.removeObject(forKey: "uid")
        
        UserDefaults.standard.removeObject(forKey: "phone")
        
        token = ""
        
        phone = ""
        
        uid = ""
        
        UserDefaults.standard.synchronize()
    }
}
