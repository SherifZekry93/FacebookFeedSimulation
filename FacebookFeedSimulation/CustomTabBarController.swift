//
//  TabBarController.swift
//  FacebookFeedSimulation
//
//  Created by Sherif  Wagih on 9/12/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let facebookHomePage = ViewController(collectionViewLayout: layout)
        let mainNavigationController = UINavigationController(rootViewController:facebookHomePage)
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        mainNavigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        mainNavigationController.title = "Home"
        
        let viewController = FriendRequestViewController(collectionViewLayout: layout)
        viewController.navigationController?.navigationBar.isTranslucent = false
        let secondNavController = UINavigationController(rootViewController: viewController)
        secondNavController.title = "Friend Requests"
        secondNavController.tabBarItem.image = UIImage(named: "requests_icon")
        
        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = .red
        let thirdNav = UINavigationController(rootViewController: viewController3)
        thirdNav.tabBarItem.image = UIImage(named: "messenger_icon")
        thirdNav.title = "Messages"
        
        viewControllers = [mainNavigationController,secondNavController,thirdNav]
        
        tabBar.isTranslucent = false
    }
}
