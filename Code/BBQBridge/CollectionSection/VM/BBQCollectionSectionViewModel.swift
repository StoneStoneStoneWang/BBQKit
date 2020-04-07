//
//  BBQCollectionSectionViewModel.swift
//  BBQBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxSwift
import RxCocoa

@objc (BBQCollectionSectionBean)
public final class BBQCollectionSectionBean: NSObject {
    
    @objc public var sTag: Int = 0
    
    @objc public var items: [BBQCollectionItemBean] = []
    
    @objc public var title: String = ""
    
    @objc public static func createSection(_ sTag: Int,title: String ,items: [BBQCollectionItemBean]) -> BBQCollectionSectionBean {
        
        let section = BBQCollectionSectionBean()
        
        section.sTag = sTag
        
        section.title = title
        
        section.items += items
        
        return section
    }
    private override init() { }
}

@objc (BBQCollectionItemBean)
public final class BBQCollectionItemBean: NSObject {
    
    @objc public var iTag: Int = 0
    
    @objc public var title: String = ""
    
    @objc public var icon: String = ""
    
    @objc public var isSelected: Bool = false
    
    @objc public var placeholder: String = ""
    
    @objc public var value: String = ""
    
    @objc public static func createItem(_ iTag: Int,title: String ,icon: String) -> BBQCollectionItemBean {
        
        let item = BBQCollectionItemBean()
        
        item.iTag = iTag
        
        item.title = title
        
        item.icon = icon
        
        return item
    }
    
    private override init() { }
}

struct BBQCollectionSectionViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<BBQCollectionItemBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let sections: [BBQCollectionSectionBean]
    }
    
    struct WLOutput {
        // 获取轮播图序列
        let zip: Observable<(BBQCollectionItemBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[BBQCollectionSectionBean]> = BehaviorRelay<[BBQCollectionSectionBean]>(value:[])
    }
    
    init(_ input: WLInput ) {
        
        self.input = input
        
        output = WLOutput(zip: Observable.zip(input.modelSelect,input.itemSelect))
        
        output.collectionData.accept(input.sections)
    }
}
