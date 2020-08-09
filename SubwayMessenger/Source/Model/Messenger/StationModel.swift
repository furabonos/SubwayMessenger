//
//  StationModel.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/06.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import Foundation

struct StationModel: Decodable {
    var searchPoiInfo: StationInfo
    
    enum CodingKeys: String, CodingKey {
        case searchPoiInfo
    }
}

struct StationInfo: Decodable {
    var count: Int
    var pois: Poi
    
    enum CodingKeys: String, CodingKey {
        case count, pois
    }
}

struct Poi: Decodable {
    var poi: [StationPoi]
    
    enum CodingKeys: String, CodingKey {
        case poi
    }
}

struct StationPoi: Decodable {
    var name: String
    var telNo: String
    var roadName: String
    var middleAddrName: String
    var lowerAddrName: String
    
    enum CodingKeys: String, CodingKey {
        case name, telNo, roadName, middleAddrName, lowerAddrName
    }
}
