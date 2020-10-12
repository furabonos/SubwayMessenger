//
//  SearchViewController.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/09/25.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    private let viewModel = SearchViewModel()
    
    var startCode = String()
    var endCode = String()
    
    var shortTimeCell = "ShortTimeCell"
    
    var searchView: UIView = {
        var v = UIView()
        v.backgroundColor = .white
        v.addLine(position: .bottom, color: UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), width: 10)
        return v
    }()
    
    var startTextField: UIButton = {
        var b = UIButton()
        b.setTitle("출발역 입력", for: .normal)
        b.setTitleColor(.gray, for: .normal)
        b.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        b.layer.cornerRadius = 5
        b.contentHorizontalAlignment = .left
        b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        b.tag = 0
        b.addTarget(self, action: #selector(makeDetail(_:)), for: .touchUpInside)
        return b
    }()
    
    var endTextField: UIButton = {
        var b = UIButton()
        b.setTitle("도착역 입력", for: .normal)
        b.setTitleColor(.gray, for: .normal)
        b.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        b.layer.cornerRadius = 5
        b.contentHorizontalAlignment = .left
        b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        b.tag = 1
        b.addTarget(self, action: #selector(makeDetail(_:)), for: .touchUpInside)
        return b
    }()
    
    var exchangeBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "exchange"), for: .normal)
        return b
    }()
    
    var backBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "cancel"), for: .normal)
        b.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        return b
    }()
    
    var searchBtn: UIButton = {
        var b = UIButton()
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.setTitle("검색", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.addTarget(self, action: #selector(search), for: .touchUpInside)
        return b
    }()
    
    lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
            cv.backgroundColor = .red
    //        cv.delegate = self
    //        cv.dataSource = self
            cv.register(ShortTimeCell.self, forCellWithReuseIdentifier: self.shortTimeCell)
    //        cv.register(GADCell.self, forCellWithReuseIdentifier: self.gadCell)
            return cv
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        NotificationCenter.default.addObserver(self, selector: #selector(startStation(notification:)), name: Notification.Name("startStation"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(finStation(notification:)), name: Notification.Name("finStation"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func startStation(notification: Notification) {
        guard let subwayDatas = notification.object as? SubwayInfoModel else { return }
        startTextField.setTitle(subwayDatas.stationNM, for: .normal)
        startTextField.setTitleColor(.black, for: .normal)
        self.startCode = subwayDatas.frCode
    }
    
    @objc func finStation(notification: Notification) {
        guard let subwayDatas = notification.object as? SubwayInfoModel else { return }
        endTextField.setTitle(subwayDatas.stationNM, for: .normal)
        endTextField.setTitleColor(.black, for: .normal)
        self.endCode = subwayDatas.frCode
    }
    
    override func setupUI() {
        [searchView, collectionView].forEach { self.view.addSubview($0) }
        [startTextField, endTextField, exchangeBtn, backBtn, searchBtn].forEach { searchView.addSubview($0) }
    }
    
    override func setupConstraints() {
        searchView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }

        startTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(35)
        }
        
        endTextField.snp.makeConstraints {
            $0.top.equalTo(startTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(35)
        }
        
        exchangeBtn.snp.makeConstraints {
            $0.top.equalTo(startTextField.snp.bottom).offset(-8)
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(17)
        }
        
        backBtn.snp.makeConstraints {
            $0.centerY.equalTo(startTextField.snp.centerY)
            $0.width.height.equalTo(17)
            $0.leading.equalTo(startTextField.snp.trailing).offset(10)
        }
        
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(endTextField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(35)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
    @objc func makeDetail(_ sender: UIButton) {
        var searchDetailVC = SearchDetailView()
        if sender.tag == 0 {
            searchDetailVC.stationType = .start
            self.view.addSubview(searchDetailVC)
            searchDetailVC.snp.makeConstraints {
                $0.top.leading.bottom.trailing.equalToSuperview()
            }
        }else if sender.tag == 1 {
            searchDetailVC.stationType = .end
            self.view.addSubview(searchDetailVC)
            searchDetailVC.snp.makeConstraints {
                $0.top.leading.bottom.trailing.equalToSuperview()
            }
        }
    }
    
    @objc func clickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func search() {
        print("ss = \(self.startCode), \(self.endCode)")
    }

}

