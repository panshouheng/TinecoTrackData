//
//  OperationViewProtocol.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/25.
//

import Foundation

protocol OperationViewDelegate: AnyObject {
    func didSelect(_ inputText: String?, _ model: OperationModel, _ buttonConfig: ButtonConfig)
}

extension OperationViewDelegate {
    func didSelect(_ inputText: String?, _ model: OperationModel, _ buttonConfig: ButtonConfig) {
        guard let inputText = inputText, inputText.isEmpty == false else { TLToast.show("请输入相关参数"); return }
        print("\(buttonConfig.button_title)\(inputText)")
        let seco = SecondViewController()
        seco.title = buttonConfig.button_title
        guard let nav = Utils.currentViewController()?.navigationController else { return print("没找到导航控制器") }
        nav.pushViewController(seco, completion: nil)
        
    }
}
