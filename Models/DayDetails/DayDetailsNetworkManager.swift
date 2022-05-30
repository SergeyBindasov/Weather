//
//  DayDetailsNetworkManager.swift
//  Weather
//
//  Created by Sergey on 23.05.2022.
//

import Foundation

class DayDetailsNetworkManager {
    
    var delegate: DayDetailsWeatherDelegate?
    
    var help = MeasurementHelp()
    
    var date: String = ""
    var time: Double = 0.0
    var currentTemp: Double = 0.0
    var feelsLikeTemp: String = ""
    var wind: String = ""
    var cloud: String = ""
    var humidity: String = ""
    
    let dayDetailsUrl = "https://api.openweathermap.org/data/2.5/forecast?&appid=15155ae34e7dd30a88d9313e93a5b681&lang=ru&cnt=8&units=metric"
    
    func fetchWeatherBy(latitude: Double, longitude: Double) {
        let urlString = "\(dayDetailsUrl)&lat=\(latitude)&lon=\(longitude)"
       performDetailsRequest(with: urlString)
    }
    
    func performDetailsRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                if let safeData = data {
                    if let weather = self.parseDetailsJSON(weatherData: safeData) {
                        
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateDayDetailsWeather(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseDetailsJSON(weatherData: Data) -> [DayDetailsModel]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            var models: [DayDetailsModel] = []
            let decodedData = try decoder.decode(DayDetailsData.self, from: weatherData)

            for list in decodedData.list {
                self.date = help.dateStringFromUnixTime(unixTime: list.dt)
                self.time = list.dt
                self.currentTemp = list.main.temp
                self.feelsLikeTemp = help.inCelcius(temp: list.main.feelsLike)
                self.wind = String(list.wind.speed)
                self.cloud = String(list.clouds.all)
                self.humidity = String(list.main.humidity)
                var model = DayDetailsModel(date: date, time: time, currentTemp: currentTemp, feelsLikeTemp: feelsLikeTemp, wind: wind, cloud: cloud, humidity: humidity)
                models.append(model)
            }

            return models
        } catch {
            print(error)
            return nil
        }
    }
    
}
