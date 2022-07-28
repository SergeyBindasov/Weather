//
//  PollutionView.swift
//  Weather
//
//  Created by Sergey on 17.06.2022.
//

import Foundation
import UIKit
import SnapKit

class PollutionView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.text = "Качество воздуха на данный момент"
        return label
    }()
    
    private lazy var indexIDLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 30)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var disclamerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.settingsText)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Качество воздуха считается удовлетворительным и загрязнения воздуха представляются незначительными в пределах нормы"
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PollutionView {
    
    func updateUI(with weather: PollutionModel) {
        indexIDLabel.text = String(weather.aqiID)
        nameLabel.text = weather.aqiName
        nameLabel.backgroundColor = UIColor(named: weather.aqiColor)
        
    }
    func setupLayout() {
        addSubviews(titleLabel, indexIDLabel, nameLabel, disclamerLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        indexIDLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(indexIDLabel.snp.centerY)
            make.width.equalTo(110)
            make.height.equalTo(30)
            make.leading.equalTo(indexIDLabel.snp.trailing).offset(15)
        }
        
        disclamerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        
        
    }
}
