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
        label.text = "14ч 27 мин"
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
        label.text = "14ч 27 мин"
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
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        setupLayout()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}

extension SunAndMoonView {
    func setupLayout() {
        backgroundColor = .white
        addSubviews(titleLable, sunHorStack, moonHorStack)
        
        help.drawLineFromPoint(start: CGPoint(x: UIScreen.main.bounds.width / 2, y: 30), toPoint: CGPoint(x: UIScreen.main.bounds.width / 2, y: 150), ofColor: UIColor(named: K.BrandColors.blue) ?? .blue, inView: self)
        
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
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(sunHorStack.snp.centerY)
        }
        
    }
}
