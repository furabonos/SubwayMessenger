//
//  MessengerController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/05.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import DropDown

class MessengerController: BaseViewController {
    
    private let viewModel = MessengerViewModel()
    var dropDown: DropDown?
    
    var lineBtn: UIButton = {
        var b = UIButton()
//        b.setTitle("몇호선", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .clear
        b.addTarget(self, action: #selector(sdsd), for: .touchUpInside)
        b.setImage(UIImage(named: "trainsss"), for: .normal)
        return b
    }()
    
    var searchBtn: UIButton = {
        var b = UIButton()
        b.setTitleColor(.systemBlue, for: .normal)
        b.backgroundColor = .clear
        b.setImage(UIImage(named: "aims"), for: .normal)
        return b
    }()
    
    var textField: UILabel = {
        var l = UILabel()
        l.backgroundColor = .white
        return l
    }()
    
    var sendBtn: UIButton = {
        var b = UIButton()
//        b.setTitle("전송", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        b.backgroundColor = .clear
        b.setImage(UIImage(named: "mail"), for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 232/255, blue: 0/255, alpha: 1)
        self.dropDown = DropDown()
        dropDown?.anchorView = lineBtn
        dropDown?.bottomOffset = CGPoint(x: 0, y:(dropDown?.anchorView?.plainView.bounds.height)!)
        dropDown?.dataSource = ["1호선", "2호선", "3호선", "4호선"]
//        dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
//          print("Selected item: \(item) at index: \(index)")
//        }
    }
    
    override func setupUI() {
        print("Z")
        [lineBtn, searchBtn, textField, sendBtn].forEach { self.view.addSubview($0) }
        
    }
    
    override func setupConstraints() {
        print("v")
        lineBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(100)
            $0.leading.equalToSuperview().offset(60)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
        
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(lineBtn.snp.top)
            $0.trailing.equalToSuperview().offset(-60)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(lineBtn.snp.bottom).offset(80)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(200)
        }
        
        sendBtn.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
    }
    
    @objc func sdsd() {
        dropDown?.show()
    }

}
