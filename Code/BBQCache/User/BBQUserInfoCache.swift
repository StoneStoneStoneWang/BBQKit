//
//  BBQUserInfoCache.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQBean
import BBQYYCache

@objc (BBQUserInfoCache)
public final class BBQUserInfoCache: NSObject {
    @objc (shared)
    public static let `default`: BBQUserInfoCache = BBQUserInfoCache()
    
    private override init() {
        
        if let info = Bundle.main.infoDictionary {
            
            BBQYYCahce.shared().createCache(info["CFBundleDisplayName"] as? String ?? "BBQUserInfoCache" )
        }
    }
    @objc (userBean)
    public dynamic var userBean: BBQUserBean = BBQUserBean()
}

extension BBQUserInfoCache {
    
    public func saveUser(data: BBQUserBean) -> BBQUserBean {
        
        if !data.encoded.isEmpty {
            
            BBQYYCahce.shared().saveObj(data, withKey: "user_" + data.encoded)
            
            userBean = data
        }
        
        return data
    }
    
    public func queryUser() -> BBQUserBean  {
        
        if !BBQAccountCache.default.uid.isEmpty {
            
            if let user = BBQYYCahce.shared().fetchObj("user_" + BBQAccountCache.default.uid) {
                
                userBean = user as! BBQUserBean
                
                return userBean
            }
        }
    
        return BBQUserBean()
    }
}
