//
//  BBQCollectionSectionBridge.swift
//  BBQBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import BBQCollection
import RxCocoa
import RxSwift
import RxDataSources
import BBQCocoa

public typealias BBQCollectionSectionAction = (_ item: BBQCollectionItemBean) -> ()

@objc (BBQCollectionSectionBridge)
public final class BBQCollectionSectionBridge: BBQBaseBridge {
    
    var viewModel: BBQCollectionSectionViewModel!
    
    typealias Section = BBQSectionModel<BBQCollectionSectionBean, BBQCollectionItemBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: BBQCollectionNoLoadingViewController!
    
}

// MARK: skip item 101 pagecontrol 102
extension BBQCollectionSectionBridge {
    
    @objc public func createCollectionSection(_ vc: BBQCollectionNoLoadingViewController ,sections: [BBQCollectionSectionBean],sectionAction: @escaping BBQCollectionSectionAction) {
        
        let input = BBQCollectionSectionViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(BBQCollectionItemBean.self),
                                                          itemSelect: vc.collectionView.rx.itemSelected,
                                                          sections: sections)
        
        viewModel = BBQCollectionSectionViewModel(input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip) },
            configureSupplementaryView: { ds, cv, kind, ip in return vc.configCollectionViewHeader(self.viewModel.output.collectionData.value[ip.section], for: ip)})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .collectionData
            .map({ $0.map({ Section(model: $0, items: $0.items) }) })
            .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (item,ip) in

                sectionAction(item)
            })
            .disposed(by: disposed)
        
    }
    
    @objc public func fetchCollectionDatas() -> [BBQCollectionItemBean] {
        
        guard let viewModel = viewModel else { return [] }
        
        var mutable: [BBQCollectionItemBean] = []
        
        for item in viewModel.output.collectionData.value {
            
            mutable += item.items
        }
        
        return mutable
    }
    
    @objc public func fetchCollectionItemBean(_ ip: IndexPath) -> BBQCollectionItemBean? {
        
        guard let dataSource = dataSource else { return nil }
        
        return dataSource[ip]
    }
}
