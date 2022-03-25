//
//  DeviceListViewController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import UIKit
import MJRefresh

class DeviceListViewController: BaseViewController {
    
    var vm: AccountBindViewModel?
    let header = ContentView(frame: .zero)
    let tableView = UITableView(frame: .zero, style: .plain)
    let refreshHeader = MJRefreshNormalHeader()
    
    convenience init(mobile: String, pageType: PageType) {
        self.init(nibName: nil, bundle: nil)
        vm = AccountBindViewModel(input: mobile, pageType: pageType, refresh: refreshHeader.rx.refresh.asObservable())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindData()
    }
    
    func bindData() {
        guard let vm = vm else { return }
        // 设置header标题
        vm.headers ~> header.rx.titles ~ rx.disposeBag
        // 管理刷新状态
        vm.refreshState ~> tableView.rx.refreshAction ~ rx.disposeBag
        // 绑定数据
        vm.refreshData.bind(to: tableView.rx.items(cellIdentifier: NSStringFromClass(SecondViewCell.self), cellType: SecondViewCell.self)) { _, model, cell in
            cell.labelArray[0].text = model.first
            cell.labelArray[1].text = model.second
            cell.labelArray[2].text = model.third
            cell.labelArray[3].text = model.forth
        }.disposed(by: rx.disposeBag)
    }
    
    func setUI() {
        view.addSubviews([header, tableView])
        
        tableView.rowHeight = 100
        tableView.register(SecondViewCell.self, forCellReuseIdentifier: NSStringFromClass(SecondViewCell.self))
        tableView.mj_header = refreshHeader
        
        header.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(NAV_HEIGHT)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(header.snp.bottom)
        }
    }
}
