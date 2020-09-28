//
//  SearchDetailViewModel.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/09/27.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation

class SearchDetailViewModel {
    
    private let stationService: StationServiceType = StationService()
    
    var stationList: [SubwayInfoModel] = []
    
    func findStations(stations: String, completion: @escaping (String) -> Void) {
        stationService.findStation(station: stations) { (result) in
            switch result {
            case .success(let value):
                print("으악 = \(value)")
                if value.searchInfoBySubwayNameService.result.code == "INFO-000" {
                    self.stationList = value.searchInfoBySubwayNameService.row
                    print("Fdfsdfdsfsdfsdfds = \(self.stationList.count)")
                }
                completion("success")
            case .failure(let error):
                completion("failure")
                print("error messege = \(error)")
            }
        }
    }
    
}
