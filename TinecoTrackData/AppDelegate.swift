//
//  AppDelegate.swift
//  TinecoTrackData
//
//  Created by psh on 2022/2/22.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        self.window = window
        window.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        if UserDefaults.standard.string(forKey: "access_token") != nil {
            window.rootViewController = MainTabBarController()
        } else {
            window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        return true
    }
}
