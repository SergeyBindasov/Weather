//
//  WeatherNetworkManager.swift
//  Weather
//
//  Created by Sergey on 29.03.2022.
//

import Foundation
import CoreLocation

struct CurrentWeatherNetworkManager {
    
    var delegate: WeatherManagerDelegate?
    
    let help = Help()
    
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=15155ae34e7dd30a88d9313e93a5b681&lang=ru"//&units=imperial"
    
    
    func fetchWeatherBy(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherBy(latitude: Double, longitude: Double) {
        
        let urlString = "\(help.setupString(url: weatherUrl))&lat=\(latitude)&lon=\(longitude)"
       
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
       
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if let safeData = data {
                    if let weather = parseJSON(weatherData: safeData) {
                      
                       //print( weather.cityName)
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //let city = decodedData.name
            //let condition = decodedData.weather[0].id
//            let sunrise = help.timeStringFromUnixTime(unixTime: decodedData.sys.sunrise)
//            let sunset = help.timeStringFromUnixTime(unixTime: decodedData.sys.sunset)
//            let minTemp = help.inCelcius(temp: decodedData.main.tempMin)
//            let maxTemp = help.inCelcius(temp: decodedData.main.tempMax)
//            let currentTemp = help.inCelcius(temp: decodedData.main.temp)
//            let description = decodedData.weather[0].description
//            let cloud = String(decodedData.clouds.all)
//            let windSpeed = String(decodedData.wind.speed)
//            let humidity = String(decodedData.main.humidity)
//            let currentWeather = WeatherModel(cityName: city, conditionId: condition, sunrise: sunrise, sunset: sunset, minTemp: minTemp, maxTemp: maxTemp, currentTemp: currentTemp, description: description, cloudiness: cloud, windSpeed: windSpeed, humidity: humidity)
            let currentWeather = WeatherModel(cityName: decodedData.name,
                                              conditionId: decodedData.weather[0].id,
                                              sunrise: decodedData.sys.sunrise,
                                              sunset: decodedData.sys.sunset,
                                              minTemp: decodedData.main.tempMin,
                                              maxTemp: decodedData.main.tempMax,
                                              currentTemp: decodedData.main.temp,
                                              description: decodedData.weather[0].description,
                                              cloudiness: decodedData.clouds.all,
                                              windSpeed: decodedData.wind.speed,
                                              humidity: decodedData.main.humidity)
            return currentWeather
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


