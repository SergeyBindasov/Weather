//
//  DayWeatherViewController.swift
//  Weather
//
//  Created by Sergey on 07.06.2022.
//

import Foundation
import UIKit
import SnapKit

class DayWeatherViewController: UIViewController {
    
    var forecastModel: ForecastWeatherModel
    
    private lazy var dayView: DetailsView = {
        let view = DetailsView(frame: UIScreen.main.bounds, title: "День")
        view.updateUI(with: forecastModel)
        return view
    }()
    
    private lazy var nightView: DetailsView = {
        let view = DetailsView(frame: UIScreen.main.bounds, title: "Ночь")
        view.updateUI(with: forecastModel)
        return view
    }()
    
    init(forecastModel: ForecastWeatherModel) {
        self.forecastModel = forecastModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = forecastModel.date
        setupLayout()
    }
}

extension DayWeatherViewController {
    func setupLayout() {
        view.backgroundColor = .white
        view.addSubviews(dayView, nightView)
        
        dayView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(300)
        }
        
        nightView.snp.makeConstraints { make in
            make.top.equalTo(dayView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(300)
        }
    }
}
