//
//  ThreeHourWeatherNetworkManager.swift
//  Weather
//
//  Created by Sergey on 12.04.2022.
//

import Foundation

class ThreeHourWeatherNetworkManager {
    
    var delegate: ThreeHourWeatherDelegate?
    
    let help = Help()
    
    let threeHourForecaetUrl = "https://api.openweathermap.org/data/2.5/forecast?&appid=15155ae34e7dd30a88d9313e93a5b681&lang=ru&cnt=8"
    
    func fetchThreeHourWeatherBy(cityName: String) {
        let urlString = "\(threeHourForecaetUrl)&q=\(cityName)"
        performHourRequest(with: urlString)
        
    }
    
    func fetchWeatherBy(latitude: Double, longitude: Double) {
        let urlString = "\(help.setupString(url: threeHourForecaetUrl))&lat=\(latitude)&lon=\(longitude)"
        performHourRequest(with: urlString)
    }
    
    func performHourRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if let safeData = data {
                    if let weather = self.parseHourJSON(weatherData: safeData) {
                     
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateHourWeather(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseHourJSON(weatherData: Data) -> [ThreeHourWeatherModel]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            var models = [ThreeHourWeatherModel]()
            let decodedData = try decoder.decode(ThreeHourWeatherData.self, from: weatherData)
         
            decodedData.list.forEach { list in
                list.weather.forEach { weather in
                    let model = ThreeHourWeatherModel(time: help.timeStringFromUnixTime(unixTime: list.dt),
                                                      conditionID: weather.id,
                                                      temp:list.main.temp)
                    models.append(model)
                }
            }
            return models
        } catch {
            print(error)
            return nil
        }
    }
}
