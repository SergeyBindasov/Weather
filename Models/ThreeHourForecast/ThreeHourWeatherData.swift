//
//  ThreeHourWeatherData.swift
//  Weather
//
//  Created by Sergey on 07.04.2022.
//

import Foundation

struct ThreeHourWeatherData: Codable {
    var cnt: Int
    var list: [List]
}

struct List: Codable {
    var dt: Double
    var main: Main
    var weather: [Weather]
    var wind: Wind
    var clouds: Clouds
}


