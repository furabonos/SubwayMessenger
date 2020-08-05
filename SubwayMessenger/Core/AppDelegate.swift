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



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRoot()
        return true
    }
    
    func setupRoot() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.backgroundColor = .blue
        window?.makeKeyAndVisible()
    }


}

