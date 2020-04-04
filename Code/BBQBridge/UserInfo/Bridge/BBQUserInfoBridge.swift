//
//  BBQUserInfoBridge.swift
//  BBQBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import BBQTable
import BBQHud
import BBQBean
import RxCocoa
import BBQCache
import RxSwift
import RxDataSources
import BBQCocoa
import BBQRReq
import BBQUpload

public typealias BBQUserInfoAction = () -> ()

@objc (BBQUserInfoBridge)
public final class BBQUserInfoBridge: BBQBaseBridge {
    
    typealias Section = BBQSectionModel<(), BBQUserInfoBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: BBQUserInfoViewModel!
    
    weak var vc: BBQTableNoLoadingViewController!
}

extension BBQUserInfoBridge {
    
    @objc public func createUserInfo(_ vc: BBQTableNoLoadingViewController ,hasPlace: Bool) {
        
        self.vc = vc
        
        let input = BBQUserInfoViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(BBQUserInfoBean.self),
                                                 itemSelect: vc.tableView.rx.itemSelected,
                                                 hasPlace: hasPlace)
        
        viewModel = BBQUserInfoViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
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
                
                vc.tableViewSelectData(type, for: ip)
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    @objc public func updateUserInfo(_ type: BBQUserInfoType,value: String ) {
        
        let values =  viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == type}) {
            
            self.vc.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .fade)
        }
    }
    
    @objc public func updateUserInfo(type: BBQUserInfoType,value: String,action: @escaping BBQUserInfoAction) {
        
        BBQHud.show(withStatus: "修改\(type.title)中...")
        
        BBQUserInfoViewModel
            .updateUserInfo(type: type, value: value)
            .drive(onNext: { (result) in
                
                BBQHud.pop()
                switch result {
                    
                case .ok(_):
                    
                    action()
                    
                    BBQHud.showInfo(type == .header ? "上传头像成功" : "修改\(type.title)成功")
                    
                case .failed(let msg): BBQHud.showInfo(msg)
                default: break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func updateHeader(_ data: Data ,action: @escaping BBQUserInfoAction) {
        
        BBQHud.show(withStatus: "上传头像中...")
        
        BBQUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchSomeObject(let obj):
                    
                    DispatchQueue.global().async {
                        
                        bbqUploadImgResp(data, file: "headerImg", param: obj as! BBQALCredentialsBean)
                            .subscribe(onNext: { [weak self] (value) in
                                
                                guard let `self` = self else { return }
                                
                                DispatchQueue.main.async {
                                    
                                    self.updateUserInfo(type: BBQUserInfoType.header, value: value, action: action)
                                }
                                
                                }, onError: { (error) in
                                    
                                    BBQHud.pop()
                                    
                                    BBQHud.showInfo("上传头像失败")
                            })
                            .disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    BBQHud.pop()
                    
                    BBQHud.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
}
extension BBQUserInfoBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
