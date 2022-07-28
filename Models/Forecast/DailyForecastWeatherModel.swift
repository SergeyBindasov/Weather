//
//  ForecastWeatherModel.swift
//  Weather
//
//  Created by Sergey on 25.04.2022.
//

import Foundation

struct DailyForecastWeatherModel {
    
    let date: String
    let conditionID: Int
    let precipitation: String
    let description: String
    let dayTemp: Double //String
    let nightTemp: Double //String
    let feelsLikeDay: Double //String
    let feelsLikeNight: Double // String
    let minTemp: Double //String
    let maxTemp: Double //String
    let wind: Double//String
    let uvi: String
    let cloud: String
    let sunrise: String
    let moonrise: String
    let sunset: String
    let moonset: String
    let sunDayTime: String
    let nightTime: String
    let timezone: String
    let lat: Double
    let lon: Double
    
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
