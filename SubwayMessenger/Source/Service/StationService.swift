//
//  StationService.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/09/24.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation
import Alamofire

protocol StationServiceType {
    func findSchedule(station: String, completion: @escaping (Result<ScheduleModel>) -> ())
}

struct StationService: StationServiceType {
    
    func findSchedule(station: String, completion: @escaping (Result<ScheduleModel>) -> ()) {
        
        Alamofire.request(ETCMethod.makeScheduleURL(stations: station, appKey: API.openAppKey), method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode(ScheduleModel.self, from: value)
                        completion(Result.success(decodableValue))
                    } catch {
                        
                    }
                case .failure(let error):
                    print("error = \(error)")
                    completion(.failure(nil, error))
                }
        }
        
    }
}
