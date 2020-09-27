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
    func findStation(station: String, completion: @escaping (Result<SubwayModel>) -> ())
}

struct StationService: StationServiceType {
    
    func findStation(station: String, completion: @escaping (Result<SubwayModel>) -> ()) {
        
        Alamofire.request(ETCMethod.makeStationURL(stations: station, appKey: API.openAppKey), method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode(SubwayModel.self, from: value)
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
