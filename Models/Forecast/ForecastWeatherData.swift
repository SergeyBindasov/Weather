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
}

struct Temp: Codable {
    var min: Double
    var max: Double
}
