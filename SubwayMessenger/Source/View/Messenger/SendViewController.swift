//
//  SendViewController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/09/14.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class SendViewController: BaseViewController {
    
    var searchBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "magnifier"), for: .normal)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func setupUI() {
        [searchBtn].forEach { self.view.addSubview($0) }
    }
    
    override func setupConstraints() {
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(30)
        }
    }

}
