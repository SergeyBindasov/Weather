//
//  AddCityCell.swift
//  Weather
//
//  Created by Sergey on 10.03.2022.
//

import Foundation
import UIKit
import SnapKit

class AddCityCell: UICollectionViewCell {
    

    private lazy var addButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = UIColor(named: K.BrandColors.blue)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension AddCityCell {
    func setupLayout() {
        contentView.addSubviews(addButton)
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(UIScreen.main.bounds.width / 6)
            make.center.equalTo(contentView.snp.center)
        }
    }
    
    @objc func addButtonPressed() {
        print("появляется алерт")
        
    }
}
