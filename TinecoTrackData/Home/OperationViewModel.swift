//
//  OperationViewModel.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/24.
//

import Foundation
import RxSwift
import Moya
struct OperationViewModel {
    
    let bag = DisposeBag()
    
    var sourceDataSubject = BehaviorSubject<OperationModel>.from(Self.initData())
    static func initData() -> [OperationModel] {
        let titles = ["手机号-设备-设备故障信息\n手机号-手机-全埋点信息-埋点详情", "食万相关sn可通过账号查询\n设备sn-账号\n设备sn-连接手机情况（蓝牙连接情况）\n设备sn-嵌入式故障码、设备信息、屏幕及各个软件版本号信息", "设备sn-账号\n设备sn-设备信息-版本号、电池包、日志-故障"]
        let subtitles = ["账号", "食万SN码", "Wi-Fi设备SN码"]
        let placeholders = ["请输入用户手机号", "请输入设备SN码", "请输入设备SN码"]
        let title_buttons = [["查询该账号设备", "登录该设备的手机"], ["查询绑定食万账号", "食万链接手机详情", "食万与app指令", "食万嵌入式故障码"], ["查询绑定设备账号", "设备信息"]]
        
        var data = [OperationModel]()
        for index in 0..<titles.count {
            var buttons = [ButtonConfig]()
            for item in 0..<title_buttons[index].count {
                let config = ButtonConfig(button_title: title_buttons[index][item], item: item)
                buttons.append(config)
            }
            let model = OperationModel(title: titles[index],
                                       subtitle: subtitles[index],
                                       placeholder: placeholders[index],
                                       titles_button: buttons,
                                       section: index)
            data.append(model)
        }
        return data
    }
}
