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
    
    var lineBtn: UIButton = {
        var b = UIButton()
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .clear
        b.addTarget(self, action: #selector(clickTrain), for: .touchUpInside)
        b.setImage(UIImage(named: "trainsss"), for: .normal)
        return b
    }()
    
    var searchBtn: UIButton = {
        var b = UIButton()
        b.setTitleColor(.systemBlue, for: .normal)
        b.backgroundColor = .clear
        b.setImage(UIImage(named: "aims"), for: .normal)
        b.addTarget(self, action: #selector(sss), for: .touchUpInside)
        return b
    }()
    
    var textField: UITextView = {
        var tf = UITextView()
//        tf.backgroundColor = UIColor(red: 252/255, green: 225/255, blue: 134/255, alpha: 1)
        tf.backgroundColor = .black
        tf.textColor = .white
        return tf
    }()
    
    var sendBtn: UIButton = {
        var b = UIButton()
        b.setTitleColor(.systemBlue, for: .normal)
        b.backgroundColor = .clear
        b.setImage(UIImage(named: "mail"), for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(red: 255/255, green: 232/255, blue: 0/255, alpha: 1)
        self.view.backgroundColor = .systemBlue
        self.settingDropDown()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func setupUI() {
        [lineBtn, searchBtn, textField, sendBtn].forEach { self.view.addSubview($0) }
        
    }
    
    override func setupConstraints() {
        lineBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(100)
            $0.leading.equalToSuperview().offset(60)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
        
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(lineBtn.snp.top)
            $0.trailing.equalToSuperview().offset(-60)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(lineBtn.snp.bottom).offset(80)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(200)
        }
        
        sendBtn.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
    }
    
    func settingDropDown() {
        self.dropDown = DropDown()
        dropDown?.anchorView = lineBtn
        dropDown?.bottomOffset = CGPoint(x: 0, y:(dropDown?.anchorView?.plainView.bounds.height)!)
        dropDown?.dataSource = self.viewModel.stationLineUp
        dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            self.viewModel.trainTel = ETCMethod.selectLineNum(line: index)
            print("tele = \(self.viewModel.trainTel), \(item)")
        }
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
                    print("Z")
                }
                alert.addAction(okAction)
            }
            self.present(alert, animated: true, completion: nil)
        }
    }

}
