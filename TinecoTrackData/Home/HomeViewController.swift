//
//  ViewController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/22.
//

import UIKit
class HomeViewController: BaseViewController {
    
    let scrollView = UIScrollView()
    let viewModel = OperationViewModel()
    
    let operation1 = OperationView(section: 0)
    let operation2 = OperationView(section: 1)
    let operation3 = OperationView(section: 2)
    
    var views = [OperationView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "首页"
        view.backgroundColor = UIColor.white
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(operation1)
        scrollView.addSubview(operation2)
        scrollView.addSubview(operation3)
        
        operation1.snp.makeConstraints { make in
            make.left.width.top.equalToSuperview()
        }
        operation2.snp.makeConstraints { make in
            make.left.width.equalToSuperview()
            make.top.equalTo(operation1.snp.bottom)
        }
        operation3.snp.makeConstraints { make in
            make.left.width.bottom.equalToSuperview()
            make.top.equalTo(operation2.snp.bottom)
        }
        views = [operation1, operation2, operation3]
        
        self.viewModel.sourceDataSubject.subscribe {[weak self] event in
            guard let self = self, let model = event.element else { return  }
            self.views[model.section].model = model
        }.disposed(by: bag)
        
    }
}
