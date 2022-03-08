//
//  DataDetailViewModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/3.
//

import Foundation
import RxCocoa
import SwifterSwift
class DataDetailViewModel {
    
    let dataSource: [String: Any]
    
    var dataSubject: BehaviorRelay<[DataDetailSection]> = BehaviorRelay(value: [])
    
    init(_ dataSource: [String: Any]) {
        self.dataSource = dataSource
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return  }
            
            var data = [DataDetailSection]()
            var otherDataSection = DataDetailSection.init(title_section: "基础", items: [])
            var datas = [DataDetailModel]()
            for key in dataSource.keys {
                if key.elementsEqual("properties") {
                    if let properties = dataSource[key] as? [String: Any] {
                        let propertiesData = properties.keys.map { DataDetailModel(key: $0, value: "\(properties[$0] ?? "")")}
                        data.append(DataDetailSection.init(title_section: key, value_section: "", items: propertiesData))
                    }
                } else {
                   datas.append(DataDetailModel(key: key, value: "\(dataSource[key] ?? "")"))
                }
            }
            otherDataSection.items = datas
            data.insert(otherDataSection, at: 0)
          self.dataSubject.accept(data)
        }
    }
}
