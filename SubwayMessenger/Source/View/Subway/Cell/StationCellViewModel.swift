//
//  StationCellViewModel.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/09/28.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation

class StationCellViewModel {
    
    var stationCD: String
    var stationNM: String
    var lineNum: String
    var frCode: String
    
    init(content: SubwayInfoModel) {
        self.stationCD = content.stationCD
        self.stationNM = content.stationNM
        self.lineNum = content.lineNum
        self.frCode = content.frCode
    }
    
}
