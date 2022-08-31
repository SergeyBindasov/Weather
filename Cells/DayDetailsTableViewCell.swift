//
//  DayDetailsTableViewCell.swift
//  Weather
//
//  Created by Sergey on 23.05.2022.
//

import Foundation
import UIKit
import SnapKit

class DayDetailsTableViewCell: UITableViewCell {
    
    let help = Help()
    
    private lazy var innerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: K.BrandColors.lightBlue)
      
        return view
    }()
    
    private lazy var currentDate: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        return label
    }()
    
    private lazy var currentTime: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        return label
    }()
    
    private lazy var moonImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.thermoSun)
        return image
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
       let label = UILabel()
        label.text = "По ощущению"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var feelsLikeStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(moonImage)
        stack.addArrangedSubview(feelsLikeLabel)
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var windImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.wind)
        return image
    }()
    
    private lazy var windLabel: UILabel = {
       let label = UILabel()
        label.text = "Ветер"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var windStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(windImage)
        stack.addArrangedSubview(windLabel)
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var humidityImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.drops)
        return image
    }()
    
    private lazy var humidityLabel: UILabel = {
       let label = UILabel()
        label.text = "Влажность воздуха"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var humidityStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(humidityImage)
        stack.addArrangedSubview(humidityLabel)
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var cloudImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.rainCloud)
        return image
    }()
    
    private lazy var cloudLabel: UILabel = {
       let label = UILabel()
        label.text = "Облачность"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var cloudStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(cloudImage)
        stack.addArrangedSubview(cloudLabel)
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var conditionsVerStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(feelsLikeStack)
        stack.addArrangedSubview(windStack)
        stack.addArrangedSubview(humidityStack)
        stack.addArrangedSubview(cloudStack)
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private lazy var feelsLikeResult: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private lazy var windResult: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private lazy var humidityResult: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private lazy var cloudResult: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private lazy var resultsVerStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(feelsLikeResult)
        stack.addArrangedSubview(windResult)
        stack.addArrangedSubview(humidityResult)
        stack.addArrangedSubview(cloudResult)
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension DayDetailsTableViewCell {
    
    func updateWeather(with weather: DayDetailsModel) {
        currentDate.text = weather.date
        currentTime.text = help.timeStringFromUnixTime(unixTime: weather.time) 
        temperature.text = help.inCelcius(temp: weather.currentTemp)
        if UserDefaults.standard.bool(forKey: "temp") == true {
            temperature.text = help.inCelcius(temp: weather.currentTemp)
            feelsLikeResult.text =  help.inCelcius(temp:weather.feelsLikeTemp)
            
        } else {
            temperature.text = help.inFahrenheit(temp: weather.currentTemp)
            feelsLikeResult.text =  help.inFahrenheit(temp:weather.feelsLikeTemp)
        }
        //feelsLikeResult.text = weather.feelsLikeTemp
        windResult.text = weather.wind + " " + "м/c"
        humidityResult.text = weather.humidity + "%"
        cloudResult.text = weather.cloud + "%"
    }
    
    func setupLayout() {
       
        contentView.addSubviews(innerView)
        innerView.addSubviews(currentDate, currentTime, temperature, conditionsVerStack, resultsVerStack)
        
        innerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        currentDate.snp.makeConstraints { make in
            make.top.equalTo(innerView.snp.top).offset(16)
            make.leading.equalTo(innerView).offset(16)
        }
        
        currentTime.snp.makeConstraints { make in
            make.top.equalTo(currentDate.snp.bottom).offset(8)
            make.leading.equalTo(innerView).offset(16)
        }
        
        temperature.snp.makeConstraints { make in
            make.top.equalTo(currentTime.snp.bottom).offset(10)
            make.centerX.equalTo(currentTime.snp.centerX)
        }
        
        moonImage.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        windImage.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        humidityImage.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        cloudImage.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        conditionsVerStack.snp.makeConstraints { make in
            make.leading.equalTo(currentTime.snp.trailing).offset(16)
            make.top.equalTo(currentDate.snp.bottom).offset(8)
            make.bottom.equalTo(innerView.snp.bottom).offset(-10)
        }
        
        resultsVerStack.snp.makeConstraints { make in
            make.trailing.equalTo(innerView.snp.trailing).offset(-16)
            make.centerY.equalTo(conditionsVerStack.snp.centerY)
        }
        
        
        
    }
}
