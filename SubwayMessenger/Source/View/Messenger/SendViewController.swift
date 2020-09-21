//
//  SendViewController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/09/14.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class SendViewController: BaseViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func setupUI() {
        [trainBtn, bubbleView, clickMent].forEach { self.view.addSubview($0) }
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
    }
    
    @objc func findStation() {
        self.viewModel.findStation(lats: "37.50848388671875", lons: "127.03744043284128") { (result) in
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
