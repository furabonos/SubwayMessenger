//
//  SearchViewController.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/09/25.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    private let searchDetailVC = SearchDetailView()
    
    var searchView: UIView = {
        var v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    lazy var startTextField: UITextField = {
        var tf = UITextField()
        tf.leftViewMode = .always
        tf.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        tf.textColor = .black
        tf.attributedPlaceholder = NSAttributedString(string: "출발역 입력",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.layer.cornerRadius = 5
        tf.addLeftPadding()
        return tf
    }()
    
    lazy var endTextField: UITextField = {
        var tf = UITextField()
        tf.leftViewMode = .always
        tf.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        tf.textColor = .black
        tf.attributedPlaceholder = NSAttributedString(string: "도착역 입력",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.layer.cornerRadius = 5
        tf.addLeftPadding()
        return tf
    }()
    
    var exchangeBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "exchange"), for: .normal)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        [searchView].forEach { self.view.addSubview($0) }
        [startTextField, endTextField, exchangeBtn].forEach { searchView.addSubview($0) }
    }
    
    override func setupConstraints() {
        searchView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
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
    }

}

