//
//  BBQTableSectionBridge.swift
//  BBQBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import BBQTable
import RxCocoa
import RxSwift
import RxDataSources
import BBQCocoa

public typealias BBQTableSectionAction = (_ item: BBQTableRowBean) -> ()

@objc (BBQTableSectionBridge)
public final class BBQTableSectionBridge: BBQBaseBridge {
    
    var viewModel: BBQTableSectionViewModel!
    
    typealias Section = BBQSectionModel<BBQTableSectionBean, BBQTableRowBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var vc: BBQTableNoLoadingViewController!
    
}

// MARK: skip item 101 pagecontrol 102
extension BBQTableSectionBridge {
    
    @objc public func createCarousel(_ vc: BBQTableNoLoadingViewController ,sections: [BBQTableSectionBean],sectionAction: @escaping BBQTableSectionAction) {
        
        let input = BBQTableSectionViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(BBQTableRowBean.self),
                                                     itemSelect: vc.tableView.rx.itemSelected,
                                                     sections: sections)
        
        viewModel = BBQTableSectionViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip) },
            titleForHeaderInSection: { ds ,section in return self.viewModel.output.tableData.value[section].title})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .map({ $0.map({ Section(model: $0, items: $0.items) }) })
            .bind(to: vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (item,ip) in
                
                sectionAction(item)
            })
            .disposed(by: disposed)
        
    }
}
