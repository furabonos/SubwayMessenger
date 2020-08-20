//
//  ComplaintsViewController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/16.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class ComplaintsViewController: BaseViewController {
    
    var lineNumber: String
    var trainNumber: String
    
    var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var infoCell = "InfoCell"
    var complaintsCell = "ComplaintsCell"
    
    var backBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "backIcon"), for: .normal)
        b.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        b.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return b
    }()
    
    var sendBtn: UIButton = {
        var b = UIButton()
        b.backgroundColor = .brown
        b.setTitle("전송", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return b
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        cv.delegate = self
        cv.dataSource = self
        cv.register(InfoCell.self, forCellWithReuseIdentifier: self.infoCell)
        cv.register(ComplaintsCell.self, forCellWithReuseIdentifier: self.complaintsCell)
//        cv.register(GADCell.self, forCellWithReuseIdentifier: self.gadCell)
//        cv.register(MainCell.self, forCellWithReuseIdentifier: self.mainCell)
//        cv.register(MainChannelCell.self, forCellWithReuseIdentifier: self.mainChannelCell)
//        cv.register(MiniGADCell.self, forCellWithReuseIdentifier: self.miniGadCell)
    //        cv.register(MainNoticeCell.self, forCellWithReuseIdentifier: self.mainNoticeCell)
         return cv
    }()
    
    init(line: String, train: String) {
        self.lineNumber = line
        self.trainNumber = train
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
//        self.view.backgroundColor = .white
        print("zzzzzzz = \(self.lineNumber), \(trainNumber)")
        super.viewDidLoad()
    }
    
    override func setupUI() {
        self.setNavigationBar()
        [sendBtn, collectionView].forEach { self.view.addSubview($0) }
    }
    
    override func setupConstraints() {
        sendBtn.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(sendBtn.snp.top)
        }
    }
    
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationBar() {
        navBar.barTintColor = .white
        let barvv = UIBarButtonItem(customView: backBtn)
        let navItem = UINavigationItem(title: "")
        navItem.leftBarButtonItem = barvv
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        navBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
    }

}

extension ComplaintsViewController: UICollectionViewDelegate {}
extension ComplaintsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.infoCell, for: indexPath) as! InfoCell
            cell.delegate = self
            cell.locationLabel.text = "\(self.lineNumber) - \(self.trainNumber)호"
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.complaintsCell, for: indexPath) as! ComplaintsCell
            return cell
        }
    }
}

extension ComplaintsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: self.view.bounds.width, height: 200)
        }else {
            return CGSize(width: self.view.bounds.width, height: self.view.bounds.height - 114 - 200 - 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension ComplaintsViewController: InfoCellProtocol {
    func clickTrain(_ tag: Int) {
        print("fjdfjdskfjsdk = \(tag)")
    }
}
