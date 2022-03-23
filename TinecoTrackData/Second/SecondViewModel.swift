//
//  SecondViewModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/1.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON
import Moya
class SecondViewModel: NSObject {
    
    public var headerSourceSubject = BehaviorRelay<[SectionItemModel]>(value: [])
    public var headerItemSelected = PublishSubject<(IndexPath, CGRect)>()
    public var bodyDataSubject = BehaviorRelay<[DataObject]>(value: [])
    
    var model = SectionModel(JSON())
    var sourceData = [[String: Any]]()
    
    var selectedIndex = 0
    
    override init() {
        super.init()
        
        self.initSourceData()
        self.getData()
        headerItemSelected.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe { [weak self] event in
            guard let (indexPath, location) = event.element, let self = self else { return }
            if self.selectedIndex == indexPath.item && SelectPopView.isShowing {
                SelectPopView.dismiss()
                return
            }
            self.selectedIndex = indexPath.item
            SelectPopView.show(location, self.model[indexPath.row]) { selectModel, index in
                print(selectModel.name)
                
                for idx in 0..<self.model[indexPath.row].count {
                    self.model[indexPath.row][idx].is_selected = false
                }
                self.model[indexPath.row][index].is_selected = true
                self.headerSourceSubject.accept(self.model.event_selected_list)
            }
        }.disposed(by: rx.disposeBag)
        
        loadDatas()
    }
    
    func initSourceData () {
        
//        guard let path = Bundle.main.path(forResource: "typesdata", ofType: "json") else { return }
//        let url = URL(fileURLWithPath: path)
//        do {
//            let data = try Data(contentsOf: url)
//            self.model = SectionModel(JSON(data))
//            self.model.event_device_list[0].is_selected = true
//            self.model.event_name_list[0].is_selected = true
//            self.model.event_time_list[0].is_selected = true
//            self.model.event_platform_list[0].is_selected = true
//            self.model.event_version_list[0].is_selected = true
//            headerSourceSubject.accept(self.model.event_selected_list)
//        } catch let error as Error? {
//            print("读取本地数据出现错误!", error as Any)
//        }
    }
    
    func loadDatas() {
//        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return }
//        let url = URL(fileURLWithPath: path)
//        do {
//            let data = try Data(contentsOf: url)
//            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//            if let jsonArr = jsonData as? [[String: Any]] {
//                let datas = jsonArr.compactMap { DataObject(JSON($0)) }
//                self.sourceData = jsonArr
//                self.bodyDataSubject.accept(datas)
//            }
//            
//        } catch let error as Error? {
//            print("读取本地数据出现错误!", error as Any)
//        }
    }
    
    func getData() {

    }
    deinit {
        print("viewModel 销毁了")
    }
}
