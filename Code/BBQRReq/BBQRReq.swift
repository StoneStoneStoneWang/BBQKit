//
//  ZRealReq.swift
//  ZRealReq
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLReqKit
import BBQCache
import BBQReq
import BBQUpload
import BBQSign

public func bbqDictResp<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !BBQAccountCache.default.token.isEmpty {
            
            params.updateValue(BBQAccountCache.default.token, forKey: "token")
        }
        
        BBQReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in
            
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func bbqArrayResp<T : WLObserverReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !BBQAccountCache.default.token.isEmpty {
            
            params.updateValue(BBQAccountCache.default.token, forKey: "token")
        }
        BBQReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(data as! [Any])

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}


// 无返回值的 在data里
public func bbqVoidResp<T : WLObserverReq>(_ req: T) -> Observable<Void> {
    
    return Observable<Void>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !BBQAccountCache.default.token.isEmpty {
            
            params.updateValue(BBQAccountCache.default.token, forKey: "token")
        }
        
        BBQReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(())

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func bbqAlitResp<T : WLObserverReq>(_ req: T) -> Observable<BBQALCredentialsBean> {
    
    return Observable<BBQALCredentialsBean>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !BBQAccountCache.default.token.isEmpty {
            
            params.updateValue(BBQAccountCache.default.token, forKey: "token")
        }
        BBQUpload.fetchAliObj(withUrl: req.host + req.reqName , andParams: params, andHeader: req.headers, andSucc: { (credentials) in

            observer.onNext(credentials)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 131 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func bbqUploadImgResp(_ data: Data ,file: String ,param: BBQALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        BBQUpload.uploadAvatar(with: data, andFile: file, andUid: BBQAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func bbqUploadPubImgResp(_ data: Data ,file: String ,param: BBQALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        BBQUpload.uploadImage(with: data, andFile: file, andUid: BBQAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}
public func bbqUploadVideoResp(_ data: Data ,file: String ,param: BBQALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        BBQUpload.uploadVideo(with: data, andFile: file, andUid: BBQAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
//
        return Disposables.create { }
    })
}

public func bbqTranslateResp<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        BBQReq.postTranslateWithParams(params: req.params, succ: { (data) in
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        return Disposables.create { }
    })
}
