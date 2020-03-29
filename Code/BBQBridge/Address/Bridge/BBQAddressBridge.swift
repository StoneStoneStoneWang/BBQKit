//
//  BBQAddressBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/20.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import BBQTable
import RxDataSources
import BBQCocoa
import BBQHud
import RxCocoa
import RxSwift
import BBQBean

@objc (BBQAddressActionType)
public enum BBQAddressActionType: Int {
    
    case accessory
    
    case add
    
    case loaded
    
    case delete
    
}

public typealias BBQAddressAction = (_ type: BBQAddressActionType , _ addressBean: BBQAddressBean? ,_ ip: IndexPath?) -> ()

@objc (BBQAddressBridge)
public final class BBQAddressBridge: BBQBaseBridge {
    
    typealias Section = BBQAnimationSetionModel<BBQAddressBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: BBQAddressViewModel!
    
    weak var vc: BBQTableLoadingViewController!
    
    var addressAction: BBQAddressAction!
}

extension BBQAddressBridge {
    
    @objc public func createAddress(_ vc: BBQTableLoadingViewController ,addressAction: @escaping BBQAddressAction ) {
        
        if let addItem = vc.view.viewWithTag(301) as? UIButton {
            
            self.vc = vc
        
            self.addressAction = addressAction
            
            let input = BBQAddressViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(BBQAddressBean.self),
                                                     itemSelect: vc.tableView.rx.itemSelected,
                                                     headerRefresh: vc.tableView.mj_header!.rx.refreshing.asDriver(),
                                                     itemAccessoryButtonTapped: vc.tableView.rx.itemAccessoryButtonTapped.asDriver() ,
                                                     addItemTaps: addItem.rx.tap.asSignal())
            
            viewModel = BBQAddressViewModel(input, disposed: disposed)
            
            let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
                animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
                decideViewTransition: { _,_,_  in return .reload },
                configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)},
                canEditRowAtIndexPath: { _,_ in return true })
            
            viewModel
                .output
                .tableData
                .asDriver()
                .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
                .drive(vc.tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
            
            self.dataSource = dataSource
            
            viewModel
                .output
                .zip
                .subscribe(onNext: { (type,ip) in
                    
                    vc.tableViewSelectData(type, for: ip)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .itemAccessoryButtonTapped
                .drive(onNext: { (ip) in
                    
                    let values = self.viewModel.output.tableData.value

                    addressAction(.accessory, values[ip.section], ip)
                    
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .addItemed
                .drive(onNext: { (_) in
                    
                    addressAction(.add, nil, nil)
                })
                .disposed(by: disposed)
            
            vc
                .tableView
                .rx
                .setDelegate(self)
                .disposed(by: disposed)
            
            let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
            
            endHeaderRefreshing
                .map({ _ in return true })
                .drive(vc.tableView.mj_header!.rx.endRefreshing)
                .disposed(by: disposed)
            
            endHeaderRefreshing
                .drive(onNext: { (res) in
                    switch res {
                    case .fetchList:
                        vc.loadingStatus = .succ
                        
                    case let .failed(msg):
                        BBQHud.showInfo(msg)
                        vc.loadingStatus = .fail
                    case .empty:
                        vc.loadingStatus = .succ
                        
                        vc.tableViewEmptyShow()

                    default:
                        break
                    }
                    
                    addressAction(.loaded, nil, nil)
                })
                .disposed(by: disposed)
            
        }
    }
    
    @objc public func insertAddress(_ address: BBQAddressBean ) {
        
        var values = viewModel.output.tableData.value
        
        if values.isEmpty {
            
            self.vc.tableViewEmptyHidden()
        }
        
        values.insert(address, at: 0)
        
        viewModel.output.tableData.accept(values)
    }
    @objc public func updateAddress(_ address: BBQAddressBean ,ip: IndexPath) {
        
        var values = viewModel.output.tableData.value
        
        values.replaceSubrange(ip.section..<ip.section+1, with: [address])
        
        viewModel.output.tableData.accept(values)
        
    }
    
}
extension BBQAddressBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除地址") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            self.addressAction(.delete, self.dataSource[ip], ip)
            
        }
        let cancel = UITableViewRowAction(style: .default, title: "取消") { (a, ip) in
            
        }
        
        return [cancel,delete]
    }
    
    @objc public func removeAddress(_ address: BBQAddressBean ,_ ip: IndexPath)  {
        
        BBQHud.show(withStatus: "移除地址中...")

        BBQAddressViewModel
            .removeAddress(address.encoded)
            .drive(onNext: { [weak self] (result) in

                guard let `self` = self else { return }
                switch result {
                case .ok:

                    BBQHud.pop()

                    BBQHud.showInfo("移除地址成功")

                    var values = self.viewModel.output.tableData.value

                    values.remove(at: ip.section)

                    self.viewModel.output.tableData.accept(values)

                    if values.isEmpty {

                        self.vc.tableViewEmptyShow()
                    }

                case .failed:

                    BBQHud.pop()

                    BBQHud.showInfo("移除地址失败")
                default: break;

                }
            })
            .disposed(by: self.disposed)
    }
}
