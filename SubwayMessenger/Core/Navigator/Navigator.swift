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
        case memo(lineN: String, trainN: String)
        case subway
        case send
        case search
    }
    
    func navigate(at scene: Scene) -> UIViewController {
        switch scene {
        case .messenger:
            let viewController: MessengerController = MessengerController()
            return viewController
        case .complaints(lineN: let lineNumber, trainN: let trainNumber):
            let viewController: ComplaintsViewController = ComplaintsViewController(line: lineNumber, train: trainNumber)
            return viewController
        case .memo(lineN: let lineNumber, trainN: let trainNumber):
            let viewController: MemoViewController = MemoViewController(line: lineNumber, train: trainNumber)
            return viewController
        case .subway:
            let viewController: SubwayViewController = SubwayViewController()
            return viewController
        case .send:
            let viewController = SendViewController()
            return viewController
        case .search:
            let viewController = SearchViewController()
            return viewController
        }
    }
}
