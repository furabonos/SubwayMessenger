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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
//        cv.delegate = self
//        cv.dataSource = self
//        cv.register(StraightCell.self, forCellWithReuseIdentifier: self.straightCell)
//        cv.register(GADCell.self, forCellWithReuseIdentifier: self.gadCell)
//        cv.register(MainHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.mainHeader)
        return cv
    }()
    
    var nonResultBtn: UIButton = {
        var b = UIButton()
        b.setTitleColor(.darkGray, for: .normal)
        b.setTitle("자주타는 지하철 경호를\n 등록해보세요!", for: .normal)
        b.titleLabel?.numberOfLines = 2
        b.titleLabel?.textAlignment = .center
        b.addTarget(self, action: #selector(goSearch), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
//        Alamofire.request(ETCMethod.makeStationURL(stations: "송내", appKey: API.openAppKey), method: .get)
//            .validate()
//            .responseData { (response) in
//                switch response.result {
//                case .success(let value) :
//                    do {
//                        let decodableValue = try JSONDecoder().decode(SubwayModel.self, from: value)
//                        print("성공 = \(decodableValue.searchInfoBySubwayNameService.row[0].lineNum)")
////                        completion(Result.success(decodableValue))
//                    } catch {
//
//                    }
//                case .failure(let error):
//                    print("error = \(error)")
////                    completion(.failure(nil, error))
//                }
//        }
        
    }
    
    override func setupUI() {
        [collectionView].forEach { self.view.addSubview($0) }
        [nonResultBtn].forEach { self.collectionView.addSubview($0) }
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(44)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        nonResultBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(200)
        }
    }
    
    @objc func goSearch() {
        self.navigationController?.pushViewController(self.navigator.navigate(at: .search), animated: true)
    }

}
