//
//  DetailsView.swift
//  Weather
//
//  Created by Sergey on 07.06.2022.
//

import Foundation
import UIKit
import SnapKit

class DailyDetailsView: UIView {
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
    
    private lazy var uvImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: K.WeatherIcons.sun)
        return image
    }()
    
    private lazy var uvLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.text = "УФ-индекс"
        return label
    }()
    
    private lazy var uvHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(uvImageView)
        stack.addArrangedSubview(uvLabel)
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    private lazy var uvValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var rainImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: K.WeatherIcons.rain)
        return image
    }()
    
    private lazy var rainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.text = "Дождь"
        return label
    }()
    
    private lazy var rainHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(rainImageView)
        stack.addArrangedSubview(rainLabel)
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    private lazy var rainValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var cloudImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: K.WeatherIcons.rainCloud)
        return image
    }()
    
    private lazy var cloudLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.text = "Облачность"
        return label
    }()
    
    private lazy var cloudHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(cloudImageView)
        stack.addArrangedSubview(cloudLabel)
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    private lazy var cloudValue: UILabel = {
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

extension DailyDetailsView {
    
    func updateUI(with weather: DailyForecastWeatherModel) {
        if title == "День" {
            conditionImageView.image = UIImage(named: weather.conditionName)
            if UserDefaults.standard.bool(forKey: "temp") == true {
                temperature.text = help.inCelcius(temp: weather.dayTemp)
                feelsLikeValue.text = help.inCelcius(temp: weather.feelsLikeDay)
                if UserDefaults.standard.bool(forKey: "speed") == true {
                    windValue.text = String(help.inMilesPerHour(speed: weather.wind)) + " " + "mph"
                } else { windValue.text = String(weather.wind) + " " + "ms" }
            } else {
                if UserDefaults.standard.bool(forKey: "speed") == false {
                    windValue.text = String(help.inMetersPerSecond(speed: weather.wind)) + " " + "ms"
                } else { windValue.text = String(weather.wind) + " " + "mph"}
                temperature.text = help.inFahrenheit(temp: weather.dayTemp)
                feelsLikeValue.text = help.inFahrenheit(temp: weather.feelsLikeDay)
            }
        } else {
            conditionImageView.image = UIImage(named: K.WeatherIcons.moon)
            if UserDefaults.standard.bool(forKey: "temp") == true {
                temperature.text = help.inCelcius(temp: weather.nightTemp)
                feelsLikeValue.text = help.inCelcius(temp: weather.feelsLikeNight)
                if UserDefaults.standard.bool(forKey: "speed") == true {
                    windValue.text = String(help.inMilesPerHour(speed: weather.wind)) + " " + "mph"
                } else { windValue.text = String(weather.wind) + " " + "ms" }
            } else {
                temperature.text = help.inFahrenheit(temp: weather.nightTemp)
                feelsLikeValue.text = help.inFahrenheit(temp: weather.feelsLikeNight)
                if UserDefaults.standard.bool(forKey: "speed") == false {
                    windValue.text = String(help.inMetersPerSecond(speed: weather.wind)) + " " + "ms"
                } else { windValue.text = String(weather.wind) + " " + "mph"}
            }
        }
        descritionLabel.text = weather.description.firstUppercased
        uvValue.text = weather.uvi
        rainValue.text = weather.precipitation + " " + "%"
        cloudValue.text = weather.cloud + " " + "%"
    }

    func setupLayout() {
        backgroundColor = UIColor(named: K.BrandColors.subviewBack)
        layer.cornerRadius = 5
        addSubviews(topLabel, horizontalStack, descritionLabel, feelsLikeHorizontalStack, feelsLikeValue, windHorizontalStack, windValue, uvHorizontalStack, uvValue, rainHorizontalStack, rainValue, cloudHorizontalStack, cloudValue)
        
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 145), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 145), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 1, dash: false)
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 195), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 195), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 1, dash: false)
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 245), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 245), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 1, dash: false)
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 295), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 295), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 1, dash: false)
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 345), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 345), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 1, dash: false)
        
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
        
        uvImageView.snp.makeConstraints { make in
            make.width.height.equalTo(feelsLikeImageView)
        }
        
        uvHorizontalStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(windHorizontalStack.snp.bottom).offset(20)
        }
        
        uvValue.snp.makeConstraints { make in
            make.centerY.equalTo(uvHorizontalStack.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
    }
        rainImageView.snp.makeConstraints { make in
            make.width.height.equalTo(feelsLikeImageView)
        }
        rainHorizontalStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(uvHorizontalStack.snp.bottom).offset(20)
        }
        
        rainValue.snp.makeConstraints { make in
            make.centerY.equalTo(rainHorizontalStack.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
    }
        cloudHorizontalStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(rainHorizontalStack.snp.bottom).offset(20)
        }
        
        cloudImageView.snp.makeConstraints { make in
            make.width.height.equalTo(feelsLikeImageView)
        }
        
        cloudValue.snp.makeConstraints { make in
            make.centerY.equalTo(cloudHorizontalStack.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
}


