//
//  WeatherManagerDelegate.swift
//  Weather
//
//  Created by Sergey on 31.03.2022.
//

import Foundation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: CurrentWeatherNetworkManager, weather: WeatherModel)
}

protocol GeocodingManagerDelegate {
    func createNewCity(_ networkManager: GeocodingRequest, model: GeocodingModel)
}

protocol ThreeHourWeatherDelegate {
    func didUpdateHourWeather(_ weatherManager: ThreeHourWeatherNetworkManager, weather: [ThreeHourWeatherModel])
}

protocol ForecastWeatherDelegate {
    func didUpdateForecastWeather(_ weatherManager: DailyForecastWeatherNetworkManager, weather: [DailyForecastWeatherModel])
    
}

protocol DayDetailsWeatherDelegate {
    func didUpdateDayDetailsWeather(_ weatherManager: HourlyDetailsNetworkManager, weather: [DayDetailsModel])
}

protocol PollutionManagerDelegate {
    func didUpdatePollution(_ weatherManager: PollutionNetworkManager, weather: PollutionModel)
}

