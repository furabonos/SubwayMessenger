//
//  TabbarController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/05.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {
    
    let navigator = Navigator()

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstView = navigator.navigate(at: .messenger)
        let secondView = navigator.navigate(at: .subway)
        let tabList = [firstView, secondView]
        tabList[0].title = "messenger"
        tabList[1].title = "subway"
        viewControllers = tabList
    }

}
