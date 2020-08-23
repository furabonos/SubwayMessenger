//
//  ComplaintsCell.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/20.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class ComplaintsCell: BaseCollectionViewCell {
    
    var warningLabel: UILabel = {
        var l = UILabel()
        l.layer.borderColor = UIColor.red.cgColor
        l.layer.borderWidth = 2
        l.backgroundColor = .white
        l.textAlignment = .center
        l.textColor = .black
        l.text = " 허위, 장난으로 신고될 경우 불이익 또는 처벌을 받을 수 있습니다. "
        l.numberOfLines = 1
        l.adjustsFontSizeToFitWidth = true
        let attributedStr = NSMutableAttributedString(string: l.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (l.text! as NSString).range(of: "허위"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (l.text! as NSString).range(of: "장난"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (l.text! as NSString).range(of: "불이익"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (l.text! as NSString).range(of: "처벌"))
        l.attributedText = attributedStr
        return l
    }()
    
    var textView: UITextView = {
        var tv = UITextView()
        tv.textColor = .black
        tv.backgroundColor = .green
        return tv
    }()
    
    override func setupUI() {
        self.backgroundColor = .white
        [warningLabel, textView].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
        warningLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(warningLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(100)
        }
    }
    
}
