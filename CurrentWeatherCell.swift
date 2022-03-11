//
//  CurrentWeatherCell.swift
//  Weather
//
//  Created by Sergey on 10.03.2022.
//

import Foundation
import UIKit
import SnapKit

class CurrentWeatherCell: UICollectionViewCell {
    
    let measurment = MeasurementHelp()
    
    private lazy var infoRect: UIView = {
       let rect = UIView()
        rect.backgroundColor = UIColor(named: K.BrandColors.blue)
        return rect
    }()
    
    private lazy var elipse: UIImageView = {
        let elipse = UIImageView()
        elipse.image = UIImage(named: K.Images.ellipse)
        return elipse
    }()
    
    private lazy var sunriseImg: UIImageView = {
        let sunrise = UIImageView()
        sunrise.image = UIImage(named: K.SystemSymbols.sunrise)?.withRenderingMode(.alwaysTemplate)
        sunrise.tintColor = UIColor(named: K.BrandColors.yellow)
        return sunrise
    }()
    
    private lazy var sunsetImg: UIImageView = {
        let sunset = UIImageView()
        sunset.image = UIImage(named: K.SystemSymbols.sunset)?.withRenderingMode(.alwaysTemplate)
        sunset.tintColor = UIColor(named: K.BrandColors.yellow)
        return sunset
    }()
    
    private lazy var sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.text = "05:41"
        return label
    }()
    
    private lazy var sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.text = "19:31"
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
      let label = UILabel()
        label.text = measurment.inCelcius(temp: 7) + " " + "/"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
     return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
      let label = UILabel()
        label.text = " " + measurment.inCelcius(temp: 13)
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
     return label
    }()
    
    private lazy var temperaturesStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(minTempLabel)
        stack.addArrangedSubview(maxTempLabel)
        stack.axis = .horizontal
        stack.spacing = 0
        return stack
    }()
    
    private lazy var mainVerticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(currentTemperatureLabel)
        stack.addArrangedSubview(descriptionLabel)
        stack.axis = .vertical
        stack.spacing = 7
        return stack
    }()
    
    
    
    private lazy var currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 36)
        label.textColor = .white
        label.textAlignment = .center
        label.text = measurment.inCelcius(temp: 13)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
        label.text = "Возможен небольшой дождь"
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension CurrentWeatherCell {
    func setupLayout() {
        contentView.addSubviews(infoRect)
        infoRect.addSubviews(elipse, sunriseImg, sunsetImg, sunriseTimeLabel, sunsetTimeLabel,temperaturesStackView, mainVerticalStackView)
        infoRect.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset( -UIScreen.main.bounds.width / 6 )
        }
        
        elipse.snp.makeConstraints { make in
            make.top.equalTo(infoRect.snp.top).offset(8)
            make.centerX.equalTo(infoRect.snp.centerX)
            make.width.equalTo(infoRect.snp.width).offset(-64)
            make.height.equalTo(infoRect.snp.height).offset(-90)
        }
        
        sunriseImg.snp.makeConstraints { make in
            make.width.height.equalTo(17)
            make.leading.equalTo(infoRect.snp.leading).offset(26)
            make.top.equalTo(elipse.snp.bottom).offset(9)
        }
        
        sunsetImg.snp.makeConstraints { make in
            make.width.height.equalTo(17)
            make.leading.equalTo(infoRect.snp.trailing).offset(-42)
            make.top.equalTo(elipse.snp.bottom).offset(9)
        }
        
        sunriseTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(sunriseImg.snp.centerX)
            make.top.equalTo(sunriseImg.snp.bottom).offset(5)
        }
        
        sunsetTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(sunsetImg.snp.centerX)
            make.top.equalTo(sunsetImg.snp.bottom).offset(5)
        }
        
        temperaturesStackView.snp.makeConstraints { make in
            make.centerX.equalTo(elipse.snp.centerX)
            make.top.equalTo(elipse.snp.top).offset(35)
        }
        
        mainVerticalStackView.snp.makeConstraints { make in
            make.centerX.equalTo(elipse.snp.centerX)
            make.top.equalTo(temperaturesStackView.snp.bottom).offset(5)
        }
        
        
    }
}
