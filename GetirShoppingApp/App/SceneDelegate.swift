//
//  SceneDelegate.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 9.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.windowScene = scene

        let vc = ProductListingRouter.createModule()
        let navController = UINavigationController(rootViewController: vc)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .bgPrimary
        appearance.titleTextAttributes = [.foregroundColor: UIColor.bgLight]
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        window?.rootViewController = navController
    }
}
