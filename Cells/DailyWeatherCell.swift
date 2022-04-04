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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension DailyWeatherCell {
    func  setupLayout() {
        contentView.backgroundColor = .white//UIColor(named: K.BrandColors.blue)
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 22
        contentView.layer.borderColor = UIColor(red: 171/255.0, green: 188/255.0, blue: 234/255.0, alpha: 1.0).cgColor
    
    }
}
