//
//  ComplaintsViewController.swift
//  SubwayMessenger
//
//  Created by 엄태형 on 2020/08/16.
//  Copyright © 2020 Taehyeong. All rights reserved.
//

import UIKit
import DropDown
import MessageUI

class ComplaintsViewController: BaseViewController, MFMessageComposeViewControllerDelegate {
    
    var lineNumber: String
    var trainNumber: String
    
    var backBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "iconBack"), for: .normal)
        b.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        return b
    }()
    
    var infoView: UIView = {
        var v = UIView()
        v.addShadow()
        return v
    }()
    
    lazy var infoLabel: UILabel = {
        var l = UILabel()
        l.backgroundColor = .white
        l.textColor = Colors.coolGrey
        l.text = "\(self.lineNumber) - \(self.trainNumber)호 - 1번째 칸"
        l.textAlignment = .center
        return l
    }()
    
    var trainView: UIView = {
        var v = UIView()
        v.addShadow()
        return v
    }()
    
    var leftBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "leftArrow"), for: .normal)
        b.tag = 0
        b.addTarget(self, action: #selector(selectContainer(_:)), for: .touchUpInside)
        return b
    }()
    
    var rightBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "rightArrow"), for: .normal)
        b.tag = 1
        b.addTarget(self, action: #selector(selectContainer(_:)), for: .touchUpInside)
        return b
    }()
    
    var trainBtn: UIButton = {
        var b = UIButton()
        b.setBackgroundImage(UIImage(named: "trainPlatform"), for: .normal)
        b.setTitle("1", for: .normal)
        b.setTitleColor(Colors.coolGrey, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 17)
        b.titleEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0)
        return b
    }()
    
    var selectView: UIView = {
        var v = UIView()
        v.addShadow()
        return v
    }()
    
    var selectBtn: UIButton = {
        var b = UIButton()
        b.setTitle("민원의 종류를 선택해주세요", for: .normal)
        b.setTitleColor(Colors.coolGrey, for: .normal)
        b.backgroundColor = .white
        b.addTarget(self, action: #selector(selectCom), for: .touchUpInside)
        return b
    }()
    
    let dropDown = DropDown()
    
    var complaintsView: UIView = {
        var v = UIView()
        v.addShadow()
        return v
    }()
    
    lazy var complaintsField: UITextView = {
        var tv = UITextView()
        tv.delegate = self
        tv.backgroundColor = .white
        tv.textColor = .black
        return tv
    }()
    
    var sendBtn: UIButton = {
        var v = UIButton()
        v.addShadow()
        v.setTitle("전송", for: .normal)
        v.setTitleColor(Colors.coolGrey, for: .normal)
        v.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return v
    }()
    
    var qmBtn: UIButton = {
        var b = UIButton()
        b.setImage(UIImage(named: "questionmark"), for: .normal)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        dropDown.anchorView = selectBtn
        dropDown.dataSource = ["온도관련", "마스크 미착용", "소란, 난동", "이동상인", "응급환자", "테러"]
        dropDown.width = self.view.bounds.width - 80
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectBtn.setTitle(item, for: .normal)
        }
        textViewSetupView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func setupUI() {
        [backBtn, infoView, trainView, selectView, complaintsView, sendBtn, qmBtn].forEach { self.view.addSubview($0) }
        [infoLabel].forEach { infoView.addSubview($0) }
        [leftBtn, rightBtn, trainBtn].forEach { trainView.addSubview($0) }
        [selectBtn].forEach { selectView.addSubview($0) }
        [complaintsField].forEach { complaintsView.addSubview($0) }
    }
    
    override func setupConstraints() {
        backBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(30)
        }
        
        infoView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backBtn.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(100)
        }
        
        infoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        trainView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(100)
        }
        
        leftBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(20)
        }
        
        rightBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(20)
        }
        
        trainBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(80)
        }
        
        selectView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(trainView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(100)
        }
        
        selectBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        complaintsView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(selectView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(200)
        }
        
        complaintsField.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.trailing.bottom.equalToSuperview().offset(-10)
        }
        
        sendBtn.snp.makeConstraints {
            $0.top.equalTo(complaintsView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        qmBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(14)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(30)
        }
        
        
    }
    
    @objc func clickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectContainer(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            var titles = Int(trainBtn.title(for: .normal)!)!
            if titles != 1 {
                titles -= 1
                trainBtn.setTitle("\(titles)", for: .normal)
                self.infoLabel.text = "\(self.lineNumber) - \(self.trainNumber)호 - \(titles)번째 칸"
            }
        case 1:
            var titles = Int(trainBtn.title(for: .normal)!)!
            if titles <= 9 {
                titles += 1
                trainBtn.setTitle("\(titles)", for: .normal)
                self.infoLabel.text = "\(self.lineNumber) - \(self.trainNumber)호 - \(titles)번째 칸"
            }
        default:
            print("none")
        }
    }
    
    @objc func selectCom() {
        dropDown.show()
    }
    
    func textViewSetupView() {
        complaintsField.text = "자세한 민원사항을 입력해주세요."
        complaintsField.textColor = .lightGray
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        self.view.frame.origin.y = -150
    }
        
    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func sendMessage() {
        guard let infoText = self.infoLabel.text else { return }
        guard let complaintsType = self.selectBtn.title(for: .normal) else { return }
        guard let complaintsText = self.complaintsField.text else { return }
        guard let numbers = UserDefaults.standard.string(forKey: "number") else { return }
        var tel = String()
        if numbers == "seoul" {
            tel = Train.shared.seoulMetro
        }else if numbers == "korail" {
            tel = Train.shared.korail
        }else if numbers == "metro" {
            tel = Train.shared.metro
        }
        
        if complaintsType == "민원의 종류를 선택해주세요" {
            let alertss = UIAlertController(title: "안내", message: "민원의 종류를 선택해주세요.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "확인", style: .default, handler : nil)
            alertss.addAction(defaultAction)
            DispatchQueue.main.async {
                self.present(alertss, animated: true)
            }
        }else {
            let messageComposer = MFMessageComposeViewController()
            messageComposer.messageComposeDelegate = self
            if MFMessageComposeViewController.canSendText() {
                messageComposer.recipients = [tel]
                if complaintsText == "자세한 민원사항을 입력해주세요." {
                    messageComposer.body = "[\(self.infoLabel.text!) - \(selectBtn.title(for: .normal)!)]"
                    self.present(messageComposer, animated: true, completion: nil)
                }else {
                    messageComposer.body = "[\(self.infoLabel.text!) - \(selectBtn.title(for: .normal)!)]\n\(complaintsText)"
                    self.present(messageComposer, animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .sent:
            break
        case .cancelled:
            break
        case .failed:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }

}

extension ComplaintsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.complaintsField.textColor == UIColor.lightGray {
            self.complaintsField.text = nil
            self.complaintsField.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.complaintsField.text.isEmpty {
            self.complaintsField.text = "자세한 민원사항을 입력해주세요."
            self.complaintsField.textColor = UIColor.lightGray
        }
    }
}
