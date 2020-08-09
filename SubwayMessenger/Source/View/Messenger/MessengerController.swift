//
//  MessengerController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/05.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class MessengerController: BaseViewController {
    
    var ssss: MessengerServiceType = MessengerService()
    var llist: [StationPoi] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        print("messengerView")
        ssss.findSchedule(station: "언주") { (result) in
            switch result {
            case .success(let value):
                print("zz = \(value)")
            case .failure(let error):
                print("fsf = \(error)")
            }
        }
//        let lat = "37.50848388671875"
//        let lon = "127.03744043284128"
//        ssss.findStation(lat: lat, lon: lon) { (result) in
//            switch result {
//            case .success(let value):
////                print("xx = \(value.searchPoiInfo.pois)")
//                self.llist = value.searchPoiInfo.pois.poi
//            case .failure(let error):
//                print("zzz = \(error)")
//            }
//        }
    }
    
    override func setupUI() {
        print("z")
    }
    
    override func setupConstraints() {
        print("Z")
    }

}
