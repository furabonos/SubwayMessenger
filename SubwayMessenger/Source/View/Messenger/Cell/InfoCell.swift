//
//  InfoCell.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/19.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

protocol InfoCellProtocol {
    func clickTrain(_ tag: Int)
}

class InfoCell: BaseCollectionViewCell {
    
    var delegate: InfoCellProtocol?
    
    var btnView: UIView = {
        var v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    var stackView: UIStackView = {
        var sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.spacing = 0
        return sv
    }()
    
    var currentLabel: UILabel = {
        var l = UILabel()
        l.text = "현재 내 위치"
        l.textColor = .black
        l.backgroundColor = .white
        l.font = .boldSystemFont(ofSize: 13)
        return l
    }()
    
    var locationLabel: UILabel = {
        var l = UILabel()
        l.textColor = .black
        l.backgroundColor = .lightGray
        l.textAlignment = .center
//        l.font = .boldSystemFont(ofSize: 13)
        return l
    }()
    
    override func setupUI() {
        self.backgroundColor = .white
        [btnView, currentLabel, locationLabel].forEach { self.addSubview($0) }
        [stackView].forEach { btnView.addSubview($0)}
    }
    
    override func setupConstraints() {
        btnView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.contentView.snp.height).dividedBy(2)
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2)
        }
        makeBtn()
        
        currentLabel.snp.makeConstraints {
            $0.top.equalTo(btnView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(5)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(currentLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    
    func makeBtn() {
        var imgArr = ["trains1", "trains2", "trains3", "trains4", "trains5", "trains6", "trains7", "trains8", "trains9", "trains10"]
        for i in 0..<imgArr.count {
            var btn: UIButton = {
                var b = UIButton()
                b.setBackgroundImage(UIImage(named: "\(imgArr[i])"), for: .normal)
                b.setTitle("\(i+1)", for: .normal)
                b.setTitleColor(.white, for: .normal)
                b.titleLabel?.font = .boldSystemFont(ofSize: 12)
                b.tag = i
                b.addTarget(self, action: #selector(selectTrain(_:)), for: .touchUpInside)
                return b
            }()
            stackView.addArrangedSubview(btn)
        }
    }
    
    @objc func selectTrain(_ sender: UIButton) {
        delegate?.clickTrain(sender.tag)
    }
    
}
