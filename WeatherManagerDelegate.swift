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

protocol GeocodingManagerDelegate {
    func createNewCity(_ networkManager: GeocodingRequest, model: GeocodingModel)
}

protocol ThreeHourWeatherDelegate {
    func didUpdateHourWeather(_ weatherManager: ThreeHourWeatherNetworkManager, weather: [ThreeHourWeatherModel])
}

protocol ForecastWeatherDelegate {
    func didUpdateForecastWeather(_ weatherManager: ForecastWeatherNetworkManager, weather: [ForecastWeatherModel])
    
}


