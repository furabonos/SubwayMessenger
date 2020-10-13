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
    
    static func makeStationURL(stations: String, appKey: String) -> URLConvertible {
        let urls = "http://openapi.seoul.go.kr:8088/\(appKey)/json/SearchInfoBySubwayNameService/1/5/\(stations)"
        let stationURL = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) as! URLConvertible
        return stationURL
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
    
    static func makeSubwayLine(lines: String) -> String {
        return lines.replacingOccurrences(of: "0", with: "")
    }
    
    static func makeSubwayColor(lines: String) -> UIColor {
        switch lines {
        case "수도권 1호선":
            return UIColor(red: 38/255, green: 60/255, blue: 150/255, alpha: 1)
        case "수도권 2호선":
            return UIColor(red: 60/255, green: 180/255, blue: 74/255, alpha: 1)
        case "수도권 3호선":
            return UIColor(red: 240/255, green: 110/255, blue: 0/255, alpha: 1)
        case "수도권 4호선":
            return UIColor(red: 44/255, green: 158/255, blue: 222/255, alpha: 1)
        case "수도권 5호선":
            return UIColor(red: 137/255, green: 54/255, blue: 224/255, alpha: 1)
        case "수도권 6호선":
            return UIColor(red: 181/255, green: 80/255, blue: 10/255, alpha: 1)
        case "수도권 7호선":
            return UIColor(red: 105/255, green: 114/255, blue: 21/255, alpha: 1)
        case "수도권 8호선":
            return UIColor(red: 228/255, green: 30/255, blue: 110/255, alpha: 1)
        case "수도권 9호선":
            return UIColor(red: 209/255, green: 166/255, blue: 44/255, alpha: 1)
        case "수인.분당선":
            return UIColor(red: 235/255, green: 169/255, blue: 0/255, alpha: 1)
        case "인천 1호선":
            return UIColor(red: 111/255, green: 153/255, blue: 208/255, alpha: 1)
        case "수도권 공항철도":
            return UIColor(red: 115/255, green: 182/255, blue: 228/255, alpha: 1)
        case "인천 2호선":
            return UIColor(red: 115/255, green: 182/255, blue: 228/255, alpha: 1)
        case "경의중앙선":
            return UIColor(red: 124/255, green: 196/255, blue: 165/255, alpha: 1)
        case "수도권 에버라인":
            return UIColor(red: 119/255, green: 195/255, blue: 113/255, alpha: 1)
        case "수도권 경춘선":
            return UIColor(red: 9/255, green: 175/255, blue: 123/255, alpha: 1)
        case "수도권 신분당선":
            return UIColor(red: 167/255, green: 29/255, blue: 49/255, alpha: 1)
        case "수도권 의정부경전철":
            return UIColor(red: 255/255, green: 157/255, blue: 38/255, alpha: 1)
        case "수도권 경강선":
            return UIColor(red: 37/255, green: 115/255, blue: 242/255, alpha: 1)
        case "우이신설경전철":
            return UIColor(red: 198/255, green: 192/255, blue: 0/255, alpha: 1)
        case "수도권 서해선(소사-원시)":
            return UIColor(red: 140/255, green: 197/255, blue: 63/255, alpha: 1)
        case "김포골드라인":
            return UIColor(red: 150/255, green: 113/255, blue: 10/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
}
