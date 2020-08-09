//
//  MessengerService.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/09.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation
import Alamofire

protocol MessengerServiceType {
    func findStation(lat: String, lon: String, completion: @escaping (Result<StationModel>) -> ())
    func findSchedule(station: String, completion: @escaping (Result<ScheduleModel>) -> ())
}

struct MessengerService: MessengerServiceType {
    
    func findStation(lat: String, lon: String, completion: @escaping (Result<StationModel>) -> ()) {
        
        let headers = ["appKey": API.skAppKey]
        
        var parameters = [String: String]()
        parameters.updateValue("1", forKey: "version")
        parameters.updateValue(lat, forKey: "centerLat")
        parameters.updateValue(lon, forKey: "centerLon")
        parameters.updateValue("지하철", forKey: "categories")
        parameters.updateValue("3", forKey: "count")
        
        Alamofire.request(API.Messenger.findSubway, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode(StationModel.self, from: value)
                        completion(Result.success(decodableValue))
                    } catch {
                        
                    }
                case .failure(let error):
                    print("error = \(error)")
                    completion(.failure(nil, error))
                }
        }
    }
    
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
