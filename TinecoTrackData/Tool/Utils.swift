//
//  Utils.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/25.
//

import Foundation
import UIKit

struct Utils {
    static let nav_height = UIApplication.shared.statusBarFrame.height+44
    static let screen_width = UIScreen.main.bounds.size.width.float
}
extension Utils {
    static func currentViewController() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for  windowTemp  in windows where windowTemp.windowLevel == UIWindow.Level.normal {
                window = windowTemp
                break
            }
        }
        let vc = window?.rootViewController
        return self.currentViewController(vc)
    }
    
    static func currentViewController(_ vc: UIViewController?) -> UIViewController? {
        if vc == nil {
            return nil
        }
        if let presentVC = vc?.presentedViewController {
            return currentViewController(presentVC)
        } else if let tabVC = vc as? UITabBarController {
            if let selectVC = tabVC.selectedViewController {
                return currentViewController(selectVC)
            }
            return nil
        } else if let naiVC = vc as? UINavigationController {
            return currentViewController(naiVC.visibleViewController)
        } else {
            return vc
        }
    }
}
