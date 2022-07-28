//
//  DateCell.swift
//  Weather
//
//  Created by Sergey on 17.06.2022.
//

import Foundation
import UIKit
import SnapKit

class DateCell: UICollectionViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(named: K.BrandColors.blackText)
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

extension DateCell {
    
    func updateUI(with date: DailyForecastWeatherModel) {
        dateLabel.text = date.date
    }
    
    func isSelected(condition: Bool) {
        if condition == true {
            contentView.backgroundColor = UIColor(named: K.BrandColors.blue)
            contentView.layer.cornerRadius = 5
            dateLabel.textColor = .white
        } else {
            contentView.backgroundColor = .white
            dateLabel.textColor = UIColor(named: K.BrandColors.blackText)
        }
    }
    func setupLayout() {
        contentView.addSubviews(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
