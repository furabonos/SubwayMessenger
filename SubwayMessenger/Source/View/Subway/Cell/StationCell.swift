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
        return l
    }()
    
    var viewModel: StationCellViewModel! {
        didSet {
            self.lineLabel.backgroundColor = ETCMethod.makeSubwayColor(lines: ETCMethod.makeSubwayLine(lines: viewModel.lineNum))
            self.makeLineLabelConstraints(line: ETCMethod.makeSubwayLine(lines: viewModel.lineNum))
        }
    }
    
    override func setupUI() {
        self.backgroundColor = .white
        [lineLabel].forEach { self.addSubview($0) }
    }
    
    override func setupConstraints() {
        lineLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(30)
        }
    }
    
    func makeLineLabelConstraints(line: String) {
        switch line {
        case "1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선", "9호선":
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
                $0.width.equalTo(90)
                $0.height.equalTo(30)
            }
            self.lineLabel.layer.cornerRadius = 15
        }
    }
    
    func makeLineLabelText(line: String) {
        
    }
    
}
