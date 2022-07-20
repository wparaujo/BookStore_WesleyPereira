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
        
        let favoriteViewController = FavoriteBookFactory.make()
        let favoriteNavigationController = UINavigationController(
            rootViewController: favoriteViewController
        )
        
        navigationController.tabBarItem.title = "home"
        navigationController.tabBarItem.image = .init(systemName: "house")
        
        favoriteNavigationController.tabBarItem.title = "favorites"
        favoriteNavigationController.tabBarItem.image = .init(systemName: "star.fill")
        
        viewControllers = [navigationController, favoriteNavigationController]
    }

}
