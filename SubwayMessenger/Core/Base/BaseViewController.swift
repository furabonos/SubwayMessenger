//
//  BaseViewController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/05.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bind()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {}
    func setupConstraints() {}
    func bind() {}

}
