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
    
    func findStations(stations: String, completion: @escaping (String) -> Void) {
        stationService.findStation(station: stations) { (result) in
            switch result {
            case .success(let value):
                print("으악 = \(value)")
                completion("success")
            case .failure(let error):
                completion("failure")
                print("error messege = \(error)")
            }
        }
    }
    
}
