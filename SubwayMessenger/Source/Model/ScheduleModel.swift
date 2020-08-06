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
    
    enum CodingKeys: String, CodingKey {
        case realtimeArrivalList
    }
}

struct ScheduleInfo: Decodable {
    
}

//"realtimeArrivalList" : [
//   {
//     "arvlMsg2" : "3분 35초 후 (삼성중앙)",
//     "statnFid" : "1009000925",
//     "endRow" : null,
//     "subwayId" : "1009",
//     "trainCo" : null,
//     "btrainNo" : "9061",
//     "rowNum" : 1,
//     "barvlDt" : "215",
//     "statnId" : "1009000926",
//     "statnTid" : "1009000927",
//     "arvlMsg3" : "삼성중앙",
//     "totalCount" : 4,
//     "subwayNm" : null,
//     "btrainSttus" : null,
//     "subwayHeading" : "오른쪽",
//     "trainLineNm" : "개화행 - 신논현방면",
//     "ordkey" : "01002개화0",
//     "pageRow" : null,
//     "statnNm" : "언주",
//     "bstatnNm" : "개화",
//     "recptnDt" : "2020-08-06 09:48:17.0",
//     "statnList" : "1009000926",
//     "curPage" : null,
//     "subwayList" : "1009",
//     "beginRow" : null,
//     "selectedCount" : 4,
//     "arvlCd" : "99",
//     "bstatnId" : "928",
//     "updnLine" : "상행"
//   }
