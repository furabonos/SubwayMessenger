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
    
    var btns: UIButton = {
        var b = UIButton()
        b.backgroundColor = .systemOrange
        b.addTarget(self, action: #selector(bbb), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 232/255, blue: 0/255, alpha: 1)
        self.dropDown = DropDown()
        dropDown?.anchorView = btns
        dropDown?.bottomOffset = CGPoint(x: 0, y:(dropDown?.anchorView?.plainView.bounds.height)!)
        dropDown?.dataSource = ["car", "ss", "cc"]
        dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
        }
    }
    
    override func setupUI() {
        print("Z")
        self.view.addSubview(btns)
    }
    
    override func setupConstraints() {
        print("v")
        btns.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
    }
    
    @objc func bbb() {
        dropDown?.show()
    }

}
