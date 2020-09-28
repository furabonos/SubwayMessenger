//
//  SubwayModel.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/09/24.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation

struct SubwayModel: Decodable {
    var searchInfoBySubwayNameService: SearchInfoBySubwayNameService
    
    enum CodingKeys: String, CodingKey {
        case searchInfoBySubwayNameService = "SearchInfoBySubwayNameService"
    }
}

struct SearchInfoBySubwayNameService: Decodable {
    var listTotalCount: Int
    var result: ResultModel
    var row: [SubwayInfoModel]
    
    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
        case row
    }
}

struct ResultModel: Decodable {
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case code = "CODE"
    }
}

struct SubwayInfoModel: Decodable {
    var stationCD: String
    var stationNM: String
    var lineNum: String
    var frCode: String
    
    enum CodingKeys: String, CodingKey {
        case stationCD = "STATION_CD"
        case stationNM = "STATION_NM"
        case lineNum = "LINE_NUM"
        case frCode = "FR_CODE"
    }
}
