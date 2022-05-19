//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Sergey on 04.04.2022.
//

import Foundation
import UIKit
import SnapKit

class DailyWeatherCell: UICollectionViewCell {
    
    let measurment = MeasurementHelp()
    
//    var weather: ThreeHourWeatherModel? {
//        didSet {
//            if let weather = weather {
//                timeLabel.text = weather.time
//                weatherImage.image = UIImage(named: weather.conditionName)
//                weatherLabel.text = weather.temp
//            }
//        }
//    }
    
    private lazy var timeLabel: UILabel = {
        let time = UILabel()
        //time.text = "12:00"
        time.font = UIFont(name: "Rubik-Regular", size: 12)
        time.textColor = UIColor(named: K.BrandColors.lightText)
        return time
    }()
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: K.WeatherIcons.sun)
        return image
    }()
    
    private lazy var weatherLabel: UILabel = {
        let time = UILabel()
        //time.text = "17"
        time.font = UIFont(name: "Rubik-Regular", size: 16)
        time.textColor = UIColor(named: K.BrandColors.blackText)
        return time
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension DailyWeatherCell {
    
    func updateWeather(with weather: ThreeHourWeatherModel) {
        timeLabel.text = weather.time
        weatherImage.image = UIImage(named: weather.conditionName)
        weatherLabel.text = weather.temp
    }
    
    func isTapped() {
        if contentView.backgroundColor == .white {
            contentView.backgroundColor = UIColor(named: K.BrandColors.blue)
           
            timeLabel.textColor = .white
            weatherLabel.textColor = .white
        } else if contentView.backgroundColor == UIColor(named: K.BrandColors.blue) {
           
            contentView.backgroundColor = .white
            timeLabel.textColor = UIColor(named: K.BrandColors.lightText)
            weatherLabel.textColor = UIColor(named: K.BrandColors.blackText)
        }
    }
    
//    func setGradient() {
//        let colorTop =  UIColor(red: 35/255.0, green: 80/255.0, blue: 200/255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 115/255.0, green: 151/255.0, blue: 244/255.0, alpha: 1.0).cgColor
//        let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [colorTop, colorBottom]
//            gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.borderWidth = 0.5
//        gradientLayer.cornerRadius = 22
//        gradientLayer.frame = contentView.frame
//        contentView.layer.insertSublayer(gradientLayer, at: 0)
//    
//    }
    
    func  setupLayout() {
        
        contentView.backgroundColor = .white//UIColor(named: K.BrandColors.blue)
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 22
        contentView.layer.borderColor = UIColor(red: 171/255.0, green: 188/255.0, blue: 234/255.0, alpha: 1.0).cgColor
        
        contentView.addSubviews(timeLabel, weatherImage, weatherLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(8)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(20)
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImage.snp.bottom).offset(7)
        }
    
    }
}
