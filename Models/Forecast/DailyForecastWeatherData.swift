//
//  ForecastWeatherData.swift
//  Weather
//
//  Created by Sergey on 25.04.2022.
//

import Foundation

struct DailyForecastWeatherData: Codable {
    let timezone: String
    var daily: [Daily]
    let lat: Double
    let lon: Double
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
    var sunrise: Double
    var moonrise: Double
    var sunset: Double
    var moonset: Double
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
