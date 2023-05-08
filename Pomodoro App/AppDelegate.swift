//
//  AppDelegate.swift
//  Pomodoro App
//
//  Created by Абзал Бухарбай on 07.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = createTabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func createTabBarController() -> UITabBarController {
        let mainViewController = MainViewController()
        mainViewController.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house.circle.fill"), tag: 0)
        
        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        let historyViewController = HistoryViewController()
        historyViewController.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "doc"), tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainViewController, settingsViewController, historyViewController]
        tabBarController.tabBar.tintColor = UIColor.white
        tabBarController.tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBarController.viewControllers = [mainViewController, settingsViewController, historyViewController]
        
        return tabBarController
    }
    
}

