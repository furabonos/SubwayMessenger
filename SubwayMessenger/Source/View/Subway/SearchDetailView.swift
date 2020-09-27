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
        return tf
    }()
    
    var stationType = StationType.start
    
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
        [backBtn, stationTextField].forEach { self.addSubview($0) }
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
        stationTextField.becomeFirstResponder()
        
    }
    
    func bind() {
        print("Z")
    }
    
    @objc func clickBack() {
        self.removeFromSuperview()
    }

}
