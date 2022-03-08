//
//  SectionHeaderModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/28.
//

import UIKit
import SwiftyJSON
struct SectionModel {
    
    var event_selected_list: [SectionItemModel] {
        [event_name_list.first(where: { $0.is_selected})!,
         event_time_list.first(where: { $0.is_selected})!,
         event_device_list.first(where: { $0.is_selected})!,
         event_version_list.first(where: { $0.is_selected})!,
         event_platform_list.first(where: { $0.is_selected})!]
    }
    
    var event_name_list: [SectionItemModel]
    var event_time_list: [SectionItemModel]
    var event_device_list: [SectionItemModel]
    var event_version_list: [SectionItemModel]
    var event_platform_list: [SectionItemModel]
    
    init(_ json: JSON) {
        event_name_list = json["event_name_list"].arrayValue.compactMap {SectionItemModel($0)}
        event_time_list = json["event_time_list"].arrayValue.map {SectionItemModel($0)}
        event_device_list = json["event_device_list"].arrayValue.map {SectionItemModel($0)}
        event_version_list = json["event_version_list"].arrayValue.map {SectionItemModel($0)}
        event_platform_list = json["event_platform_list"].arrayValue.map {SectionItemModel($0)}
        
    }
    subscript(index: Int) -> [SectionItemModel] {
        get {
            if index == 0 {
                return event_name_list
            } else if index == 1 {
                return event_time_list
            } else if index == 2 {
                return event_device_list
            } else if index == 3 {
                return event_version_list
            } else {
                return event_platform_list
            }
        }
        set(newValue) {
            if index == 0 {
                event_name_list = newValue
            } else if index == 1 {
                event_time_list = newValue
            } else if index == 2 {
                event_device_list = newValue
            } else if index == 3 {
                event_version_list = newValue
            } else if index == 4 {
                event_platform_list = newValue
            }
        }
    }
}
struct SectionItemModel {
    
    let name: String
    let category_id: Int
    
    var is_selected = false
    var item_width: Float {
        name.ga_widthForComment(fontSize: 13).nextUp.float
    }
    init(_ json: JSON) {
        name = json["name"].stringValue
        category_id = json["category_id"].intValue
        is_selected = json["is_selected"].boolValue
    }
}
