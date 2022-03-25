//
//  StringEx.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/4.
//

import UIKit
import CommonCrypto
extension String {
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [NSAttributedString.Key.font: font],
                                                       context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [NSAttributedString.Key.font: font],
                                                       context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [NSAttributedString.Key.font: font],
                                                       context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}

extension String {
    var name_chinese: String {
        switch self {
        case "event": return "事件名称\n(event)"
        case "time": return "时间\n(time)"
        case "distinct_id": return "唯一识别\n(distinct_id)"
        case "device_id": return "UUID\n(device_id)"
        case "properties": return "属性\n(Properties)"
        case "app_version": return "App版本号\n(app_version)"
        case "manufacturer": return "制造商\n(manufacturer)"
        case "os": return "系统平台\n(os)"
        case "model": return "手机标识\n(model)"
        case "os_version": return "手机版本号\n(os_version)"
        case "lib": return "SDK平台\n(lib)"
        case "lib_version": return "SDK版本\n(lib_version)"
        case "phone_type": return "手机型号\n(phone_type)"
        case "screen_name": return "界面类名\n(screen_name)"
        case "screen_title": return "界面标题\n(screen_title)"
        case "params": return "请求参数\n(params)"
        case "request_url": return "请求地址\n(request_url)"
        case "request_type": return "请求类型\n(request_type)"
        case "event_duration": return "持续时长(毫秒)\n(event_duration)"
        case "element_content": return "控件内容\n(element_content)"
        case "element_type": return "控件类型\n(element_type)"
        default:
            return self
        }
    }
}

extension String {
    static let random_str_characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func randomStr(len: Int) -> String {
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
}
extension String {
    var md5: String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format: "%02X", $1) }
    }
}

extension String {
    var phone: String {
        switch self {
        case "iPhone3,1": return "iPhone 4"
        case "iPhone3,2": return "iPhone 4"
        case "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1": return "iPhone 5"
        case "iPhone5,2": return "iPhone 5"
        case "iPhone5,3": return "iPhone 5c"
        case "iPhone5,4": return "iPhone 5c"
        case "iPhone6,1": return "iPhone 5s"
        case "iPhone6,2": return "iPhone 5s"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iiPhone SE"
        case "iPhone9,1": return "iPhone 7"
        case "iPhone9,3": return "iPhone 7"
        case "iPhone9,2": return "iPhone 7 Plus"
        case "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1": return "iPhone 8"
        case "iPhone10,4": return "iPhone 8"
        case "iPhone10,2":  return "iPhone 8 Plus"
        case "iPhone10,5":  return "iPhone 8 Plus"
        case "iPhone10,3": return "iPhone X"
        case "iPhone10,6": return "iPhone X"
        case "iPhone11,8":  return "iPhone XR"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,6": return "iPhone XS Max"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE (2nd generation)"
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPhone14,4": return "iPhone 13 mini"
        case "iPhone14,5": return "iPhone 13"
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
        case "iPhone14,6": return "iPhone SE (3rd generation)"
        default:
            return self
        }
    }
}
