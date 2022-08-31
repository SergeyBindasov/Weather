//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Sergey on 28.03.2022.
//

import Foundation
import UIKit
import SnapKit

class CurrentWeatherView: UIView {
    
    let help = Help()
    
    private lazy var cityLabel: UILabel = {
       var label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var infoRect: UIView = {
       let rect = UIView()
        rect.backgroundColor = UIColor(named: K.BrandColors.blue)
        rect.layer.cornerRadius = 5
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
        return label
    }()
    
    private lazy var sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
      let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
     return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
      let label = UILabel()
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
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cloudImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.sunAndCloud)
        return image
    }()
    
    private lazy var cloudText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var cloudHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(cloudImg)
        stack.addArrangedSubview(cloudText)
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var windImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.wind)
        return image
    }()
    
    private lazy var windText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var windHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(windImg)
        stack.addArrangedSubview(windText)
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var dropsImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.drops)
        return image
    }()
    
    private lazy var dropsText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var dropsHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(dropsImg)
        stack.addArrangedSubview(dropsText)
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var mainHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(cloudHorizontalStackView)
        stack.addArrangedSubview(windHorizontalStackView)
        stack.addArrangedSubview(dropsHorizontalStackView)
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    private lazy var currentDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.yellow)
        label.text = Date().getCurrentDate()
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

extension CurrentWeatherView {
    
    func updateCurrentWeatherUI(with weather: WeatherModel) {
        cityLabel.text = weather.cityName
        sunriseTimeLabel.text = help.timeStringFromUnixTime(unixTime: weather.sunrise)
        sunsetTimeLabel.text =  help.timeStringFromUnixTime(unixTime: weather.sunset)
       if UserDefaults.standard.bool(forKey: "temp") == true {
            minTempLabel.text = help.inCelcius(temp: weather.minTemp) + " " + "/"
            maxTempLabel.text = " " + help.inCelcius(temp:weather.maxTemp)
            currentTemperatureLabel.text = help.inCelcius(temp: weather.currentTemp)
           if UserDefaults.standard.bool(forKey: "speed") == true {
               windText.text = String(help.inMilesPerHour(speed: weather.windSpeed)) + " " + "mph"
           } else {
            windText.text = String(weather.windSpeed) + " " + "ms"
           }
        } else {
            minTempLabel.text = help.inFahrenheit(temp: weather.minTemp) + " " + "/"
            maxTempLabel.text = " " + help.inFahrenheit(temp:weather.maxTemp)
            currentTemperatureLabel.text = help.inFahrenheit(temp: weather.currentTemp)
            if UserDefaults.standard.bool(forKey: "speed") == false {
                windText.text = String(help.inMetersPerSecond(speed: weather.windSpeed)) + " " + "ms"
            } else {
                windText.text = String(weather.windSpeed) + " " + "mph"
            }
        }
    
       

        
        
        descriptionLabel.text = weather.description.firstUppercased
        cloudText.text = String(weather.cloudiness)
        dropsText.text = String(weather.humidity) + " " + "%"
        

        }
        
    
    
    func setupLayout() {
        backgroundColor = .white
        addSubviews(cityLabel, infoRect)
        infoRect.addSubviews(elipse, sunriseImg, sunsetImg, sunriseTimeLabel, sunsetTimeLabel,temperaturesStackView, mainVerticalStackView, mainHorizontalStackView, currentDateLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalTo(infoRect.snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        infoRect.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(currentDateLabel.snp.bottom).offset(15)
            make.top.equalTo(cityLabel.snp.bottom).offset(5)
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
        
        mainHorizontalStackView.snp.makeConstraints { make in
            make.centerX.equalTo(elipse.snp.centerX)
            make.top.equalTo(mainVerticalStackView.snp.bottom).offset(12)
        }
        
        currentDateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(elipse.snp.centerX)
            make.top.equalTo(mainHorizontalStackView.snp.bottom).offset(10)
        }
        
        
    }
}
