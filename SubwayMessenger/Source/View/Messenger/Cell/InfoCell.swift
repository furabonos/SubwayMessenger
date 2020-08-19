//
//  InfoCell.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/19.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class InfoCell: BaseCollectionViewCell {
    
    var btnView: UIView = {
        var v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    override func setupUI() {
        self.backgroundColor = .white
        [btnView].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
        btnView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.contentView.snp.height).dividedBy(2)
        }
    }
    
}
