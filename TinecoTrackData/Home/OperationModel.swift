//
//  OperationModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/24.
//

import Foundation

struct OperationModel {
    let title: String
    let subtitle: String
    let placeholder: String
    let titles_button: [ButtonConfig]
    let section: Int
    var inputText: String?
    
}

struct ButtonConfig {
    let button_title: String
    let item: Int
}
