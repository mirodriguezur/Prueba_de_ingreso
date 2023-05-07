//
//  AppDelegate.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let mainNavigationController = UINavigationController(rootViewController: UsersViewController())
        window.rootViewController = mainNavigationController
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }

}

