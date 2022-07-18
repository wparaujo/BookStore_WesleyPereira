//
//  TabBarController.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 17/07/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().backgroundColor = .white
        let initialViewController = BookStoreFactory.make()
        let navigationController = UINavigationController(
            rootViewController: initialViewController
        )
        navigationController.tabBarItem.title = "home"
        navigationController.tabBarItem.image = .init(systemName: "house")
        viewControllers = [navigationController]
    }

}
