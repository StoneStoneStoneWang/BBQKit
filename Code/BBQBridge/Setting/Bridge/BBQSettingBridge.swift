//
//  BBQSettingBridge.swift
//  BBQBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQTable
import RxDataSources
import BBQCocoa
import BBQCache

@objc(BBQSettingActionType)
public enum BBQSettingActionType: Int ,Codable {
    
    case gotoFindPassword = 0
    
    case gotoModifyPassword = 1
    
    case logout = 2
    
    case unlogin = 3
    
    case black = 4
}

public typealias BBQSettingAction = (_ action: BBQSettingActionType ) -> ()


@objc (BBQSettingBridge)
public final class BBQSettingBridge: BBQBaseBridge {
    
    typealias Section = BBQSectionModel<(), BBQSettingBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: BBQSettingViewModel!
    
    weak var vc: BBQTableNoLoadingViewConntroller!
}
extension BBQSettingBridge {
    
    @objc public func createSetting(_ vc: BBQTableNoLoadingViewConntroller ,hasPlace: Bool,settingAction: @escaping BBQSettingAction) {
        
        self.vc = vc
        
        let input = BBQSettingViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(BBQSettingBean.self),
                                                itemSelect: vc.tableView.rx.itemSelected, hasPlace: hasPlace)
        
        viewModel = BBQSettingViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in  return vc.configTableViewCell(item, for: ip) })
        
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
            .zip
            .subscribe(onNext: { (type,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                switch type.type {
                    
                case .pwd:
                    
                    settingAction(.gotoFindPassword)
                case .password:
                    
                    settingAction(.gotoModifyPassword)
                    
                case .logout:
                    settingAction(.logout)
                    
                case .black:
                    
                    if BBQAccountCache.default.isLogin() {
                        
                        settingAction(.black)
                        
                    } else {
                        
                        settingAction(.unlogin)
                        
                    }
                    
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
    }
    
    @objc public func updateCache(_ value: String ) {
        
        let values = viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == .clear}) {
            
            viewModel.output.tableData.value[idx].subTitle = value
            
            vc.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .none)
        }
    }
    
    @objc public func updateTableData(_ hasPlace: Bool) {
        
        viewModel.output.tableData.accept(BBQSettingBean.createTabledata(hasPlace))
    }
}
extension BBQSettingBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
