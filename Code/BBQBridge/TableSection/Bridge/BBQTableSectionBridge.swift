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

public typealias BBQTableSectionAction = (_ item: BBQTableRowBean ,_ ip: IndexPath) -> ()

@objc (BBQTableSectionBridge)
public final class BBQTableSectionBridge: BBQBaseBridge {
    
    var viewModel: BBQTableSectionViewModel!
    
    typealias Section = BBQSectionModel<BBQTableSectionBean, BBQTableRowBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var vc: BBQTableNoLoadingViewController!
    
}

extension BBQTableSectionBridge {
    
    @objc public func createTableSection(_ vc: BBQTableNoLoadingViewController ,sections: [BBQTableSectionBean],sectionAction: @escaping BBQTableSectionAction ) {
        
        self.vc = vc
        
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
                
                sectionAction(item, ip)
            })
            .disposed(by: disposed)
        
        vc.tableView.rx.setDelegate(self).disposed(by: disposed)
        
    }
}
extension BBQTableSectionBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let dataSource = dataSource else { return 0}
        
        return vc.caculate(forCell: dataSource[indexPath], for: indexPath)
    }
}
