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
    
}
