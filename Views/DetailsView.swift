//
//  DetailsView.swift
//  Weather
//
//  Created by Sergey on 07.06.2022.
//

import Foundation
import UIKit
import SnapKit

class DetailsView: UIView {
    var help = Help()
    
    var title: String
    
    private lazy var topLabel: UILabel = {
        var label = UILabel()
        label.text = title
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var conditionImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 30)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(conditionImageView)
        stack.addArrangedSubview(temperature)
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var descritionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var feelsLikeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: K.WeatherIcons.thermoSun)
        return image
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.text = "По ощущениям"
        return label
    }()
    
    private lazy var feelsLikeHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(feelsLikeImageView)
        stack.addArrangedSubview(feelsLikeLabel)
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    private lazy var feelsLikeValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var windImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: K.WeatherIcons.wind)
        return image
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.text = "Ветер"
        return label
    }()
    
    private lazy var windHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(windImageView)
        stack.addArrangedSubview(windLabel)
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    private lazy var windValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    
    

    
    
    
    
    
    
 init(frame: CGRect, title: String) {
        self.title = title
        super.init(frame: frame)
     setupLayout()
     
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailsView {
    
    func updateUI(with weather: ForecastWeatherModel) {
        if title == "День" {
            temperature.text = weather.dayTemp
            conditionImageView.image = UIImage(named: weather.conditionName)
            feelsLikeValue.text = weather.feelsLikeDay
        } else {
            temperature.text = weather.nightTemp
            conditionImageView.image = UIImage(named: K.WeatherIcons.moon)
            feelsLikeValue.text = weather.feelsLikeNight
        }
        descritionLabel.text = weather.description.firstUppercased
        windValue.text = weather.wind + " " + "м/c"
    }
    
   
    
    func setupLayout() {
        backgroundColor = UIColor(named: K.BrandColors.subviewBack)
        addSubviews(topLabel, horizontalStack, descritionLabel, feelsLikeHorizontalStack, feelsLikeValue, windHorizontalStack, windValue)
        
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 145), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 145), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self)
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 195), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 195), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self)
        
        topLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.width.height.equalTo(temperature.snp.height)
        }
        
        horizontalStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(topLabel.snp.centerY)
        }
        
        descritionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(horizontalStack.snp.bottom).offset(10)
        }
        
        feelsLikeHorizontalStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(descritionLabel.snp.bottom).offset(25)
        }
        
        feelsLikeValue.snp.makeConstraints { make in
            make.centerY.equalTo(feelsLikeHorizontalStack.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        windImageView.snp.makeConstraints { make in
            make.width.height.equalTo(feelsLikeImageView)
        }
        windHorizontalStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(feelsLikeHorizontalStack.snp.bottom).offset(20)
        }
        
        windValue.snp.makeConstraints { make in
            make.centerY.equalTo(windHorizontalStack.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
}


