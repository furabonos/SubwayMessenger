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
    
    var backBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "iconBack"), for: .normal)
        b.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        return b
    }()
    
    var infoView: UIView = {
        var v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 1, height: 1)
        v.layer.shadowOpacity = 0.8
        v.layer.shadowRadius = 4.0
        v.layer.masksToBounds = false
        return v
    }()
    
    lazy var infoLabel: UILabel = {
        var l = UILabel()
        l.backgroundColor = .white
        l.textColor = .black
        l.text = "\(self.lineNumber) - \(self.trainNumber)호"
        l.textAlignment = .center
        return l
    }()
    
    var trainView: UIView = {
        var v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 1, height: 1)
        v.layer.shadowOpacity = 0.8
        v.layer.shadowRadius = 4.0
        v.layer.masksToBounds = false
        return v
    }()
    
    var leftBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "leftArrow"), for: .normal)
        return b
    }()
    
    var rightBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "rightArrow"), for: .normal)
        return b
    }()
    
    var testBtn: UIButton = {
        var b = UIButton()
//        b.setImage(UIImage(named: "trains1"), for: .normal)
        b.setBackgroundImage(UIImage(named: "trains1"), for: .normal)
        b.setTitle("1", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 12)
        return b
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
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func setupUI() {
        [backBtn, infoView, trainView].forEach { self.view.addSubview($0) }
        [infoLabel].forEach { infoView.addSubview($0) }
        [leftBtn, rightBtn, testBtn].forEach { trainView.addSubview($0) }
    }
    
    override func setupConstraints() {
        backBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(30)
        }
        
        infoView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backBtn.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(100)
        }
        
        infoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        trainView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(100)
        }
        
        leftBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(20)
        }
        
        rightBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(20)
        }
        
        testBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        
    }
    
    @objc func clickBack() {
        self.navigationController?.popViewController(animated: true)
    }

}
