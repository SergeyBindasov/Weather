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
    
    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
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
    
    private lazy var sunAndMoonView: SunAndMoonView = {
        let view = SunAndMoonView()
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
        view.addSubviews(scroll)
        scroll.addSubviews(dayView, nightView, sunAndMoonView)
        
        scroll.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
        }
        
        dayView.snp.makeConstraints { make in
            make.top.equalTo(scroll).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(350)
        }
        
        nightView.snp.makeConstraints { make in
            make.top.equalTo(dayView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(350)
        }
        
        sunAndMoonView.snp.makeConstraints { make in
            make.top.equalTo(nightView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(350)
            make.bottom.equalToSuperview()
        }
    }
}
