//
//  TLToast.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/25.
//

import UIKit
import Toast_Swift

struct TLToast {
    static func show(_ msg: String?) {
        UIApplication.shared.keyWindow?.makeToast(msg)
    }
}
