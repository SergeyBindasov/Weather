//
//  WeatherNetworkManager.swift
//  Weather
//
//  Created by Sergey on 29.03.2022.
//

import Foundation
import CoreLocation

struct WeatherNetworkManager {
    
var delegate: WeatherManagerDelegate?
    
let help = MeasurementHelp()

let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=15155ae34e7dd30a88d9313e93a5b681&lang=ru&units=metric"
    
    
    func fetchWeatherBy(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherBy(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
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
                        delegate?.didUpdateWeather(self, weather: weather)
                        print(weather)
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
            let city = decodedData.name
            let condition = decodedData.weather[0].id
            let sunrise = help.timeStringFromUnixTime(unixTime: decodedData.sys.sunrise)
            let sunset = help.timeStringFromUnixTime(unixTime: decodedData.sys.sunset)
            let minTemp = help.inCelcius(temp: decodedData.main.tempMin)
            let maxTemp = help.inCelcius(temp: decodedData.main.tempMax)
            let currentTemp = help.inCelcius(temp: decodedData.main.temp)
            let description = decodedData.weather[0].description
            let cloud = String(decodedData.clouds.all)
            let windSpeed = String(decodedData.wind.speed)
            let humidity = String(decodedData.main.humidity)
            let currentWeather = WeatherModel(cityName: city, conditionId: condition, sunrise: sunrise, sunset: sunset, minTemp: minTemp, maxTemp: maxTemp, currentTemp: currentTemp, description: description, cloudiness: cloud, windSpeed: windSpeed, humidity: humidity)
            return currentWeather
           
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
