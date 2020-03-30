//
//  BBQUserCenterBridge.swift
//  BBQBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import BBQCollection
import RxDataSources
import BBQCocoa
import BBQCache
import RxCocoa
import RxSwift
import BBQBean
import RxGesture

@objc(BBQUserCenterActionType)
public enum BBQUserCenterActionType: Int ,Codable {
    
    case header
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case space
    
    case myCircle
    
    case order
    
    case address
    
    case characters
    
    case unLogin
}

public typealias BBQUserCenterAction = (_ action: BBQUserCenterActionType ) -> ()

private var key: Void?

extension BBQCollectionHeaderView {
    
    @objc public var user: BBQUserBean? {
        get {
            return objc_getAssociatedObject(self, &key) as? BBQUserBean
        }
        set{
            objc_setAssociatedObject(self, &key,newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Reactive where Base: BBQCollectionHeaderView {
    
    var user: Binder<BBQUserBean?> {
        
        return Binder(base) { view, user in
            
            view.user = user
        }
    }
}

@objc (BBQUserCenterBridge)
public final class BBQUserCenterBridge: BBQBaseBridge {
    
    typealias Section = BBQSectionModel<(), BBQUserCenterBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var viewModel: BBQUserCenterViewModel!
    
    weak var vc: BBQCollectionNoLoadingViewController!
}

extension BBQUserCenterBridge {
    
    @objc public func createProfile(_ vc: BBQCollectionNoLoadingViewController,headerView: BBQCollectionHeaderView,profileAction:@escaping BBQUserCenterAction) {
        
        let input = BBQUserCenterViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(BBQUserCenterBean.self),
                                                   itemSelect: vc.collectionView.rx.itemSelected)
        
        viewModel = BBQUserCenterViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip)})
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: {(type,ip) in
                
                vc.collectionView.deselectItem(at: ip, animated: true)
                
                let isLogin = BBQAccountCache.default.isLogin()
                
                switch type.type {
                case .setting: profileAction(.setting)
                    
                case .privacy: profileAction(.privacy)
                case .about: profileAction(.about)
                    
                case .userInfo: profileAction(isLogin ? .userInfo : .unLogin)
                case .address: profileAction(isLogin ? .address : .unLogin)
                case .order: profileAction(isLogin ? .order : .unLogin)
                case .focus: profileAction(isLogin ? .focus : .unLogin)
                case .characters: profileAction(isLogin ? .characters : .unLogin)
                case .myCircle: profileAction(isLogin ? .myCircle : .unLogin)
                    
                case .contactUS:
                    
                    vc.collectionViewSelectData(type, for: ip)
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        vc
            .collectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        viewModel
            .output
            .userInfo
            .bind(to: headerView.rx.user)
            .disposed(by: disposed)
        
        headerView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { (_) in
                
                let isLogin = BBQAccountCache.default.isLogin()
                
                profileAction(isLogin ? .header : .unLogin)
                
            })
            .disposed(by: disposed)
    }
}

extension BBQUserCenterBridge: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return vc.configCollectionViewCellItemSize(self.dataSource[indexPath], for: indexPath)
    }
    //
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return vc.configCollectionViewCellSectionInset("", forSection: section)
    }
    //
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return vc.configCollectionViewCellMinimumLineSpacing("", forSection: section)
        
    }
    //
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return vc.configCollectionViewCellMinimumInteritemSpacing("", forSection: section)
    }
}
