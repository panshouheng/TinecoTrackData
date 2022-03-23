//
//  MainTabBarController.swift
//  TinecoTrackData
//
//  Created by psh on 2022/3/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
            self.setUpTabBar()
        }
        // MARK: - 控制器的信息
        func setUpTabBar() {
            
            let home  = HomeViewController()
            let my  = MyViewController()
            
            creatTabbarView(viewController: home, image: "", selectImage: "", title: "首页", tag: 1)
            creatTabbarView(viewController: my, image: "", selectImage: "", title: "我的", tag: 2)
            
            self.viewControllers = [UINavigationController(rootViewController: home), UINavigationController(rootViewController: my)]
        }
        
        // MARK: - TabBar里面的文字图片
        func creatTabbarView(viewController: UIViewController, image: NSString, selectImage: NSString, title: NSString, tag: NSInteger) {
            // alwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
            viewController.tabBarItem.image = UIImage(named: image as String)?.withRenderingMode(.alwaysOriginal)
            viewController.tabBarItem.selectedImage = UIImage(named: selectImage as String)?.withRenderingMode(.alwaysOriginal)
            viewController.title = title as String
            viewController.tabBarItem.tag = tag
        }

}
