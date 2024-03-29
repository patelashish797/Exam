//
//  AppDelegate.swift
//  Exam
//
//  Created by Ashish Patel on 3/30/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.navController.navigationBar.isTranslucent = false
        let homeViewController = HomeViewController()
        self.navController.pushViewController(homeViewController, animated: false)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let appWindow = self.window {
            appWindow.rootViewController = navController
            appWindow.backgroundColor = UIColor.white
            appWindow.makeKeyAndVisible()
        }
        return true
    }

}

