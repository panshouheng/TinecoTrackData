//
//  SecondViewController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/24.
//

import UIKit

class SecondViewController: BaseViewController {
    
    let viewModel = SecondViewModel()
    
    let section = SectionHeaderView()
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var mobile: String = ""
    
    init(mobile: String) {
        super.init(nibName: nil, bundle: nil)
        self.mobile = mobile
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initViews()
        dataBinding()
        
    }
    func initViews() {
        view.addSubview(section)
        section.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(NAV_HEIGHT)
        }
        
        view.addSubview(tableView)
        tableView.rowHeight = 40
        tableView.register(SecondViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.top.equalTo(section.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    func dataBinding() {
        viewModel.headerSourceSubject.bind(to: section.reloadSubject).disposed(by: rx.disposeBag)
        section.itemSelected.bind(to: viewModel.headerItemSelected).disposed(by: rx.disposeBag)
        
        viewModel.bodyDataSubject.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: SecondViewCell.self)) { _, model, cell in
            cell.labelArray[0].text = model.event
            cell.labelArray[1].text = Date(unixTimestamp: model.time.double()!/1000).dateString(ofStyle: .short)
            cell.labelArray[2].text = model.distinct_id
            cell.labelArray[3].text = model.properties.app_version
            cell.labelArray[4].text = model.properties.os
        }.disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected.subscribe {[unowned self] event in
            guard let indexPath = event.element else { return  }
            let dataDetail = DataDetailViewController(self.viewModel.sourceData[indexPath.row])
            Utils.currentViewController()?.navigationController?.pushViewController(dataDetail, animated: true)
        }.disposed(by: rx.disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SelectPopView.dismiss()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        SelectPopView.dismiss()
    }
    
    deinit {
        TLLog("销毁了")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
