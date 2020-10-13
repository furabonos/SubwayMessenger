//
//  SearchDetailView.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/09/26.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import SnapKit

enum StationType {
    case start
    case end
}

class SearchDetailView: UIView {
    
    private let viewModel = SearchDetailViewModel()
    
    var backBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "iconBack"), for: .normal)
        b.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        return b
    }()
    
    lazy var stationTextField: UITextField = {
        var tf = UITextField()
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.becomeFirstResponder()
        tf.addTarget(self, action: #selector(valueChange(_:)), for: .editingChanged)
        return tf
    }()
    
    var stationType = StationType.start
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(StationCell.self, forCellWithReuseIdentifier: self.stationCell)
        return cv
    }()
    
    var stationCell = "StationCell"
    
    var grayView: UIView = {
        var v = UIView()
        v.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        return v
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupUI()
        setupConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.endEditing(true)
    }
    
    func setupUI() {
        self.backgroundColor = .white
        [backBtn, stationTextField, grayView,collectionView].forEach { self.addSubview($0) }
        ODsayService.sharedInst()?.requestSearchStation("구래", cid: 1000, stationClass: "2", displayCnt: 5, startNo: 0, myLocation: "", responseBlock: { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
            guard let results = resultDic else { return }
            var ss = results["result"] as! [String: Any]
            var ss2 = ss["station"] as! Array<[String: Any]>
            print(ss2)
            var sss = ss2[0]["stationID"] as! Int
            print(sss)
        })
    }
    
    func setupConstraints() {
        backBtn.snp.makeConstraints { 
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(30)
        }
        
        stationTextField.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.top)
            $0.bottom.equalTo(backBtn.snp.bottom)
            $0.leading.equalTo(backBtn.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        grayView.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(grayView.snp.bottom).offset(20)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
    func bind() {
        print("Z")
    }
    
    @objc func clickBack() {
        self.removeFromSuperview()
    }
    
    @objc func valueChange(_ textField: UITextField) {
        self.viewModel.stationLists.removeAll()
        if textField.text != "" && textField.text != nil {
            guard let stations = textField.text else { return }
//            self.viewModel.findStations(stations: stations) { (result) in
//                switch result {
//                case "success":
//                    self.reloadCollectionView()
//                case "failure":
//                    print("실패")
//                default:
//                    print("Z")
//                }
//            }
            self.viewModel.stationFind(stations: stations) { (result) in
                switch result {
                case "success":
                    self.reloadCollectionView()
                    print("씨이팔 = \(self.viewModel.stationLists)")
                case "failure":
                    print("실패")
                default:
                    print("Z")
                }
            }
        }
        
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.reloadData()
        }
    }

}

extension SearchDetailView: UICollectionViewDelegate {}
extension SearchDetailView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.stationLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.stationCell, for: indexPath) as! StationCell
        cell.viewModel = StationCellViewModel(content: self.viewModel.stationLists[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.stationType == .start {
            NotificationCenter.default.post(name: Notification.Name("startStation"), object: self.viewModel.stationLists[indexPath.row])
            self.removeFromSuperview()
        }else {
            NotificationCenter.default.post(name: Notification.Name("finStation"), object: self.viewModel.stationLists[indexPath.row])
            self.removeFromSuperview()
        }
        
    }
    
    
    
}
extension SearchDetailView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: 70)
    }
}
