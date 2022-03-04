//
//  SettingsViewController.swift
//  Weather
//
//  Created by Sergey on 04.03.2022.
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
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
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        
        return view
    }()
    
    
    private lazy var settingsTitle: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
     
    }
}

extension SettingsViewController {
    func setupLayout() {
        view.backgroundColor = UIColor(named: K.BrandColors.blue)
        view.addSubviews(cloudOne, cloudTwo, cloudThree, subView)
       
        subView.addSubviews(settingsTitle)
        
        cloudOne.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        cloudTwo.snp.makeConstraints { make in
            make.top.equalTo(cloudOne.snp.bottom).offset(25)
            make.trailing.equalTo(view.snp.trailing).offset(-5)
        }
        
        cloudThree.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-100)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        subView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
}
