//
//  AppDelegate.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/08/05.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var naviController: UINavigationController?
    let navigator = Navigator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRoot()
        return true
    }
    
    func setupRoot() {
       window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: TabbarController())
        navController.isNavigationBarHidden = true
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    


}

