//
//  MessengerController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/05.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import DropDown

class MessengerController: BaseViewController {
    
    private let viewModel = MessengerViewModel()
    var dropDown: DropDown?
    
    var trainLine = ""
    
    var complaintsBtn: UIButton = {
        var b = UIButton()
        b.backgroundColor = .red
        b.addTarget(self, action: #selector(sss), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(red: 255/255, green: 232/255, blue: 0/255, alpha: 1)
        self.view.backgroundColor = .systemBlue
//        self.settingDropDown()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func setupUI() {
        [complaintsBtn].forEach { self.view.addSubview($0) }
    }
    
    override func setupConstraints() {
        complaintsBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
    }
    
    func settingDropDown() {
//        self.dropDown = DropDown()
//        dropDown?.anchorView = lineBtn
//        dropDown?.bottomOffset = CGPoint(x: 0, y:(dropDown?.anchorView?.plainView.bounds.height)!)
//        dropDown?.dataSource = self.viewModel.stationLineUp
//        dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
//            self.viewModel.trainTel = ETCMethod.selectLineNum(line: index)
//            print("tele = \(self.viewModel.trainTel), \(item)")
//        }
    }
    
    @objc func clickTrain() {
        dropDown?.show()
    }
    
    @objc func sss() {
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
    
    func splitStation() {
        let alert = UIAlertController(title: "", message: "타고계신 지하철의 다음 정거장을 선택하세요.", preferredStyle: .alert)
        DispatchQueue.main.async {
            for i in 0..<self.viewModel.stationArr.count {
                let okAction = UIAlertAction(title: self.viewModel.stationArr[i].name, style: .default) { (action) in
                    guard let titles = action.title else { return }
                    self.trainLine = ETCMethod.makeStationInfo(str: titles)[1]
                    self.selectStation(station: ETCMethod.makeStationInfo(str: titles)[0])
                }
                alert.addAction(okAction)
            }
            self.present(alert, animated: true, completion: nil)
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
