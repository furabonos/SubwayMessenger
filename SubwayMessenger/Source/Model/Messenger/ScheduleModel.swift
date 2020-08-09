//
//  ScheduleModel.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/06.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation


struct ScheduleModel: Decodable {
    var realtimeArrivalList: [ScheduleInfo]
    var errorMessage: ErrorModel
    
    enum CodingKeys: String, CodingKey {
        case realtimeArrivalList, errorMessage
    }
}

struct ScheduleInfo: Decodable {
    var arvlMsg: String
    var trainLineNm: String
    var btrainNo: String
    var arvlCd: String
    
    enum CodingKeys: String, CodingKey {
        case arvlMsg = "arvlMsg2"
        case trainLineNm, btrainNo, arvlCd
    }
}

struct ErrorModel: Decodable {
    var message: String
    var status: Int
    
    enum CodingKeys: String, CodingKey {
        case message, status
    }
}
