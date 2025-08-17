//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Toha Shilin on 8.08.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let tabBarController = UITabBarController()
        if #available(iOS 17.0, *) {
            tabBarController.traitOverrides.userInterfaceIdiom = .phone
        } else {
            tabBarController.setOverrideTraitCollection(
                UITraitCollection(userInterfaceIdiom: .phone),
                forChild: tabBarController
            )
        }
        let habitsViewController = HabitsViewController()
        let infoViewController = InfoViewController()
        
        let habitsNavigationController = UINavigationController(rootViewController: habitsViewController)
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        
        habitsViewController.tabBarItem = UITabBarItem(
            title: "Привычки",
            image: UIImage(named: "habitsTabBarIcon"),
            selectedImage: UIImage(named: "habitsTabBarIcon")
        )
        
        infoNavigationController.tabBarItem = UITabBarItem(
            title: "Информация",
            image: UIImage(systemName: "info.circle"),
            selectedImage: UIImage(systemName: "info.circle.fill")
        )
        
        
        tabBarController.tabBar.tintColor = .systemPurple
        tabBarController.viewControllers = [habitsNavigationController, infoNavigationController]
        tabBarController.selectedIndex = 0
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

