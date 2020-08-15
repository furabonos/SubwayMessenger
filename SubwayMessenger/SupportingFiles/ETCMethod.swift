//
//  ETCMethod.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/09.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import Alamofire

class ETCMethod {
    
    static func makeScheduleURL(stations: String, appKey: String) -> URLConvertible {
        let urls = "http://swopenapi.seoul.go.kr/api/subway/\(appKey)/json/realtimeStationArrival/0/5/\(stations)"
        let scheduleURL = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) as! URLConvertible
        return scheduleURL
    }
    
    static func selectLineNum(line: Int) -> String {
        switch line {
        case 1, 2, 3, 5, 7, 8, 9, 10:
            return "1577-1234"
        case 0, 4, 6:
            return "1544-7769"
        case 11:
            return "1544-4009"
        default:
            return ""
        }
    }
    
    static func makeStationInfo(str: String) -> [String] {
        var strArr = Array<String>()
        var splits = str.components(separatedBy: "역[")
        var stationLine = splits[1].components(separatedBy: "]")
        strArr.append(splits[0])
        strArr.append(stationLine[0])
        return strArr
    }
}
