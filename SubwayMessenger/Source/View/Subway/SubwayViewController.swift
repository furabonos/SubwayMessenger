//
//  SubwayViewController.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/09/23.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import Alamofire
//import swifty

class SubwayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        // Do any additional setup after loading the view.
        Alamofire.request(ETCMethod.makeStationURL(stations: "송내", appKey: API.openAppKey), method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode(SubwayModel.self, from: value)
                        print("성공 = \(decodableValue.searchInfoBySubwayNameService.row[0].lineNum)")
//                        completion(Result.success(decodableValue))
                    } catch {
                        
                    }
                case .failure(let error):
                    print("error = \(error)")
//                    completion(.failure(nil, error))
                }
        }
        
    }

}
