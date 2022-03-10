//
//  CurrentWeatherCell.swift
//  Weather
//
//  Created by Sergey on 10.03.2022.
//

import Foundation
import UIKit
import SnapKit

class CurrentWeatherCell: UICollectionViewCell {
    
    private lazy var infoRect: UIView = {
       let rect = UIView()
        rect.backgroundColor = UIColor(named: K.BrandColors.blue)
        return rect
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension CurrentWeatherCell {
    func setupLayout() {
        contentView.addSubviews(infoRect)
        infoRect.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset( -UIScreen.main.bounds.width / 6 )
        }
        
    }
}
