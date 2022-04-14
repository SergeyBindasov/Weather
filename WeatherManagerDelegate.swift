//
//  WeatherManagerDelegate.swift
//  Weather
//
//  Created by Sergey on 31.03.2022.
//

import Foundation


protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherNetworkManager, weather: WeatherModel)
    
}



