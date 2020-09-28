//
//  StationCell.swift
//  SubwayMessenger
//
//  Created by Euijae Hong on 2020/09/28.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class StationCell: BaseCollectionViewCell {
    
    var lineLabel: UILabel = {
        var l = UILabel()
        return l
    }()
    
    override func setupUI() {
        self.backgroundColor = .white
        [lineLabel].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
//        lineLabel.snp.makeConstraints { 
//            <#code#>
//        }
    }
    
}
