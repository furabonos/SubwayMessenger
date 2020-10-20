//
//  ShortTimeCell.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/10/12.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class ShortTimeCell: BaseCollectionViewCell {
    
    var titleLabel: UILabel = {
        var l = UILabel()
        l.text = "최단경로"
        l.textColor = .black
        l.font = .boldSystemFont(ofSize: 14)
        return l
    }()
    
    override func setupUI() {
        [titleLabel].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
    }
    
}
