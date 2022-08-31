//
//  AddCityView.swift
//  Weather
//
//  Created by Sergey on 28.03.2022.
//

import Foundation
import UIKit


class AddCityView: UIView {

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
        backgroundColor = .white
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension AddCityView {
    func setupLayout() {
        addSubviews(addButton)
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(UIScreen.main.bounds.width / 6)
            make.center.equalToSuperview()
        }
    }
    
    @objc func addButtonPressed() {
        print("появляется алерт")
        
    }
}
