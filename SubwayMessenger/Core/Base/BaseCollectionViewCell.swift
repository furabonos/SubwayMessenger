//
//  BaseCollectionViewCell.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/19.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupUI()
      setupConstraints()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      setupUI()
      setupConstraints()
    }
    
    
    //MARK:- Methods
    
    func setupUI() { }
    func setupConstraints() { }
}
