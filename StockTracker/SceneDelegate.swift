//
//  SceneDelegate.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let navigationVC = UINavigationController(rootViewController: FirstViewController())
            window.rootViewController = navigationVC
            self.window = window
            self.window?.makeKeyAndVisible()
        }
    }
}

