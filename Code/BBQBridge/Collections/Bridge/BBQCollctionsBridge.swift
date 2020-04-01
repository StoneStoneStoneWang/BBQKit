//
//  BBQCollectionsBridge.swift
//  BBQBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQCollection
import RxDataSources
import BBQCocoa
import BBQBean
import BBQHud
import BBQCache

@objc(BBQCollectionsActionType)
public enum BBQCollectionsActionType: Int ,Codable {
    
    case myCircle = 0
    
    case circle = 1
    
    case comment = 2
    
    case watch = 3
    
    case report = 4
    
    case unLogin = 5
    
    case like = 6
    
    case focus = 7
    
    case black = 8
    
    case remove = 9
    
    case share = 10
}

public typealias BBQCollectionsAction = (_ actionType: BBQCollectionsActionType ,_ circle: BBQCircleBean? ,_ ip: IndexPath?) -> ()

@objc (BBQCollectionsBridge)
public final class BBQCollectionsBridge: BBQBaseBridge {
    
    typealias Section = BBQAnimationSetionModel<BBQCircleBean>
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: BBQCollectionsViewModel!
    
    weak var vc: BBQCollectionLoadingViewController!
}

extension BBQCollectionsBridge {
    
    @objc public func createFocus(_ vc: BBQCollectionLoadingViewController ,isMy: Bool ,tag: String ,collectionsAction: @escaping BBQCollectionsAction) {
        
        self.vc = vc
        
        let input = BBQCollectionsViewModel.WLInput(isMy: isMy,
                                            modelSelect: vc.collectionView.rx.modelSelected(BBQCircleBean.self),
                                            itemSelect: vc.collectionView.rx.itemSelected,
                                            headerRefresh: vc.collectionView.mj_header!.rx.refreshing.asDriver(),
                                            footerRefresh: vc.collectionView.mj_footer!.rx.refreshing.asDriver(),
                                            tag: tag)
        
        viewModel = BBQCollectionsViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
        
        viewModel
            .output
            .collectionData
            .asDriver()
            .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
            .drive(vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(vc.collectionView.mj_header!.rx.endRefreshing)
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
                    
                    vc.collectionEmptyShow()
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(vc.collectionView.mj_footer!.rx.endRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (circle,ip) in
                
                collectionsAction(isMy ? .myCircle : .circle, circle, ip)
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .footerHidden
            .bind(to: vc.collectionView.mj_footer!.rx.isHidden)
            .disposed(by: disposed)
    }
}

extension BBQCollectionsBridge {
    
    @objc public func fetchIp(_ circle: BBQCircleBean) -> IndexPath {
        
        let values = viewModel.output.collectionData.value
        
        if let idx = values.firstIndex(where: { $0.encoded == circle.encoded }) {
            
            return IndexPath(item: 0, section: idx)
        }
        return IndexPath(item: 0, section: 0)
        
    }
    @objc public func converToJson(_ circle: BBQCircleBean) -> [String: Any] {
        
        return circle.toJSON()
    }
    
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,collectionsAction: @escaping BBQCollectionsAction ) {
        
        if !BBQAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        BBQHud.show(withStatus: "添加黑名单中...")
        
        BBQCollectionsViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                BBQHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    self.vc.collectionView.mj_header!.beginRefreshing()
                    
                    collectionsAction(.black, nil, nil)
                    
                    BBQHud.showInfo(msg)
                case .failed(let msg):
                    
                    BBQHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool ,collectionsAction: @escaping BBQCollectionsAction ) {
        
        if !BBQAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        BBQHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        BBQCollectionsViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                BBQHud.pop()
                
                switch result {
                case .ok(_):
                    
                    let values = self.viewModel.output.collectionData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encode }) {
                        
                        let circle = values[index]
                        
                        circle.isattention = !circle.isattention
                        
                        self.viewModel.output.collectionData.accept(values)
                        
                        collectionsAction(.focus, circle,nil)
                    }
                    
                    BBQHud.showInfo(isFocus ? "取消关注成功" : "关注成功")
                
                case .failed(let msg):
                    
                    BBQHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }
    
    @objc public func operation(_ encoded: String ,isLike: Bool ,status: String ,aMsg: String,collectionsAction: @escaping () -> () ) {
        
        BBQHud.show(withStatus: status)
        
        BBQCollectionsViewModel
            .like(encoded, isLike: isLike)
            .drive(onNext: { (result) in
                
                BBQHud.pop()
                
                switch result {
                case .ok(_):
                    
                    collectionsAction()
                    
                    BBQHud.showInfo(aMsg)
                case .failed(let msg):
                    
                    BBQHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func like(_ encoded: String ,isLike: Bool ,collectionsAction: @escaping BBQCollectionsAction) {
        
        if !BBQAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        BBQHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        BBQCollectionsViewModel
            .like(encoded, isLike: isLike)
            .drive(onNext: { (result) in
                
                BBQHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    let values = self.viewModel.output.collectionData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encoded }) {
                        
                        let circle = values[index]
                        
                        circle.isLaud = !circle.isLaud
                        
                        if isLike { circle.countLaud -= 1 }
                        else { circle.countLaud += 1}
                        
                        self.viewModel.output.collectionData.accept(values)
                        
                        collectionsAction(.like, circle,nil)
                    }
                    
                    BBQHud.showInfo(msg)
                case .failed(let msg):
                    
                    BBQHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
   
    @objc public func removeMyCircle(_ encoded: String ,ip: IndexPath,collectionsAction: @escaping BBQCollectionsAction)  {
        
        BBQHud.show(withStatus: "移除内容中...")

        BBQTablesViewModel
            .removeMyCircle(encoded)

            .drive(onNext: { [weak self] (result) in

                guard let `self` = self else { return }
                switch result {
                case .ok:

                    BBQHud.pop()

                    BBQHud.showInfo("移除当前内容成功")

                    var value = self.viewModel.output.collectionData.value

                    let circle = value[ip.row]
                    
                    value.remove(at: ip.row)

                    self.viewModel.output.collectionData.accept(value)

                    if value.isEmpty {

                        self.vc.collectionEmptyShow()
                    }

                    collectionsAction(.remove, circle, ip)
                case .failed:

                    BBQHud.pop()

                    BBQHud.showInfo("移除当前内容失败")

                default: break

                }
            })
            .disposed(by: self.disposed)
    }
}
