//
//  ForecastWeatherData.swift
//  Weather
//
//  Created by Sergey on 25.04.2022.
//

import Foundation

struct ForecastWeatherData: Codable {
    var daily: [Daily]
}

struct Daily: Codable {
    var dt: Double
    var weather: [Weather]
    var temp: Temp
    var pop: Double
    var feelsLike: FeelsLike
    var windSpeed: Double
    var uvi: Double
    var clouds: Int
}

struct Temp: Codable {
    var day: Double
    var night: Double
    var min: Double
    var max: Double
}

struct FeelsLike: Codable {
    var day: Double
    var night: Double
}
