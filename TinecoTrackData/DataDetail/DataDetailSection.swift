//
//  DataDetailSection.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/3.
//

import Foundation
import RxDataSources

struct DataDetailSection {

    var title_section: String
    var value_section: String = ""
    
    var items: [DataDetailModel]
    
}
 
extension DataDetailSection: SectionModelType {
    
    typealias Item = DataDetailModel
    
    var identity: String {
        return title_section
    }
    
    init(original: DataDetailSection, items: [DataDetailModel]) {
        self = original
        self.items = items
    }
}
