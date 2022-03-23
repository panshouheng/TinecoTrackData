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
        guard let nav = Utils.currentViewController()?.navigationController else { return TLLog("没找到导航控制器") }
        var vc = BaseViewController()
        switch (model.section, buttonConfig.item) {
        case (0, let item):
            guard inputText.isNumeric else { TLToast.show("手机号无效"); return }
            vc = DeviceListViewController(mobile: inputText, pageType: item==0 ? .BindDevice:.BindProduct)
        case (_, _):
            vc = BaseViewController()
        }
        vc.title = buttonConfig.button_title
        vc.hidesBottomBarWhenPushed = true
        nav.pushViewController(vc, completion: nil)
    }
}
