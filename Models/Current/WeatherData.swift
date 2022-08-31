//
//  WeatherData.swift
//  Weather
//
//  Created by Sergey on 30.03.2022.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
    let clouds: Clouds
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    let tempMin: Double
    let tempMax: Double
    let feelsLike: Double
   
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
}

struct Sys: Codable {
    let sunrise: Double
    let sunset: Double
}
