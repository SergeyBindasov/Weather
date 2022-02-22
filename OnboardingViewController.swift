//
//  ViewController.swift
//  Weather
//
//  Created by Sergey on 22.02.2022.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    private lazy var girlImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: K.Images.onboarding)
       return image
    }()
    
    private lazy var permissionText: UILabel = {
        let text = UILabel()
        text.text = "Разрешить приложению  Weather использовать данные о местоположении вашего устройства"
        text.font = UIFont(name: "Rubik-Regular", size: 16)
        text.textColor = UIColor(named: K.BrandColors.whiteText)
        text.numberOfLines = 0
        return text
    }()
    
    private lazy var descriptionText: UILabel = {
        let text = UILabel()
        text.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия \n\nВы можете изменить свой выбор в любое время из меню приложения"
        text.font = UIFont(name: "Rubik-Regular", size: 14)
        text.textColor = UIColor(named: K.BrandColors.whiteText)
        text.numberOfLines = 0
        return text
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 12)
        button.backgroundColor = UIColor(named: K.BrandColors.orange)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var rejectLabel: UILabel = {
        let label = UILabel()
        label.text = "НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(named: K.BrandColors.whiteText)
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(rejectionTapped))
        rejectLabel.addGestureRecognizer(tap)
    }
}

extension OnboardingViewController {
    private func setupLayout() {
        view.backgroundColor = UIColor(named: K.BrandColors.blue)
        view.addSubviews(girlImage, permissionText, descriptionText, confirmButton, rejectLabel)
        
        girlImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(62)
            make.width.equalTo(UIScreen.main.bounds.width / 1.8)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        permissionText.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(19)
            make.top.equalTo(girlImage.snp.bottom).offset(30)
            make.trailing.equalTo(view).offset(-34)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(19)
            make.top.equalTo(permissionText.snp.bottom).offset(30)
            make.trailing.equalTo(view).offset(-34)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 40)
            make.height.equalTo(40)
            make.top.equalTo(descriptionText.snp.bottom).offset(40)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        rejectLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmButton.snp.bottom).offset(25)
            make.trailing.equalTo(view).offset(-20)
        }
    }
    
    @objc private func confirmPressed() {
        confirmButton.backgroundColor = UIColor(named: K.BrandColors.orangeDark)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.confirmButton.backgroundColor = UIColor(named: K.BrandColors.orange)
        }
        print("согласие на предоставление данных")
    }
    
    @objc private func rejectionTapped(sender:UITapGestureRecognizer) {
        print("отказ от предоставления данных")
    }
}
