//
//  SceneDelegate.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 13/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
//        let initialViewController = BookStoreFactory.make()
//        let navigationController = UINavigationController(
//            rootViewController: initialViewController
//        )
        
        window.rootViewController = TabBarController()
        
        self.window = window
        window.makeKeyAndVisible()
        
    }
}

