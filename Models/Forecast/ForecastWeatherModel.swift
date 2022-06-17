//
//  ForecastWeatherModel.swift
//  Weather
//
//  Created by Sergey on 25.04.2022.
//

import Foundation

struct ForecastWeatherModel {
    
    let date: String
    let conditionID: Int
    let precipitation: String
    let description: String
    let dayTemp: String
    let nightTemp: String
    let feelsLikeDay: String
    let feelsLikeNight: String
    let minTemp: String
    let maxTemp: String
    let wind: String
    let uvi: String
    let cloud: String
    let sunrise: String
    let moonrise: String
    let sunset: String
    let moonset: String
    let sunDayTime: String
    let nightTime: String
    let timezone: String
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return K.WeatherIcons.thunder
        case 300...321:
            return K.WeatherIcons.rainAndSun
        case 500...531:
            return K.WeatherIcons.rain
        case 600...622:
            return K.WeatherIcons.snow
        case 700...781:
            return K.WeatherIcons.fog
        case 800...801:
            return K.WeatherIcons.sun
        case 802...804:
            return K.WeatherIcons.sunAndCloud
        default:
            return K.WeatherIcons.cloud
        }
    }
}
