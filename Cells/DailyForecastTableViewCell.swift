//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Sergey on 14.04.2022.
//

import Foundation
import UIKit
import SnapKit

class DailyForecastTableViewCell: UITableViewCell {
    
    let help = Help()
    
    private lazy var innerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: K.BrandColors.subviewBack)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let date = UILabel()
        date.font = UIFont(name: "Rubik-Regular", size: 16)
        date.textColor = UIColor(named: K.BrandColors.lightText)
        return date
    }()
    
    private lazy var weatherImage: UIImageView = {
       let image = UIImageView()
       image.image = UIImage(named: K.WeatherIcons.rain)
       return image
   }()
    
    private lazy var dropsText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = UIColor(named: K.BrandColors.blue)
        return label
    }()
    
    private lazy var dropsHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(weatherImage)
        stack.addArrangedSubview(dropsText)
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.font = UIFont(name: "Rubik-Regular", size: 16)
        status.textColor = UIColor(named: K.BrandColors.blackText)
        return status
    }()
    
    private lazy var minTempLabel: UILabel = {
        let status = UILabel()
        status.font = UIFont(name: "Rubik-Regular", size: 18)
        status.textColor = UIColor(named: K.BrandColors.blackText)
        return status
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let status = UILabel()
        status.font = UIFont(name: "Rubik-Regular", size: 18)
        status.textColor = UIColor(named: K.BrandColors.blackText)
        return status
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(minTempLabel)
        stack.addArrangedSubview(maxTempLabel)
        stack.axis = .horizontal
        stack.spacing = 0
        return stack
    }()
    
    private lazy var indicatorImage: UIImageView = {
       let image = UIImageView()
       image.image = UIImage(systemName: "chevron.right")
        image.tintColor = UIColor(named: K.BrandColors.blackText)
       return image
   }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    
}

extension DailyForecastTableViewCell {
    
    func updateWeather(with weather: DailyForecastWeatherModel) {
        dateLabel.text = weather.date
        weatherImage.image = UIImage(named: weather.conditionName)
        dropsText.text = weather.precipitation + "%"
        statusLabel.text = weather.description.firstUppercased
        if UserDefaults.standard.bool(forKey: "temp") == true {
            minTempLabel.text = help.inCelcius(temp: weather.minTemp) + " " + "-" + " "
            maxTempLabel.text = help.inCelcius(temp: weather.maxTemp)
           
        } else {
            minTempLabel.text = help.inFahrenheit(temp: weather.minTemp) + " " + "-" + " "
            maxTempLabel.text = help.inFahrenheit(temp: weather.maxTemp)
        }
     
    }
        
    func  setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.addSubviews(innerView)
        innerView.addSubviews(dateLabel, dropsHorizontalStackView, statusLabel, tempStackView, indicatorImage)
        
        innerView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.width.height.lessThanOrEqualTo(17)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(innerView.snp.leading).offset(10)
            make.top.equalTo(innerView.snp.top).offset(6)
           
        }
        
        dropsHorizontalStackView.snp.makeConstraints { make in
            make.leading.equalTo(innerView.snp.leading).offset(10)
            make.top.equalTo(dateLabel.snp.bottom).offset(6)
           make.bottom.equalTo(innerView.snp.bottom).offset(-10)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(12)
            make.centerY.equalTo(innerView.snp.centerY)
        }
        
        tempStackView.snp.makeConstraints { make in
            make.centerY.equalTo(innerView.snp.centerY)
            make.trailing.equalTo(indicatorImage.snp.leading).offset(-10)
        }
        
        indicatorImage.snp.makeConstraints { make in
            make.centerY.equalTo(innerView.snp.centerY)
            make.trailing.equalTo(innerView.snp.trailing).offset(-10)
        }
    }
}


