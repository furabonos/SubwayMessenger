//
//  ComplaintsViewController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/16.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit

class ComplaintsViewController: BaseViewController {
    
    var lineNumber: String
    var trainNumber: String
    
    var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var backBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "backIcon"), for: .normal)
        b.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        b.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return b
    }()
    
    init(line: String, train: String) {
        self.lineNumber = line
        self.trainNumber = train
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.view.backgroundColor = .orange
        print("zzzzzzz = \(self.lineNumber), \(trainNumber)")
        super.viewDidLoad()
    }
    
    override func setupUI() {
        print("Z")
        self.setNavigationBar()
    }
    
    override func setupConstraints() {
        print("v")
    }
    
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationBar() {
        let barvv = UIBarButtonItem(customView: backBtn)
        let navItem = UINavigationItem(title: "")
        navItem.leftBarButtonItem = barvv
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        navBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
    }

}
