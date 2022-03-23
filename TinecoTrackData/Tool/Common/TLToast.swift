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
    static func loading() {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.makeToastActivity(.center)
        }
    }
    static func dismiss() {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.hideToastActivity()
        }
    }
}
