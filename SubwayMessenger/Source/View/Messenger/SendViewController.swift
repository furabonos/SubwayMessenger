//
//  SendViewController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/09/14.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import CoreLocation

class SendViewController: BaseViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    private let viewModel = SendViewModel()
    
    var trainLine = ""
    
    var trainBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "orangetrain2"), for: .normal)
        b.addTarget(self, action: #selector(findStation), for: .touchUpInside)
        return b
    }()
    
    var bubbleView: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "comment")
        return iv
    }()
    
    var clickMent: UIButton = {
        var iv = UIButton()
//        iv.image = UIImage(named: "click2")
        iv.setImage(UIImage(named: "click2"), for: .normal)
        iv.addTarget(self, action: #selector(findStation), for: .touchUpInside)
        return iv
    }()
    
    var qmBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "questionmark"), for: .normal)
        return b
    }()
    
    var indicator: UIActivityIndicatorView = {
        var id = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            id.style = .large
        } else {
            // Fallback on earlier versions
        }
        id.color = .red
        id.backgroundColor = .clear
        id.startAnimating()
        return id
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    override func setupUI() {
        [trainBtn, bubbleView, clickMent, qmBtn, indicator].forEach { self.view.addSubview($0) }
        self.indicator.isHidden = true
    }
    
    override func setupConstraints() {
        
        trainBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-30)
            $0.width.height.equalTo(150)
        }
        
        bubbleView.snp.makeConstraints {
            $0.bottom.equalTo(trainBtn.snp.top).offset(20)
            $0.leading.equalTo(trainBtn.snp.trailing).offset(-10)
            $0.width.height.equalTo(100)
        }
        
        clickMent.snp.makeConstraints {
//            $0.center.equalTo(bubbleView.snp.center)
            $0.centerY.equalTo(bubbleView.snp.centerY).offset(5)
            $0.centerX.equalTo(bubbleView.snp.centerX).offset(5)
            $0.width.equalTo(60)
            $0.height.equalTo(40)
        }
        
        qmBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(30)
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
    }
    
    @objc func findStation() {
        self.indicator.isHidden = false
        let coor = locationManager.location?.coordinate
        guard let lat = coor?.latitude else { return }
        guard let lon = coor?.longitude else { return }
        self.viewModel.findStation(lats: "\(lat)", lons: "\(lon)") { (result) in
            switch result {
            case "success":
                self.splitStation()
            case "failure":
                print("실패")
            default:
                print("Z")
            }
        }
    }
    
    func splitStation() {
        self.indicator.isHidden = true
        let alert = UIAlertController(title: "", message: "타고계신 지하철의 다음 정거장을 선택하세요.", preferredStyle: .alert)
        DispatchQueue.main.async {
            for i in 0..<self.viewModel.stationArr.count {
                let okAction = UIAlertAction(title: self.viewModel.stationArr[i].name, style: .default) { (action) in
                    guard let titles = action.title else { return }
                    ETCMethod.selectLineTel(info: ETCMethod.makeStationInfo(str: titles))
                    self.trainLine = ETCMethod.makeStationInfo(str: titles)[1]
                    self.selectStation(station: ETCMethod.makeStationInfo(str: titles)[0])
                }
                alert.addAction(okAction)
            }
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func selectStation(station: String) {
        self.viewModel.findSchedule(stations: station) { (result) in
            switch result {
            case "success":
                print("ss = \(self.viewModel.schedulrArr)")
                self.splitSchedule()
            case "failure":
                print("v")
            default:
                print("b")
            }
        }
    }
    
    func splitSchedule() {
        var beforeSplit = Array<String>()
        for i in 0..<self.viewModel.schedulrArr.count {
            beforeSplit.append(self.viewModel.schedulrArr[i].trainLineNm)
        }
        var afterSplit = Array(Set(beforeSplit))
        let alert = UIAlertController(title: "", message: "타고계신 지하철을 선택하세요", preferredStyle: .alert)
        DispatchQueue.main.async {
            for i in 0..<afterSplit.count {
                let okAction = UIAlertAction(title:"<\(afterSplit[i])>", style: .default) { (action) in
                    self.navigationController?.pushViewController(self.navigator.navigate(at: .complaints(lineN: self.trainLine, trainN: self.viewModel.schedulrArr[i].btrainNo)), animated: true)
                }
                alert.addAction(okAction)
            }
            self.present(alert, animated: true, completion: nil)
        }
    }

}
