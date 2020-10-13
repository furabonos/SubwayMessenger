//
//  StationCellViewModel.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/09/28.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation

class StationCellViewModel {
    
    var stationCD: Int
    var stationNM: String
    var lineNum: String
    var frCode: Int
    
//    init(content: SubwayInfoModel) {
//        self.stationCD = content.stationCD
//        self.stationNM = content.stationNM
//        self.lineNum = content.lineNum
//        self.frCode = content.frCode
//    }
    
    init(content: [String: Any]) {
        self.stationCD = content["stationID"] as! Int
        self.stationNM = content["stationName"] as! String
        self.lineNum = content["laneName"] as! String
        self.frCode = content["stationID"] as! Int
    }
    
}
