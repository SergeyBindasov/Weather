//
//  ThreeHourWeatherNetworkManager.swift
//  Weather
//
//  Created by Sergey on 12.04.2022.
//

import Foundation

class ThreeHourWeatherNetworkManager {
    
    var delegate: ThreeHourWeatherDelegate?
    
    let help = MeasurementHelp()
    
    var temp: String = ""
    var time: String = ""
    var id: Int = 0
    
    let threeHourForecaetUrl = "https://api.openweathermap.org/data/2.5/forecast?&appid=15155ae34e7dd30a88d9313e93a5b681&lang=ru&cnt=8&units=metric"
    
    func fetchThreeHourWeatherBy(cityName: String) {
        let urlString = "\(threeHourForecaetUrl)&q=\(cityName)"
        performHourRequest(with: urlString)
        
    }
    
    func fetchWeatherBy(latitude: Double, longitude: Double) {
        let urlString = "\(threeHourForecaetUrl)&lat=\(latitude)&lon=\(longitude)"
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
            var model = ThreeHourWeatherModel(time: time, conditionID: id, temp: temp)
            decodedData.list.forEach { list in
                self.time = help.timeStringFromUnixTime(unixTime: list.dt)
                self.temp = help.inCelcius(temp: list.main.temp)
                list.weather.forEach { weather in
                    self.id = weather.id
                    model.time = time
                    model.conditionID = id
                    model.temp = temp
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
