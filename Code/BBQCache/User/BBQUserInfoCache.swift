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
            
            ZCacheUtil.shared().createCache(info["CFBundleDisplayName"] as? String ?? "BBQUserInfoCache" )
        }
    }
    @objc (userBean)
    public dynamic var userBean: ZUserBean = ZUserBean()
}

extension BBQUserInfoCache {
    
   public func saveUser(data: ZUserBean) -> ZUserBean {
        
        ZCacheUtil.shared().saveObj(data, withKey: "user_" + data.encoded)
    
        userBean = data
        
        return data
    }
    
    public func queryUser() -> ZUserBean  {
        
        if let user = ZCacheUtil.shared().fetchObj("user_" + ZAccountCache.default.uid) {

            userBean = user as! ZUserBean

            return userBean
        }
        
        return ZUserBean()
    }
}
