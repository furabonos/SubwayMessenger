//
//  Navigator.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/08/05.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

struct Navigator {
    
    enum Scene {
        case messenger
        case complaints(lineN: String, trainN: String)
        case subway
    }
    
    func navigate(at scene: Scene) -> UIViewController {
        switch scene {
        case .messenger:
            let viewController: MessengerController = MessengerController()
            return viewController
        case .complaints(lineN: let lineNumber, trainN: let trainNumber):
            let viewController: ComplaintsViewController = ComplaintsViewController(line: lineNumber, train: trainNumber)
            return viewController
        case .subway:
            let viewController: TestViewController = TestViewController()
            return viewController
        }
    }
}
