//
//  DataDetailViewController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/2.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwiftyJSON
class DataDetailViewController: BaseViewController {
    
    var viewModel: DataDetailViewModel!
    var data: [String: Any]?
    
    init(_ data: [String: Any]) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
        viewModel = DataDetailViewModel.init(data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完整数据"
        
        let button = UIBarButtonItem.init(title: "复制整条数据", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItems = [button]

        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(DataDetailCell.self, forCellReuseIdentifier: "DataDetailCell")
        tableView.estimatedRowHeight = 44.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let  dataSource = RxTableViewSectionedReloadDataSource<DataDetailSection>.init { _, tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataDetailCell") as! DataDetailCell
            cell.titlelabel.text = item.key.name_chinese
            cell.subtitleLabel.text = item.value
            return cell
        } titleForHeaderInSection: { sectionData, index in
            return sectionData[index].title_section.name_chinese
        }
        viewModel.dataSubject.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
        
        tableView.rx.modelSelected(DataDetailModel.self).subscribe { event in
            guard let model = event.element else { return  }
            UIPasteboard.general.string = model.value
            TLToast.show("复制成功")
        }.disposed(by: bag)
        
        button.rx.tap.subscribe { _ in
            UIPasteboard.general.string = "\(self.data ?? [:])"
            TLToast.show("复制成功")
        }.disposed(by: bag)
}
}
