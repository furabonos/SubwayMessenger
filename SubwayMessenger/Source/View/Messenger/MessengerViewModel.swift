//
//  MessengerViewModel.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/10.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation

class MessengerViewModel {
    
    var messengerService: MessengerServiceType = MessengerService()
    
    var stationLineUp = ["1호선", "1호선(서울역-청량리)", "2호선", "3호선", "3호선(대화-지축)",  "4호선", "4호선(선바위-오이도)", "5호선", "6호선", "7호선", "8호선", "9호선"]
    var trainTel = ""
    var stationArr: [StationPoi] = []
    var schedulrArr: [ScheduleInfo] = []
    
    /**
     1~8호선 = 1577-1234
     9호선 = 1544-4009
     1호선서울청량, 3호선 대화지축, 4호선선바위오이도, 경의중앙선, 분당선, 공항철도 = 1544-7769
     
     민원종류
     에어컨,난방(온도)
     마스크미착용
     난동(소란)
     이동상인
     응급환자
     폭탄?
     이건 셀렉트박스로?
     */
    
    func findStation(lats: String, lons: String, completion: @escaping (String) -> Void) {
        messengerService.findStation(lat: lats, lon: lons) { (result) in
            switch result {
            case .success(let value):
                self.stationArr = value.searchPoiInfo.pois.poi
                completion("success")
            case .failure(let error):
                completion("failure")
                print("error messege = \(error)")
            }
        }
    }
    
    func findSchedule(stations: String, completion: @escaping (String) -> Void) {
        messengerService.findSchedule(station: stations) { (result) in
            switch result {
            case .success(let value):
                self.schedulrArr = value.realtimeArrivalList
                completion("success")
            case .failure(let error):
                completion("failure")
                print("error messege = \(error)")
            }
        }
    }
    
    
}
