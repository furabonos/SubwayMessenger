//
//  SendViewModel.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/09/17.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation

class SendViewModel {
    
    private let messengerService: MessengerServiceType = MessengerService()
    
    var stationArr: [StationPoi] = []
    var schedulrArr: [ScheduleInfo] = []
    
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
