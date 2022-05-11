//
//  ForecastWeatherModel.swift
//  Weather
//
//  Created by Sergey on 25.04.2022.
//

import Foundation

struct ForecastWeatherModel {
    
    var date: String
    var conditionID: Int
    var precipitation: String
    var description: String
    var minTemp: String
    var maxTemp: String
    
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
