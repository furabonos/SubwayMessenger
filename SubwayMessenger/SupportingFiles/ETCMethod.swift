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
    
    static func selectLineTel(info: Array<String>) {
        var line = info[1]
        var station = info[0]
        
        switch line {
        case "1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선":
            stationSel(station: station)
        case "9호선":
            UserDefaults.standard.set("seoul", forKey: "number")
        case "경의중앙선", "분당선", "공항철도":
            UserDefaults.standard.set("korail", forKey: "number")
        default:
            let alert = UIAlertController(title: "안내", message: "현재 해당 철도는 서비스를 지원하지 않고있습니다.꺼져", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            DispatchQueue.main.async {
                if let topController = UIApplication.topViewController() {
                    topController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    static func stationSel(station: String) {
        switch station {
        case "서울", "시청", "종각", "종로3가", "종로5가", "동대문", "동묘앞", "신설동", "제기동", "청량리", "대화", "주엽", "정발산", "마두", "백석", "대곡", "화정", "원당", "원흥", "삼송", "지축", "오이도", "정왕", "신길온천", "안산", "초지", "고잔", "중앙", "한대앞", "상록수", "반월", "대야미", "수리산", "산본", "금정", "범계", "평촌", "인덕원", "정부과천청사", "과천", "대공원", "경마공원", "선바위":
            UserDefaults.standard.set("korail", forKey: "number")
        default:
            UserDefaults.standard.set("metro", forKey: "number")
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
