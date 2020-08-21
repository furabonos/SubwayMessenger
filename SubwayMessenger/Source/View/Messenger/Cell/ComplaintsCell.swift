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
        let attributedString = NSMutableAttributedString(string: "")
        return l
    }()
    
    override func setupUI() {
        self.backgroundColor = .white
        [warningLabel].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
        warningLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(100)
        }
    }
    
}
