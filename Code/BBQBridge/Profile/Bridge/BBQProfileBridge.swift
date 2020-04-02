//
//  BBQProfileBridge.swift
//  BBQBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//  

import Foundation
import BBQTable
import RxDataSources
import BBQCocoa
import BBQCache
import RxCocoa
import RxSwift
import BBQBean
import RxGesture

@objc(BBQProfileActionType)
public enum BBQProfileActionType: Int ,Codable {
    
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
    
    case feedBack
}

public typealias BBQProfileAction = (_ action: BBQProfileActionType ) -> ()

private var key: Void?

extension BBQTableHeaderView {
    
    @objc public var user: BBQUserBean? {
        get {
            return objc_getAssociatedObject(self, &key) as? BBQUserBean
        }
        set{
            objc_setAssociatedObject(self, &key,newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Reactive where Base: BBQTableHeaderView {
    
    var user: Binder<BBQUserBean?> {
        
        return Binder(base) { view, user in
            
            view.user = user
        }
    }
}

@objc (BBQProfileBridge)
public final class BBQProfileBridge: BBQBaseBridge {
    
    typealias Section = BBQSectionModel<(), BBQProfileBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: BBQProfileViewModel!
    
    weak var vc: BBQTableNoLoadingViewController!
}

extension BBQProfileBridge {
    
    @objc public func createProfile(_ vc: BBQTableNoLoadingViewController,hasPlace: Bool,profileAction:@escaping BBQProfileAction) {
        
        let input = BBQProfileViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(BBQProfileBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              hasPlace: hasPlace)
        
        viewModel = BBQProfileViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)  })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .userInfo
            .bind(to: vc.headerView.rx.user)
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: {(type,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
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
                case .feedBack: profileAction(.feedBack)
                case .contactUS:
                    
                    vc.tableViewSelectData(type, for: ip)
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        vc
            .headerView
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

extension BBQProfileBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
