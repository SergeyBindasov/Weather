//
//  SettingsView.swift
//  Weather
//
//  Created by Sergey on 07.03.2022.
//

import Foundation
import UIKit

class SettingsView: UIView {
    
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(named: K.BrandColors.blue)
        return container
    }()
    
    private lazy var cloudOne: UIImageView = {
        let cloud = UIImageView()
        cloud.image = UIImage(named: K.Images.halfCloud)
        cloud.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 1.5, height: 60)
        return cloud
    }()
    
    private lazy var cloudTwo: UIImageView = {
        let cloud = UIImageView()
        cloud.image = UIImage(named: K.Images.cloudTop)
        cloud.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: 95)
        return cloud
    }()
    
    private lazy var cloudThree: UIImageView = {
        let cloud = UIImageView()
        cloud.image = UIImage(named: K.Images.cloudBttm)
        cloud.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 1.8, height: 65)
        return cloud
    }()
    
    private lazy var subView: UIView = {
        let subview = UIView()
        subview.backgroundColor = UIColor(named: K.BrandColors.subviewBack)
        subview.layer.cornerRadius = 10
        subview.layer.masksToBounds = true
        return subview
    }()
    
    
    private lazy var settingsTitle: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        return label
    }()
    
    private lazy var tempretureTitle: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.settingsText)
        return label
    }()
    
    private lazy var windTitle: UILabel = {
        let label = UILabel()
        label.text = "Скорость ветра"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.settingsText)
        return label
    }()
    
    
    private lazy var timeTitle: UILabel = {
        let label = UILabel()
        label.text = "Формат времени"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.settingsText)
        return label
    }()
    
    private lazy var notificationTitle: UILabel = {
        let label = UILabel()
        label.text = "Уведомления"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.settingsText)
        return label
    }()
    
    private lazy var titlesStackview: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(tempretureTitle)
        stack.addArrangedSubview(windTitle)
        stack.addArrangedSubview(timeTitle)
        stack.addArrangedSubview(notificationTitle)
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var temperatureSegmtControl: UISegmentedControl = {
        let tempArray = ["C", "F"]
        let control = UISegmentedControl(items: tempArray)
        //control.selectedSegmentIndex = 0
        control.backgroundColor = UIColor(named: K.BrandColors.segment)
        control.selectedSegmentTintColor = UIColor(named: K.BrandColors.blue)
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.addTarget(self, action: #selector(temperatueChanged), for: .valueChanged)
        return control
    }()
    
    private lazy var windSegmtControl: UISegmentedControl = {
        let windArray = ["Mi", "Km"]
        let control = UISegmentedControl(items: windArray)
        //control.selectedSegmentIndex = 1
        control.backgroundColor = UIColor(named: K.BrandColors.segment)
        control.selectedSegmentTintColor = UIColor(named: K.BrandColors.blue)
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.addTarget(self, action: #selector(windChanged), for: .valueChanged)
        return control
    }()
    
    private lazy var timeSegmtControl: UISegmentedControl = {
        let timeArray = ["12", "24"]
        let control = UISegmentedControl(items: timeArray)
        //control.selectedSegmentIndex = 1
        control.backgroundColor = UIColor(named: K.BrandColors.segment)
        control.selectedSegmentTintColor = UIColor(named: K.BrandColors.blue)
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        return control
    }()
    
    private lazy var notificationSegmtControl: UISegmentedControl = {
        let notificationArray = ["On", "Off"]
        let control = UISegmentedControl(items: notificationArray)
        //control.selectedSegmentIndex = 1
        control.backgroundColor = UIColor(named: K.BrandColors.segment)
        control.selectedSegmentTintColor = UIColor(named: K.BrandColors.blue)
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.addTarget(self, action: #selector(notifficationChanged), for: .valueChanged)
        return control
    }()
    
    private lazy var segmentedStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(temperatureSegmtControl)
        stack.addArrangedSubview(windSegmtControl)
        stack.addArrangedSubview(timeSegmtControl)
        stack.addArrangedSubview(notificationSegmtControl)
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Установить", for: .normal)
        button.backgroundColor = UIColor(named: K.BrandColors.orange)
        button.setTitleColor(UIColor(named: K.BrandColors.subviewBack), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        setupLayout()
        checkSegments()
        print(UserDefaults.standard.bool(forKey: "temp"))
        print(UserDefaults.standard.bool(forKey: "speed"))
        print(UserDefaults.standard.bool(forKey: "time"))
        print(UserDefaults.standard.bool(forKey: "notification"))


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView {
    
    func checkSegments() {
        if UserDefaults.standard.bool(forKey: "temp") == true {
            temperatureSegmtControl.selectedSegmentIndex = 0
        } else {
            temperatureSegmtControl.selectedSegmentIndex = 1
        }
        if UserDefaults.standard.bool(forKey: "speed") == true {
            windSegmtControl.selectedSegmentIndex = 0
        } else {
            windSegmtControl.selectedSegmentIndex = 1
        }
        if UserDefaults.standard.bool(forKey: "time") == true {
            timeSegmtControl.selectedSegmentIndex = 0
        } else {
            timeSegmtControl.selectedSegmentIndex = 1
        }
        if UserDefaults.standard.bool(forKey: "notification") == true {
            notificationSegmtControl.selectedSegmentIndex = 0
            } else {
                notificationSegmtControl.selectedSegmentIndex = 1
            }
    }
    
    @objc func temperatueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            SettingsChecker.shared.isTempInC()
        } else {
            SettingsChecker.shared.isTempInF()
        }
    }
    
    @objc func windChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            SettingsChecker.shared.isSpeedinMi()
           
        } else {
            SettingsChecker.shared.isSpeedinKm()
        }
    }

    
    @objc func timeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            SettingsChecker.shared.isTwelve()
        } else {
            SettingsChecker.shared.isNotTwelve()
        }
    }
    
    @objc func notifficationChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            SettingsChecker.shared.notificationIsOn()
        } else {
            SettingsChecker.shared.notificationIsOff()
        }
    }
    
    func setupLayout() {

        addSubviews(container)
        container.addSubviews(cloudOne, cloudTwo, cloudThree, subView)
        subView.addSubviews(settingsTitle, titlesStackview, settingsButton, segmentedStackView)
        
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        cloudOne.snp.makeConstraints { make in
            make.leading.top.equalTo(container.safeAreaLayoutGuide)
        }

        cloudTwo.snp.makeConstraints { make in
            make.top.equalTo(cloudOne.snp.bottom).offset(25)
            make.trailing.equalTo(container.snp.trailing).offset(-5)
        }

        cloudThree.snp.makeConstraints { make in
            make.bottom.equalTo(container.snp.bottom).offset(-100)
            make.centerX.equalTo(container.snp.centerX)
        }

        subView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(container.snp.center)
            make.width.equalTo(UIScreen.main.bounds.width - 50)
            make.height.equalTo(UIScreen.main.bounds.width - 70)
        }

        settingsTitle.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).offset(27)
            make.leading.equalTo(subView.snp.leading).offset(20)
        }

        titlesStackview.snp.makeConstraints { make in
            make.leading.equalTo(subView.snp.leading).offset(20)
            make.top.equalTo(settingsTitle.snp.bottom).offset(15)
        }

        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 120)
            make.height.equalTo(40)
            make.top.equalTo(titlesStackview.snp.bottom).offset(40)
            make.centerX.equalTo(subView.snp.centerX)
        }

        segmentedStackView.snp.makeConstraints { make in
            make.top.equalTo(settingsTitle.snp.bottom).offset(15)
            make.centerY.equalTo(titlesStackview.snp.centerY)
            make.trailing.equalTo(subView.snp.trailing).offset(-30)
        }
    }
}
