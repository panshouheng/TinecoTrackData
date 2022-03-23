//
//  DeviceListViewController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import UIKit

class DeviceListViewController: BaseViewController {
    
    var vm: AccountBindViewModel?
    let header = ContentView(frame: .zero)
    let tableView = UITableView(frame: .zero, style: .plain)
    
    convenience init(mobile: String, pageType: PageType) {
        self.init(nibName: nil, bundle: nil)
        vm = AccountBindViewModel(mobile: mobile, pageType: pageType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vm = vm else { return }
        
        view.addSubviews([header, tableView])
        
        header.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(NAV_HEIGHT)
            make.height.equalTo(44)
        }
        
        tableView.rowHeight = 40
        tableView.register(SecondViewCell.self, forCellReuseIdentifier: NSStringFromClass(SecondViewCell.self))
        
        tableView.mj_header = MJRefreshNormalHeader.init()
        
        vm.headers.bind(to: header.rx.titles).disposed(by: rx.disposeBag)
        if vm.pageType == .BindProduct {
            vm.productData.bind(to: tableView.rx.items(cellIdentifier: NSStringFromClass(SecondViewCell.self), cellType: SecondViewCell.self)) { _, model, cell in
                cell.labelArray[0].text = model.nickname
                cell.labelArray[1].text = model.type
                cell.labelArray[2].text = model.snCode
                cell.labelArray[3].text = model.productId
            }.disposed(by: rx.disposeBag)
        } else {
            vm.deivceData.bind(to: tableView.rx.items(cellIdentifier: NSStringFromClass(SecondViewCell.self), cellType: SecondViewCell.self)) { _, model, cell in
                cell.labelArray[0].text = model.model
                cell.labelArray[1].text = model.systemVersion
                cell.labelArray[2].text = model.deviceNum
                cell.labelArray[3].text = model.appVersion
            }.disposed(by: rx.disposeBag)
        }
        
        // Do any additional setup after loading the view.
    }
    
}