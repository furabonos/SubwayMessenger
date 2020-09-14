//
//  MemoViewController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/22.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import MessageUI

class MemoViewController: BaseViewController {
    
    var lineNumber: String
    var trainNumber: String
    var telNumner = ""
    
    var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var backBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "backIcon"), for: .normal)
//        b.imageView?.contentMode = .scaleAspectFit
        b.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        b.backgroundColor = .white
        b.frame = CGRect(x: 0, y: 0, width: 20, height: 10)
        return b
    }()
    
    var stackView: UIStackView = {
        var sv = UIStackView()
        sv.backgroundColor = .white
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.spacing = 0
        return sv
    }()
    
    var markerView: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "marker")
        return iv
    }()
    
    var locationView: UIView = {
        var v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    var currentLabel: UILabel = {
        var l = UILabel()
        l.text = "현재 내 위치"
        l.textColor = .black
        l.backgroundColor = .white
        l.textAlignment = .center
        l.font = .boldSystemFont(ofSize: 13)
        return l
    }()
    
    lazy var locationLabel: UILabel = {
        var l = UILabel()
        l.textColor = .black
        l.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        l.textAlignment = .center
        l.text = "\(self.lineNumber) - \(self.trainNumber)호"
//        l.font = .boldSystemFont(ofSize: 13)
        return l
    }()
    
    var warningLabel: UILabel = {
        var l = UILabel()
        l.layer.borderColor = UIColor.red.cgColor
        l.layer.borderWidth = 2
        l.backgroundColor = .white
        l.textAlignment = .center
        l.textColor = .black
        l.text = " 허위, 장난으로 신고할 경우 불이익 또는 처벌을 받을 수 있습니다. "
        l.numberOfLines = 1
        l.adjustsFontSizeToFitWidth = true
        let attributedStr = NSMutableAttributedString(string: l.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (l.text! as NSString).range(of: "허위"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (l.text! as NSString).range(of: "장난"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (l.text! as NSString).range(of: "불이익"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (l.text! as NSString).range(of: "처벌"))
        l.attributedText = attributedStr
        return l
    }()
    
    lazy var textView: UITextView = {
        var tv = UITextView()
        tv.delegate = self
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.backgroundColor = .white
        return tv
    }()
    
    var sendBtn: UIButton = {
        var b = UIButton()
        b.backgroundColor = .red
        b.addTarget(self, action: #selector(sendMessege), for: .touchUpInside)
        return b
    }()
    
    var sendBtn2: UIButton = {
        var b = UIButton()
        b.backgroundColor = .red
        b.addTarget(self, action: #selector(sendMessege), for: .touchUpInside)
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
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        self.setNavigationBar()
        [stackView, markerView, locationView, warningLabel, textView, sendBtn, sendBtn2].forEach { self.view.addSubview($0) }
        [currentLabel, locationLabel].forEach { locationView.addSubview($0) }
        self.placeholderSetting()
        if UserDefaults.standard.string(forKey: "number") == "seoul" {
            print("으아! = \(Train.shared.seoulMetro)")
        }else if UserDefaults.standard.string(forKey: "number") == "metro" {
            print(Train.shared.metro)
        }else if UserDefaults.standard.string(forKey: "number") == "korail" {
            print(Train.shared.korail)
        }
    }
    
    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(40)
//            $0.leading.trailing.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
        }
        makeBtn()
        
        locationView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        currentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(5)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(currentLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(locationView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(warningLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(100)
        }
        
        sendBtn.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        sendBtn2.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(65)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func setNavigationBar() {
        navBar.barTintColor = .white
        let barvv = UIBarButtonItem(customView: backBtn)
        let navItem = UINavigationItem(title: "")
        navItem.leftBarButtonItem = barvv
        NSLayoutConstraint.activate([
            (barvv.customView!.widthAnchor.constraint(equalToConstant: 20)),
            (barvv.customView!.heightAnchor.constraint(equalToConstant: 20))
        ])
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        navBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
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
        markerView.snp.remakeConstraints {
            $0.bottom.equalTo(sender.snp.top)
            $0.leading.equalTo(sender.snp.leading).offset(10)
            $0.trailing.equalTo(sender.snp.trailing).offset(-10)
            $0.height.equalTo(20)
        }
        
        locationLabel.text = "\(self.lineNumber) - \(self.trainNumber)호 - \(Int(sender.tag) + 1)번째 칸"
    }
    
    func placeholderSetting() {
        textView.text = "접수하실 민원을 입력해 주세요."
        textView.textColor = UIColor.lightGray
    }
    
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendMessege() {
        guard MFMessageComposeViewController.canSendText() else {
            print("cant send")
            return
        }
        let composeViewController = MFMessageComposeViewController()
        composeViewController.messageComposeDelegate = self
        composeViewController.recipients = [Train.shared.seoulMetro]
        composeViewController.body = textView.text
        
        present(composeViewController, animated: true)
    }

}

extension MemoViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
        // TextView Place Holder
        func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "접수하실 민원을 입력해 주세요."
            textView.textColor = UIColor.lightGray
        }
    }
    
}

extension MemoViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            dismiss(animated: true, completion: nil)
        case .sent:
            dismiss(animated: true, completion: nil)
        case .failed:
            dismiss(animated: true, completion: nil)
        default:
            dismiss(animated: true, completion: nil)
        }
    }
}
