//
//  AppDelegate.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/22.
//

import UIKit
import IQKeyboardManagerSwift
import Reachability
import RxReachability
import RxSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var reachability: Reachability?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        self.window = window
        window.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        reachability = try? Reachability()
        try? reachability?.startNotifier()
        
        if let user = User.fetch(), user.expired == false {
            TLLog(user)
            TLLog(WCDBManager.path)
            window.rootViewController = MainTabBarController()
        } else {
            User.delete()
            window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        
        return true
    }
}
