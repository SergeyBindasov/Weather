//
//  CurrentWeatherViewController.swift
//  Weather
//
//  Created by Sergey on 02.04.2022.
//

import Foundation
import UIKit

class CurrentWeatherViewController: UIViewController {
   
    var cityName: String
    
    var latitude: Double
    
    var longitude: Double
    
    let currentWeatherView = CurrentWeatherView()
    
    var networkManager = WeatherNetworkManager()
    
    init(cityName: String, latitude: Double, longitude: Double) {
        self.cityName = cityName
        self.latitude = latitude
        self.longitude = longitude
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = currentWeatherView
        networkManager.delegate = self
        networkManager.fetchWeatherBy(cityName: cityName)
        networkManager.fetchWeatherBy(latitude: latitude, longitude: longitude)
        
    }
}


extension CurrentWeatherViewController: WeatherManagerDelegate {
  
    func didUpdateWeather(_ weatherManager: WeatherNetworkManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.currentWeatherView.updateCurrentWeatherUI(with: weather)
        }
    }
}
