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
        l.layer.masksToBounds = true
        l.backgroundColor = .red
        l.textColor = .white
        l.textAlignment = .center
        l.font = .boldSystemFont(ofSize: 12)
        return l
    }()
    
    var stationLabel: UILabel = {
        var l = UILabel()
        l.textColor = .black
        l.backgroundColor = .white
        l.textAlignment = .left
        l.font = .boldSystemFont(ofSize: 16)
        return l
    }()
    
    var lineView: UIView = {
        var v = UIView()
        v.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        return v
    }()
    
    var viewModel: StationCellViewModel! {
        didSet {
            self.lineLabel.backgroundColor = ETCMethod.makeSubwayColor(lines: viewModel.lineNum)
            self.makeLineLabelConstraints(line: ETCMethod.makeSubwayLine(lines: viewModel.lineNum))
            self.makeLineLabelText(line: viewModel.lineNum)
            stationLabel.text = viewModel.stationNM
        }
    }
    
    override func setupUI() {
        self.backgroundColor = .white
        [lineLabel, stationLabel, lineView].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
        lineLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(30)
        }
        
        stationLabel.snp.remakeConstraints {
            $0.top.equalTo(lineLabel.snp.top)
            $0.bottom.equalTo(lineLabel.snp.bottom)
            $0.leading.equalTo(lineLabel.snp.trailing).offset(20)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func makeLineLabelConstraints(line: String) {
        switch line {
        case "수도권 1호선", "수도권 2호선", "수도권 3호선", "수도권 4호선", "수도권 5호선", "수도권 6호선", "수도권 7호선", "수도권 8호선", "수도권 9호선":
            self.lineLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(20)
                $0.width.height.equalTo(30)
            }
            self.lineLabel.layer.cornerRadius = 15
        default:
            self.lineLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(20)
                $0.width.equalTo(60)
                $0.height.equalTo(30)
            }
            self.lineLabel.layer.cornerRadius = 15
        }
    }
    
    func makeLineLabelText(line: String) {
        switch line {
        case "수도권 1호선", "수도권 2호선", "수도권 3호선", "수도권 4호선", "수도권 5호선", "수도권 6호선", "수도권 7호선", "수도권 8호선", "수도권 9호선":
            var lines = line.components(separatedBy: " ")
            var lineText = lines[1].components(separatedBy: "호선")
            self.lineLabel.text = lineText[0]
        case "수인.분당선":
            self.lineLabel.text = "수인분당"
        case "인천 1호선":
            self.lineLabel.text = "인천1"
        case "수도권 공항철도":
            self.lineLabel.text = "공항"
        case "인천 2호선":
            self.lineLabel.text = "인천2"
        case "경의중앙선":
            self.lineLabel.text = "경의중앙"
        case "수도권 에버라인":
            self.lineLabel.text = "에버라인"
        case "수도권 경춘선":
            self.lineLabel.text = "경춘"
        case "수도권 신분당선":
            self.lineLabel.text = "신분당"
        case "수도권 의정부경전철":
            self.lineLabel.text = "의정부"
        case "수도권 경강선":
            self.lineLabel.text = "경강"
        case "우이신설경전철":
            self.lineLabel.text = "우이신설"
        case "수도권 서해선(소사-원시)":
            self.lineLabel.text = "서해"
        case "김포골드라인":
            self.lineLabel.text = "김포골드"
        default:
            self.lineLabel.text = ""
        }
    }
    
}
