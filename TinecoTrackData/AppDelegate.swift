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
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        self.window = window
        window.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        return true
    }
}
