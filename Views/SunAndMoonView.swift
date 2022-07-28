//
//  SunAndMoonView.swift
//  Weather
//
//  Created by Sergey on 08.06.2022.
//

import Foundation
import UIKit
import SnapKit

class SunAndMoonView: UIView {
    
    let help = Help()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        label.text = "Солнце и луна"
        return label
    }()
    
    private lazy var sunImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.sun)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var sunDurationLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var sunHorStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(sunImageView)
        stack.addArrangedSubview(sunDurationLabel)
        stack.axis = .horizontal
        stack.spacing = 30
        return stack
    }()
    
    private lazy var moonImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: K.WeatherIcons.moon)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var moonDurationLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var moonHorStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(moonImageView)
        stack.addArrangedSubview(moonDurationLabel)
        stack.axis = .horizontal
        stack.spacing = 30
        return stack
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.text = "Восход"
        return label
    }()
    
    private lazy var sunriseValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var moonriseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.text = "Восход"
        return label
    }()
    
    private lazy var moonriseValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.text = "Закат"
        return label
    }()
    
    private lazy var moonsetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(named: K.BrandColors.lightText)
        label.text = "Закат"
        return label
    }()
    
    private lazy var sunsetValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.blackText)
        return label
    }()
    
    private lazy var moonsetValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.blackText)
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

extension SunAndMoonView {
    func updateUI(with weather: DailyForecastWeatherModel) {
        sunriseValue.text = weather.sunrise
        moonriseValue.text = weather.moonrise
        sunsetValue.text = weather.sunset
        moonsetValue.text = weather.moonset
        sunDurationLabel.text = weather.sunDayTime
        moonDurationLabel.text = weather.nightTime
        
    }
    
    
    func setupLayout() {
        backgroundColor = .white
        addSubviews(titleLable, sunHorStack, moonHorStack, sunriseLabel, sunriseValue, moonriseLabel, moonriseValue, moonsetLabel, sunsetLabel, moonsetValue, sunsetValue)
        
        help.drawLineFromPoint(start: CGPoint(x: UIScreen.main.bounds.width / 2, y: 30), toPoint: CGPoint(x: UIScreen.main.bounds.width / 2, y: 150), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 0.75, dash: false)
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 80), toPoint: CGPoint(x: (UIScreen.main.bounds.width / 2) - 15, y: 80), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 0.75, dash: true)
        help.drawLineFromPoint(start: CGPoint(x: (UIScreen.main.bounds.width / 2) + 15, y: 80), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 80), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 0.75, dash: true)
        help.drawLineFromPoint(start: CGPoint(x: 0, y: 115), toPoint: CGPoint(x: (UIScreen.main.bounds.width / 2) - 15, y: 115), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 0.75, dash: true)
        help.drawLineFromPoint(start: CGPoint(x: (UIScreen.main.bounds.width / 2) + 15, y: 115), toPoint: CGPoint(x: UIScreen.main.bounds.width - 30, y: 115), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self, opacity: 0.75, dash: true)
        
        titleLable.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        sunImageView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
        }
        
        sunHorStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(titleLable.snp.bottom).offset(15)
        }
        
        moonImageView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
        }
        
        moonHorStack.snp.makeConstraints { make in
            make.leading.equalTo((UIScreen.main.bounds.width / 2) + 15)
            make.centerY.equalTo(sunHorStack.snp.centerY)
        }
        
        sunriseLabel.snp.makeConstraints { make in
            make.top.equalTo(sunHorStack.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
        }
        
        sunriseValue.snp.makeConstraints { make in
            make.centerY.equalTo(sunriseLabel.snp.centerY)
            make.leading.equalTo(sunriseLabel.snp.trailing).offset(55)
        }
        
        moonriseLabel.snp.makeConstraints { make in
            make.top.equalTo(moonHorStack.snp.bottom).offset(20)
            make.leading.equalTo(moonHorStack)
        }
        
        moonriseValue.snp.makeConstraints { make in
            make.centerY.equalTo(moonriseLabel.snp.centerY)
            make.leading.equalTo(moonriseLabel.snp.trailing).offset(55)
        }
        
        sunsetLabel.snp.makeConstraints { make in
            make.top.equalTo(sunriseLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
        }
        
        moonsetLabel.snp.makeConstraints { make in
            make.top.equalTo(moonriseLabel.snp.bottom).offset(20)
            make.leading.equalTo(moonHorStack)
        }
        
        sunsetValue.snp.makeConstraints { make in
            make.centerY.equalTo(sunsetLabel.snp.centerY)
            make.leading.equalTo(sunriseValue)
        }
        
        moonsetValue.snp.makeConstraints { make in
            make.centerY.equalTo(moonsetLabel.snp.centerY)
            make.leading.equalTo(moonriseValue)
        }
        
    }
}
