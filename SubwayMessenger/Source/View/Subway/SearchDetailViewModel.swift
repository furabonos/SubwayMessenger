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
    var stationLists: [[String: Any]] = []
    
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
    
    func stationFind(stations: String, completion: @escaping (String) -> Void) {
        ODsayService.sharedInst()?.requestSearchStation(stations, cid: 1000, stationClass: "2", displayCnt: 5, startNo: 0, myLocation: "", responseBlock: { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
            guard let results = resultDic else {
                completion("failure")
                return
            }
            var ss = results["result"] as! [String: Any]
            var ss2 = ss["station"] as! Array<[String: Any]>
            for i in 0..<ss2.count {
                if ss2[i]["CID"] as! Int != 1000 {
                    ss2.remove(at: i)
                }
            }
            self.stationLists = ss2
            completion("success")
        })
    }
    
}
