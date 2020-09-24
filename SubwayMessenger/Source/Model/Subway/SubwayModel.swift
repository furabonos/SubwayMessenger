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

//"SearchInfoBySubwayNameService": {
//    "list_total_count": 3,
//    "RESULT": {
//        "CODE": "INFO-000",
//        "MESSAGE": "정상 처리되었습니다"
//    },
//    "row": [
//        {
//            "STATION_CD": "0205",
//            "STATION_NM": "동대문역사문화공원",
//            "LINE_NUM": "02호선",
//            "FR_CODE": "205"
//        },
//        {
//            "STATION_CD": "0422",
//            "STATION_NM": "동대문역사문화공원",
//            "LINE_NUM": "04호선",
//            "FR_CODE": "422"
//        },
//        {
//            "STATION_CD": "2537",
//            "STATION_NM": "동대문역사문화공원",
//            "LINE_NUM": "05호선",
//            "FR_CODE": "536"
//        }
//    ]
//}
